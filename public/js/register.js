$(function(){
    var uname = $("#container>.content>.regist>.uname");
    var upwd = $("#container>.content>.regist>.upwd1");
    var rest = $(".rest");
    $("#container>.content>.regist>.button").click(function () {
         $.ajax({
            url: "http://127.0.0.1:6060/register/",
            type: "post",
            data: {uname:uname.val(),upwd:upwd.val()},
            success: function (res) {
                if(res.code==200){
                    alert("注册成功,即将跳转到登录页面");
                    location.href = "login.html"
                }
             }
        })
    });
    
});