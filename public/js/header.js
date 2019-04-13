var vm;
$(function(){
    $(`<link rel="stylesheet" href="css/header.css">`).appendTo("head")
    $.ajax({
        url:"header.html",
        type:"get",
        success:function(res){
            $(res).replaceAll("#header");
            vm = new Vue({
                el: "#header",
                data: {
                    islogin: false,
                    keyword: "",
                    uname:""
                },
                mounted(){
                    var self = this;
                    axios.get("http://127.0.0.1:6060/users/islogin").then(res => {
                        if(res.data.ok==1){
                            self.islogin = true;
                            self.uname = res.data.uname;
                            //console.log(11111);
                        } else{
                            self.islogin = false;
                            //console.log(22222);
                        }
                          
                    })
                },
                methods: {
                    search_click(e) {
                        e.preventDefault();
                        location.href =
                            `http://127.0.0.1:6060/products.html?kw=${this.keyword}`
                    },
                    signout(){
                        axios.get("http://127.0.0.1:6060/users/signout").then(res => {
                            history.go(0)
                        })
                    }
                }
            });

            var input =
                $("#search>input");
            var search = $("#search>a");
            if (location.search.indexOf("kw=") != -1) {
                var kw = location.search.split("=")[1]
                input.val(decodeURI(kw));
            }
        }
    })
});