(function(){
    //选择系列
    $("[data-toggle=tab]").mouseenter(function () {
        $(this).css("color", "#e2231a").siblings().css("color", "black");
        var id = "#" + $(this).attr("data-target");
        $(id).css("z-index", 100).siblings().css("z-index", 1);
    });
    $("[data-toggle=tab1]").mouseenter(function () {
        $(this).css("color", "#e2231a").siblings().css("color", "black");
        var id = "#" + $(this).attr("data-target");
        $(id).css("z-index", 100).siblings().css("z-index", 1);
    });
    $("[data-toggle=tab2]").mouseenter(function () {
        $(this).css("color", "#e2231a").siblings().css("color", "black");
        var id = "#" + $(this).attr("data-target");
        $(id).css("z-index", 100).siblings().css("z-index", 1);
    })
    //轮播
    var count = 0;
    var isgo = false;
    var timer;
    var box = $(".ban_box");
    var img = $(".ban_box img");
    //封装一个函数
    function showtime(){
        timer = setInterval(function(){
            if(isgo == false){
                count++;
                box.css("left",-1200*count);
                if(count >= img.length - 1){
                    count = img.length - 1;
                    isgo = true;
                }
            }else{
                count--;
                box.css("left",-1200*count);
                if(count <= 0 ){
                    count = 0;
                    isgo = false;
                }
            }
            $(".banner_idx>li").eq(count).addClass("banner_active").siblings().removeClass("banner_active")
        },3000);
    }
    showtime();
    $(".banner_idx>li")
    box.mouseenter(function(){
        clearInterval(timer)
    });
    box.mouseleave(function(){
        showtime();
    });
    //左右两个箭头
    var prev = $("#banner_prev");
    var next = $("#banner_next");
    prev.click(function(){
        count--;
        if(count<0){
            count = 4
        }
        box.css("left",-1200*count);
    });
    next.click(function(){
        count++;
        if(count>4){
            count = 0;
        }
        box.css("left",-1200*count);
    });
    //圆点控制轮播
    var li = $(".banner_idx>li");
    li.click(function(){
        var i = $(this).index();
        box.css("left",-1200*i);
        $(this).addClass("banner_active").siblings().removeClass("banner_active")
    });

    //固定导航随滚动消失出现
    var one = $("#one").offset().top;
    var two = $("#two").offset().top;
    var three = $("#three").offset().top;
    $(window).scroll(function(){
        var scrollH = $(this).scrollTop();
        if(scrollH>=three){
            $(".three").addClass("cur").siblings().removeClass("cur");
        }else if(scrollH>=two){
            $(".two").addClass("cur").siblings().removeClass("cur");
        }else if(scrollH>=one){
            $(".one").addClass("cur").siblings().removeClass("cur");
            $(".left_side").css("display", "block");
            $(".side").css("display","block");
        }else {
            $(".left_side").css("display", "none");
            $(".side").css("display", "none");
        }
    });
    $(".left_side li").click(function(){
        var id = $(this).attr("class");
        $('html').animate({
            scrollTop: $("#"+id).offset().top
        }, 300);
    });
})();

new Vue({
    el:"#main",
    data:{
        res:[]
    },
    methods:{
       
    },
    created(){
        (async function(self){
            var res =await axios.get("http://127.0.0.1:6060/index/");
            self.res = res.data;
        })(this);
    }
});