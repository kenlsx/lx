$(function(){
    function load(pno=0){
        if (location.search.indexOf("kw=") != -1) {
            var kw = decodeURI(location.search.split("=")[1]);
            $.ajax({
                url: "http://127.0.0.1:6060/products/",
                type: "get",
                data: { kw, pno },
                dataType: "json",
                success: function (data) {
                    var { pno, pageCount, products } = data;
                    var html = "";
                    for (var { md, price, title, lid } of products) {
                        html += `<div class="product">
                    <a href="product_details.html?lid=${lid}" class="p_bg"><img src="${md}" alt=""></a>
                    <div class="details">
                        <h3 class="price">¥${price.toFixed(2)}</h3>
                        <a href="#"><span>${title}</span></a>
                    </div>
                    <div class="cart">
                        <button>-</button> <span>1</span> <button>+</button> <input type="button" data-id="${lid}" value="加入购物车">
                    </div>
                    </div>`;
                    };
                    $(".content").html(html);

                    var html = `<a href="#" >上一页</a>`;
                    for (var i = 1; i <= pageCount; i++) {
                        html += `<a href="#" class="${pno == i - 1 ? 'active' : ''}" >${i}</a>`;
                    }
                    html += `<a href="#" >下一页</a>`;
                    $(".pager").html(html);
                    if (pno == 0)
                        $(".pager").children(":first").addClass("disabled")
                    if (pno == pageCount - 1)
                        $(".pager").children(":last").addClass("disabled");
                    //增加与减少功能
                    $(".container>.content").on("click","button",function(){
                        var btn = $(this);
                        var n = btn.parent().children("span");
                        var i = parseInt(n.html());
                        if(btn.html()=="+"){
                            i++;
                        }else if(i>1){
                            i--;
                        }
                        n.html(i);
                    });
                    //添加购物车
                    $(".container>.content").on("click","input",function(){
                        var input = $(this);
                        var a = input.parent().parent().children("a");
                        var span = input.parent().children("span");
                        var lid = a.attr("href").split("=")[1];
                        var num = span.html();
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
                }
            });
        }
    };
    load();
    $(".pager").on("click", "a", function (e) {
        e.preventDefault();
        var $a = $(this);
        if (!$a.is(".disabled,.active")) {
            if ($a.html() == "上一页") {
                pno = parseInt($(".pager").children(".active").html())-2;
            } else if ($a.html() == "下一页") {
                pno = parseInt($(".pager").children(".active").html());
            } else {
                pno = $a.html()-1;
            }
            load(pno);
        }
    });
})