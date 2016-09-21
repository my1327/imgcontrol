<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String basePath = request.getServletContext().getServletContextName();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>上传图片</title>
<link rel="stylesheet" href="/<%=basePath%>/res/css/basic.css" />
<link rel="stylesheet" href="/<%=basePath%>/res/css/upImg.css" />
</head>
<body>
	<form id="imgForm" method="post" enctype="multipart/form-data">
		<header>
		<div class="header_top">
			<div class="header_logo">
				<img src="img/logo.png" />
				<p>绿色摩登农业科技投资管理(苏州)有限公司</p>
			</div>
			<div class="header_login">
				<a href="#">登录</a>
				<p>
					商户个数：<span class="header_num">100</span>
				</p>
			</div>
		</div>
		</header>
		<div class="upImg_wrap">
			<div class="upImg_title clearFix">
				<a href="javascript:;" class="file">上传图片 <input type="file"
					name="file" id="loadInput">
				</a>
				<div class="close fr">
					<img src="img/X.png">
				</div>
			</div>
			<!--upImg_title-->
			<div class="upImg_content clearFix" data-bind="foreach:Imgs">
				<div class="contentWrap fl">
            	<div><img src="img/logo.png"/></div>
            	<a href="#"></a>
        </div>
			</div>
			<!--upImg_content-->
			<div class="review_page">
				<div class="page fl">
					<a class="firstPage"> <img src="img/首页.png"></a> <a
						class="prePage"> <img src="img/上一页.png"></a> <a class="one"
						href="#">1</a> <a class="two" href="#">2</a> <a class="three"
						href="#">3</a> <a class="four" href="#">4</a> <a
						class="active five" href="#">5</a> <a class="more">... ...</a> <a
						class="nextPage" href="#"> <img src="img/下一页.png"></a> <a
						class="lastPage" href="#"> <img src="img/尾页.png"></a>
				</div>
				<!--page-->
				<div class="confirm fr">
					<input type="button" value="确认">
				</div>
				<!--confirm-->
			</div>
			<!--review_page-->
		</div>
		<!--upImg_wrap-->
	</form>
</body>
<script src="/<%=basePath%>/res/js/knockout-3.4.0.js"></script>
<script src="/<%=basePath%>/res/js/jquery.min.js"></script>
<script src="/<%=basePath%>/res/js/jquery.form.js"></script>
<script type="text/javascript">
	var imgObj = new ShopImg();
	function ShopImg() {
		var self = this;
		self.Imgs = ko.observableArray([]);
	}

	ko.applyBindings(imgObj);
	
	 $("#loadInput").change(function(){
		submitImg();
	});
	
	function submitImg(){
		 var UpLoadUrl="/<%=basePath%>/image/upload";

		$("#imgForm").ajaxSubmit({
			type : "POST",
			url : UpLoadUrl,
			dataType : "json",
			success : function(data, states, result) {
				var obj = $.parseJSON(data);
				var imgurl = obj.imgurl;
				
				//alert(obj.imgurl);
				imgObj.Imgs.push({
					"imgUrl" : imgurl
				});
			},
			error : function() {
				alert("对不起，添加图片失败");
			}
		});
	}
</script>
</html>