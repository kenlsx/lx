//网站地址

if(document.domain.indexOf('lenovouat') == -1){
	var zcodeUrl = "//buy.lenovo.com.cn/zcodebuy.jhtml";
	var gotoZcode = "https://buy.lenovo.com.cn/checkout.jhtm?terminal=1&buyType=1";
	var vCodeImgUrl = "//captcha.lenovo.com.cn/img";
}else{
	var zcodeUrl = "//buy1.lenovouat.com/zcodebuy.jhtml";
	var gotoZcode = "https://buy1.lenovouat.com/checkout.jhtm?terminal=1&buyType=1";
	var vCodeImgUrl = "//captcha.lenovouat.com/img";
	
}

function setVcode(){
	$("#vCodeImg").attr({"src":vCodeImgUrl+"?v="+(new Date().valueOf())});
}
function isZcode() {
	if($.trim($("#zCode").val()) == ""){
		alert("请填写Z码");
		return;
	}
	if($.trim($("#vCode").val()) == ""){
		alert("请填写验证码");
		return;
	}
	$.ajax({
		url: zcodeUrl + "?ss=" + new Date().getMilliseconds(),
		type: 'get',
		dataType: "jsonp",
		jsonp:"callbackparam",
		data: {
			"kcode":$.trim($("#zCode").val()),
			"vcode":$.trim($("#vCode").val()),
			"terminal": 1
		},
		success: function (data) {
			if(data.rc == 0){
				window.location.href = gotoZcode;
			}else{
				alert(data.msg);
				setVcode();
			}
		},
		error: function(){
			alert("系统繁忙请稍后重试");
		},
		complete: function (XMLHttpRequest, status) {
			setVcode();
		}
	});
}
$(function(){
	setVcode();
	$("#submit").click(function(){
		if(passport.isLogin()){
			isZcode();
		}else{
			passport.show();
		}
	})
	$(".change").click(function(){
		setVcode();
	})
})














