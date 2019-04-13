jQuery.support.cors = true;
(function (window, document, $) {
    // 本地模拟一个 。。。
    if (window.location.hostname == "localhost") {
        window["passport"] = {
            isLogin: function () {
                return true;
            },
            show: function () {
                console.log("登录");
            },
            addLoginCallback: function () { },
            addLogoutCallback: function () { },
            ticket: "e40e7004-4c8a-4963-8564-31271a8337d8"
        };
    }
    // 兼容旧环境（Polyfill）
    if (!Array.prototype.filter) {
        Array.prototype.filter = function (fun /* , thisArg*/) {
            "use strict";
            if (this === void 0 || this === null)
                throw new TypeError();
            var t = Object(this);
            var len = t.length >>> 0;
            if (typeof fun !== "function")
                throw new TypeError();
            var res = [];
            var thisArg = arguments.length >= 2 ? arguments[1] : void 0;
            for (var i = 0; i < len; i++) {
                if (i in t) {
                    var val = t[i];
                    // NOTE: Technically this should Object.defineProperty at
                    //       the next index, as push can be affected by
                    //       properties on Object.prototype and Array.prototype.
                    //       But that method's new, and collisions should be
                    //       rare, so use the more-compatible alternative.
                    if (fun.call(thisArg, val, i, t))
                        res.push(val);
                }
            }
            return res;
        };
    }
    /**
     * 模板类
     */
    var dataTemplate = /** @class */ (function () {
        function dataTemplate(options) {
            if (options === void 0) { options = {}; }
            //默认配置
            this.defaults = {
                // 商品 数据 模板对应字段
                // commodity: {
                noName: "no-name",
                img: "img",
                name: "name",
                money: "money",
                noMoney: "ct-c-noMoney",
                integral: "integral",
                company: "消费积分",
                href: "javascript:void(0)"
                // }
            };
            
            //配置
            this.options = {};
            // 模板
            this.Template = "\n<li class=\"ct-commodity-item\">\n<a class=\"ct-a ct-block\" target=\"_blank\" href=\"<#href#>\">\n<div class=\"ct-c-img <#noName#>\">\n<img src=\"<#img#>\" alt=\"\">\n</div>\n<div class=\"ct-c-txt\">\n<p><#name#></p>\n<p class=\"ct-c-money\">\n<span class=\"<#noMoney#>\">  <span class=\"txt-c-01\">\uFFE5<#money#></span>+</span> \n <span class=\"txt-c-01\"><#integral#></span><#company#></p>\n</div>\n</a>\n</li>\n";
            this.options = $.extend({}, this.defaults, options);
            // console.log("commodity", options, this);
        }
        /**
         * 创建 商品 根据占位符替换对应的 数据
         * @param data 数据
         */
        dataTemplate.prototype.create = function (data) {
            var tpl = this.Template;
            for (var key in this.options) {
                if (this.options.hasOwnProperty(key)) {
                    var reg = "<#" + key + "#>";
                    var val = typeof data[key] == "undefined" ? this.options[key] : data[key];
                    // if (key == "noName" || key == "name") {
                    // 如果有名字就去除 no-name 样式的替换
                    if (key == "noName" && data[this.options.name]) {
                        val = "";
                    }
                    //去掉名字的替换
                    if (key == "name" && !data[this.options.name]) {
                        val = "";
                    }
                    if (key == "noMoney") {
                        if (data["money"] > 0) {
                            val = "";
                        }
                    }
                    // }
                    tpl = tpl.replace(reg, val);
                }
            }
        
            return tpl;
        };
        return dataTemplate;
    }());
    /**
     * 数据控制器
     */
    var Controller = /** @class */ (function () {
        function Controller(options) {
            if (options === void 0) { options = {}; }
            // 默认配置
            this.defaults = {
                href: "?virtual_currency_area=0",
                commodity: {},
                // 是否是生产服务器
                isProduction: window.location.hostname.indexOf("https://shop.lenovo.com.cn/consumptionPoint/js/lenovo.com.cn") > 0,
                // 数据请求地址
                // url: window.location.hostname.indexOf("https://shop.lenovo.com.cn/consumptionPoint/js/lenovo.com.cn") > 0 ? "https://s.lenovo.com.cn/" : "https://s.lenovouat.com/",
                // 数据请求参数
                params: {
                    
                    
                },
                url: "",
                integral:"",
                type:"",
                canBeLoaded: true, //继续加载

            };
            // 配置
            this.options = {};
            if (!options.container) {
                throw "没有可接收数据容器";
            }
            this.options = $.extend({}, this.defaults, options);
            this.container = this.options.container;
            this.foote = this.container.find(".ct-footer");
            this.loading = this.foote.find(".ct-loading");
            this.footerMore = this.foote.find(".ct-footer-more");
            this.dataTemplate = new dataTemplate(this.options.commodity);
            // console.log("Controller", this);
            this.inti();
        }
        /**
         * 初始化
         */
        Controller.prototype.inti = function () {
            var _this = this;
            this.getData();
            this.bindEvent();
            this.getIntegral();
            // if (window["passport"]) {
            passport.addLoginCallback && passport.addLoginCallback(function () {
                _this.getIntegral();
            });
            passport.addLoginCallback && passport.addLogoutCallback(function () {
                _this.getIntegral();
            });
            // }
        };
        /**
         * 绑定事件
         */
        Controller.prototype.bindEvent = function () {
            var _this = this;
            this.footerMore.on("click", function (e) {
                // 配置了onfooterMore 事件 执行 onfooterMore 事件
                if (_this.options.onfooterMore) {
                    _this.options.onfooterMore.call(_this, e);
                }
                else {
                    // console.log("click", this.isLoading);
                    if (!_this.options.canBeLoaded || _this.isLoading) {
                        return;
                    }
                    _this.getData();
                }
                // this.options.onfooterMore ? this.options.onfooterMore.call(this, e) : this.getData();
            });
            //监听滚轮触发事件
            // $(window).on("scroll", function () {
            //     var height = $(window).height();
            //     var scrollTop = $(window).scrollTop();
            //     var top = _this.foote.offset().top;
            //     if (height + scrollTop >= top) {
            //         _this.footerMore.trigger("click");
            //     }
            // });
        };
        Controller.prototype.getIntegral = function () {
            var _this = this;
            // let url = "";
            // if (window.location.hostname.indexOf("https://shop.lenovo.com.cn/consumptionPoint/js/lenovo.com.cn") > 0) {
            //     url = "https://i.lenovo.com.cn/";
            // } else {
            //     url = "https://i.lenovouat.com/";
            // }
            // 登录操作
            // if (window["passport"]) {
            if (passport.isLogin()) {
                var ticket = passport.ticket || "e40e7004-4c8a-4963-8564-31271a8337d8";
                $.ajax({
                    type: "get",
                    async: false,
                    url: (this.options.isProduction ? "https://i.lenovo.com.cn/" : "https://i.lenovouat.com/") + "/dubboScore/searchTotal.jhtml",
                    data: {
                        sts: ticket,
                        type:this.options.type
                    },
                    dataType: "jsonp",
                    jsonp: "callback",
                    // jsonpCallback: "flightHandlers",
                    success: function (json) {
                        // json.data = json.data || {};
                        // _this.container.find(".ct-head>.title-num .ct-a").attr("href", "https://shop.lenovo.com.cn/consumptionPoint/js/list.html");
                       
                            if(_this.options.type=="1"){
                                // if (_this.options.params.plat == 1) {
                                //     _this.container.find("#consumption .ct-head>.title-num .ct-a").attr("href", "https://i.lenovo.com.cn/memberInfo/toscoreDetail.jhtml?sts=6c7cd6ad-d845-49d8-93be-939f4fb58f88 ");
                                // }
                                //  _this.container.find(".ct-head>.title-num .ct-a").attr("href", "https://shop.lenovo.com.cn/consumptionPoint/js/list.html");
                                    // _this.container.find("#consumption .ct-head>.title-num .ct-a").unbind("click");
                                _this.container.find(".ct-head>.title-num .ledou").html(json.data || 0);
                            }else{
                                // if (_this.options.params.plat == 1) {
                                //     _this.container.find("#gold .ct-head>.title-num .ct-a").attr("href", "https://i.lenovo.com.cn/memberInfo/toscoreDetail.jhtml?sts=6c7cd6ad-d845-49d8-93be-939f4fb58f88");
                                // }
                                    // _this.container.find("#gold .ct-head>.title-num .ct-a").attr("href", "https://i.lenovouat.com/ledou/list.jhtml?sts=e40e7004-4c8a-4963-8564-31271a8337d8");
                                _this.container.find(".ct-head>.title-num .jifen").html(json.data && json.data.totalValue || 0);
                            }
                           
                       
                       
                    },
                    error: function () {
                    }
                });
            }
            else {
                if (this.options.params.plat == 1) {
                    // window.location.href="https://reg.lenovo.com.cn/auth/v1/login?ticket=b044d754-bda2-4f56-9fea-dcf3aecfe782&iswap=0&ru=https%3A%2F%2Fi.lenovo.com.cn%2Finfo%2Fcenter.jhtml%3Fsts%3Db044d754-bda2-4f56-9fea-dcf3aecfe782"
                    this.container.find(".ct-head>.title-num ").html("");
                }
                else {
                    this.container.find(".ct-head>.title-num .ct-a").attr("href", "javascript:void(0)");
                    this.container.find(".ct-head>.title-num .ct-a").on("click", function () {
                        passport.show();
                    });
                    this.container.find(".ct-head>.title-num .ct-title-two").html("未登录");
                }
            }
            // }
        };
        /**
         * 获取数据
         */
        Controller.prototype.getData = function () {
            var _this = this;
            // this.footerMore.hide();
            this.isLoading = true;
            // console.log("getData", this.isLoading);
            this.loading.show();
            // debugger
            // setTimeout(() => {
            //     const data = [
            //         { img: "./img/t.png", name: "联想智能手表1", money: 100, integral: 1000 },
            //         { img: "./img/t.png", name: "联想智能手表2", money: 100, integral: 1000 },
            //         { img: "./img/t.png", name: "联想智能手表3", money: 100, integral: 1000 },
            //         { img: "./img/tt.png", money: 100, integral: 1000, href: "https://www.baidu.com/" }, //没有name的数据
            //         { img: "./img/t.png", name: "联想智能手表5", money: 100, integral: 1000 },
            //     ];
            //     let tpl = data.map(x => this.dataTemplate.create(x));
            //     this.container.find(".ct-commodity").append(tpl.join(" "));
            //     this.footerMore.show();
            //     this.loading.hide();
            // }, 1000);
            $.ajax({
                type: "get",
                async: false,
                url: (this.options.isProduction ? "https://s.lenovo.com.cn/" : "https://s.lenovouat.com/") + this.options.url,
                data: this.options.params,
                dataType: "json",
                jsonp: "callback",
                jsonpCallback: "searchJSONP",
                success: function (json) {
                    try {
                        // const data = JSON.parse(json);
                      
                        if (typeof json == 'string') {  
                            var data_1 =  JSON.parse(json);
                            }else{
                                var data_1=json;
                            }    
                        // console.log(data);
                        // 渲染成功的数据
                        setTimeout(function () {
                            _this.success(data_1);
                            // 计算下一页
                            if (data_1.totalNum <= _this.options.params.pageSize) {
                                _this.container.find(".ct-footer").hide();
                                _this.options.canBeLoaded = false;
                            }
                            else {
                                var totalNum = _this.options.params.pageSize * _this.options.params.page;
                                if (totalNum >= data_1.totalNum) {
                                    _this.options.canBeLoaded = false;
                                }
                            }
                            // 没有数据了
                            if (!_this.options.canBeLoaded && !_this.options.onfooterMore) {
                                _this.container.find(".ct-footer").show();
                                if(data_1.items.length==0){
                                    _this.footerMore.find("span").html("暂无数据");
                                }else{
                                    _this.footerMore.find("span").html("没有了");
                                }
                                
                            }
                            else {
                                _this.options.params.page += 1;
                            }
                        });
                    }
                    catch (error) {
                        console.log(1);
                        console.error(error);
                    }
                },
                error: function (error) {
                    console.log(2);
                    console.error(error);
                }
            });
        };
        // 处理成功数据
        Controller.prototype.success = function (data) {
            var _this = this;
            var isLenovoAPP = /lenovomallapp/i.test(navigator.userAgent);
            var isLenovoOfficialApp = /lenovoofficialapp/i.test(navigator.userAgent);
            var isApp = isLenovoAPP || isLenovoOfficialApp;
          if(this.options.url=="/search/v2"){
            var tpl = data.items.map(function (x) {
                var virtualPrice = {};
                try {
                    if(x.v_1){
                        var virtualPrices = JSON.parse(x.v_1.replace(/'/g, '"'));
                    }else{
                        var virtualPrices = JSON.parse(x.virtualPrice.replace(/'/g, '"'));
                        
                    }                           
                    var Terminal = "Pc";
                    switch (_this.options.params.plat) {
                        case 4://pc
                            break;
                        case 1://wap
                            Terminal = "Wap";
                            if (isApp) {
                                Terminal = "App";
                            }
                            break;
                        default:
                            break;
                    }
                    var vir = virtualPrices.filter(function (x) { return x.Terminal == Terminal; });
                    virtualPrice = vir.length ? vir[0] : {};
                }
                catch (error) {
                }
                if (_this.options.params.plat == 1) {
                    // x.pcDetailUrl = "//m.lenovouat.com/" + x.pcDetailUrl;
                    x.pcDetailUrl = x.wapDetailUrl; //.replace("//shop.lenovouat.com/", "//m.lenovouat.com/")
                    if (isApp) {
                        x.pcDetailUrl = "//" + (_this.options.isProduction ? "https://shop.lenovo.com.cn/consumptionPoint/js/m.lenovo.com.cn" : "https://shop.lenovo.com.cn/consumptionPoint/js/m.lenovouat.com") + "/android/product/" + x.code + ".html";
                    }
                }
                var item = {
                    img: "//p1.lefile.cn" + x.path,
                    name: x.name,
                    money: virtualPrice.Cash || 0,
                    integral: virtualPrice.Virtual || 0,
                    href: x.pcDetailUrl + _this.options.href
                };
                
                return _this.dataTemplate.create(item);
            });
          }else{
            var tpl = data.items.map(function (x) {
                var virtualPrice = {};
                try {               
                        var virtualPrices = JSON.parse(x.virtualPrice.replace(/'/g, '"'));         
                    var Terminal = "Pc";
                    switch (_this.options.params.plat) {
                        case 4://pc
                            break;
                        case 1://wap
                            Terminal = "Wap";
                            if (isApp) {
                                Terminal = "App";
                            }
                            break;
                        default:
                            break;
                    }
                    var vir = virtualPrices.filter(function (x) { return x.Terminal == Terminal; });
                    virtualPrice = vir.length ? vir[0] : {};
                }
                catch (error) {
                }
                if (_this.options.params.plat == 1) {
                    // x.pcDetailUrl = "//m.lenovouat.com/" + x.pcDetailUrl;
                    x.pcDetailUrl = x.wapDetailUrl; //.replace("//shop.lenovouat.com/", "//m.lenovouat.com/")
                    if (isApp) {
                        x.pcDetailUrl = "//" + (_this.options.isProduction ? "https://shop.lenovo.com.cn/consumptionPoint/js/m.lenovo.com.cn" : "https://shop.lenovo.com.cn/consumptionPoint/js/m.lenovouat.com") + "/android/product/" + x.code + ".html";
                    }
                }
                var item = {
                    img: "//p1.lefile.cn" + x.path,
                    name: x.name,
                    money: virtualPrice.Cash || 0,
                    integral: virtualPrice.Virtual || 0,
                    href: x.pcDetailUrl + _this.options.href
                };
                
                return _this.dataTemplate.create(item);
            });
          }
            this.container.find(".ct-commodity").append(tpl.join(" "));
            this.footerMore.show();
            this.loading.hide();
            // setTimeout(() => {
            this.isLoading = false;
            // }, 100);
        };
        return Controller;
    }());
    window["consumptionController"] = Controller;
})(window, document, jQuery);
