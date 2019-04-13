new Vue({
    el:"#container",
    data:function(){
        return {
            uname:"",
            upwd:""
        }
    },
    methods:{
        login(){
            var self=this;
            axios.post(
                "http://127.0.0.1:6060/users/signin",Qs.stringify({
                    uname:self.uname,upwd:self.upwd
                })
            ).then(res=>{
            if(res.data.ok==1){
                alert("登录成功，返回首页");
                location.href ="http://127.0.0.1:6060"
            }else{
                alert("用户名或密码错误！");
                }
            }) 
        }
    }
});