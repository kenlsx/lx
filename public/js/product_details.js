(async function () {
    if (location.search.indexOf("lid=") != -1) {
        var lid = location.search.split("=")[1];
        var res = await axios.get("http://127.0.0.1:6060/details", {
            params: {
                lid: lid,
            }
        });
        var { product, specs, pics } = res.data;
        var { title, subtitle, price, promise,lname } = product;
        var html = `
                <h1>${title}</h1>
                <h3>${subtitle}</h3>
                <div class="price">
                    <div class="pro_price">
                        <b>官方售价: </b>
                        <span>¥${price.toFixed(2)}</span>
                        <div class="promise">${promise}</div>
                    </div>
                </div>
               `;
        var right = document.getElementById("right");
        right.innerHTML=html+right.innerHTML;

        var h3 = document.querySelector("#product_main");
        var pro_title = `<h3>首页>商品详情>${lname}</h3>`
        h3.innerHTML = pro_title;

        var html = "";
        //遍历specs中每个规格对象
        for (var s of specs) {
            html += `<a href="product_details.html?lid=${s.lid}" class="${s.lid == lid ? 'active' : ''}" >${s.spec}</a>`;
        }
        var pro_specs = document.getElementById("pro_specs");
        pro_specs.innerHTML = html;
        //小图片
        var html = "";
        for (var p of pics) {
            var { sm, md, lg } = p
            html += `<li>
            <img src="${sm}" data-md="${md}" data-lg="${lg}">
            </li>`;
        }
        var ul = document.querySelector(".banner>div>ul");
        ul.innerHTML = html;
        ul.style.width = `${62 * pics.length}px`;
        var mImg = document.querySelector(".content>.left>a>.md_msg");
        mImg.src = pics[0].md;
        var lgDiv = document.getElementById("div-lg");
        lgDiv.style.backgroundImage = `url(${pics[0].lg})`;
    }

    var prev = $(".banner>.a_left");
    var ul = $(".banner>div>ul");
    var next = $(".banner>.a_right");
    console.log(next);
    var moved = 0, LIWIDTH = 62;
    next.click(function () {
        var next = $(this);
        if (!next.is(".disabled")) {
            moved++;
            ul.css("marginLeft", -LIWIDTH * moved);
            prev.removeClass("disabled");
            if (ul.children().length - 5 == moved) {
                next.addClass("disabled");
            }
        }
    })
    prev.click(function () {
        var prev = $(this);
        if (!prev.is(".disabled")) {
            moved--;
            ul.css("marginLeft", -LIWIDTH * moved);
            next.removeClass("disabled");
            if (moved <= 0) {
                prev.addClass("disabled");
            }
        }
    });

    var mdImg = $(".content>.left>a>.md_msg");
    var lgDiv = $("#div-lg");
    var ul = $(".banner>div>ul");
    ul.on("mouseover","img",function(){
        var md = $(this).attr("data-md");
        var lg = $(this).attr("data-lg");
        mdImg.attr("src",md);
        lgDiv.css("backgroundImage",`url(${lg})`);
    });

    var MSIZE = 303.75, SMSIZE = 450, MAX = SMSIZE - MSIZE;
    $("#super-mask").hover(function(){
        $("#mask").toggle();
        lgDiv.toggle();
    }).mousemove(function(e){
        var top = e.offsetY-MSIZE/2;
        var left = e.offsetX-MSIZE/2;
        if(top<0) top = 0; else if(top>MAX)top = MAX;
        if(left<0) left = 0; else if(left>MAX)left = MAX;
        $("#mask").css({ top, left });
        lgDiv.css(
            "backgroundPosition",
            `${-80/45*left}px ${-80/45*top}px`
        )
    })
    //数量加减
    $(".num").on("click", "button", function () {
        var btn = $(this);
        var n = btn.parent().children("span");
        var i = parseInt(n.html());
        if (btn.html() == "+") {
            i++;
        } else if (i > 0) {
            i--;
        }
        n.html(i);
    });

    //加入购物车
    var lid = location.search.split("=")[1];
    $(".shops>.cart").click(function(){
        var but = $(this);
        var num = $(".num .node_num").html();
        $.ajax({
            type:"get",
            url:"http://127.0.0.1:6060/users/",
            data:{lid,num},
            dataType:"json",
            success:function(data){
                if(data.ok==0){
                    alert("您还未登录,请先登录");
                }else{
                    alert("添加成功");
                };
            }
        });
    });
})();
