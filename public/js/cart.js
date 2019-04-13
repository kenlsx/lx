new Vue({
    el:"#main",
    data:{
        islogin:false,
        isblank:false,
        res:[],
        count:0
    },
    computed:{
        total(){

        }
    },
    methods:{

    },
    created(){
        (async function(self){
            var res =await axios.get("http://127.0.0.1:6060/users/cart");
            console.log(res.data);
            if(res.data.ok==0){
                self.isblank = true;
            }else if(res.data.products.length==0){
                self.islogin = true;
            }else{
                self.count = res.data.count.count;
                self.res = res.data.products;
                console.log(self.count);
                console.log(self.res);
            }
        })(this);
    }
})