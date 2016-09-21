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
<link rel="stylesheet" href="/<%=basePath%>/res/css/progress.css" />
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
		<div id="progressId" class="wrap hidden">
		</div>
		<div class="barline hidden" id="probar">
				<!-- <div id="percent"></div> -->
				<div id="line"></div>
				<div id="msg">共<span id="all"></span>张,已完成<span id="already"></span>张,未完成<span id="no"></span>张</div>
		</div>
		<div class="upImg_wrap">
			<div class="upImg_title clearFix">
				<a href="javascript:;" class="file">上传图片 <input type="file"
					name="file" id="loadInput" multiple="multiple">
				</a>
				<div class="close fr">
					<img src="img/X.png">
				</div>
			</div>
			<!--upImg_title-->
			<div class="upImg_content clearFix" data-bind="foreach:Imgs">
				<div class="contentWrap fl">
					<div>
						<img data-bind="attr:{src:url}" />
					</div>
					<a href="#" data-bind="click: $parent.deleteclick"></a>
				</div>
			</div>
			<!--upImg_content-->
			<div class="review_page">
				<div class="page fl">
					<a class="firstPage"> <img src="img/首页.png"></a> 
					<a class="prePage"> <img src="img/上一页.png"></a> 
					<a class="one" onclick="getImages(0)">1</a> 
					<a class="two" onclick="getImages(1)">2</a>
					<a class="three" href="#">3</a> 
					<a class="four" href="#">4</a> 
					<a class="active five" href="#">5</a> 
					<a class="more">... ...</a> 
					<a class="nextPage" href="#"> <img src="img/下一页.png"></a> 
					<a class="lastPage" href="#"> <img src="img/尾页.png"></a>
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
	$(".wrap").css({
		width : $(window).width(),
		height : $(window).height()
	});

	var imgObj = new ShopImg();
	function ShopImg() {
		var self = this;
		self.Imgs = ko.observableArray([]);
		self.deleteclick = function(data, event) {
			//alert(1);
			var dataid = {
				id : data.id
			//"fea9744b046546a09f5b1780907a60c2"
			};
			$.post("image/remove.ds", dataid, function(result) {
				if (result.code == 0)
					getImages(0);
				else {
					alert(result.content);
				}
			})
		}
	}

	ko.applyBindings(imgObj);

	function load() {
		getImages(0);
	}

	var fileList;
	var fileIndex = 0;
	var options = {
		target : '#output1',
		beforeSubmit : beforeSubmit,
		success : function(data, states, result) {
			submitted(data, false);
		},
		error : function(data) {
			submitted(data, true);
		},
		type : "POST",
		url : "image/upload.ds",
		dataType : "json"
	};

	function beforeSubmit(formData, jqForm, options) {
		formData[0].value = options.file;
		return true;
	}

	function submitted(data, hasError) {
		var progressNum = ((fileIndex + 1) / fileList.length) * 100;
		progress(progressNum, fileIndex + 1, fileList.length);
		++fileIndex;
		if (fileIndex < fileList.length) {
			console.log("Current index: " + fileIndex);
			//进度条百分比
			submit(fileIndex);
		} else {
			uploadCompleted();
			$(".wrap").hide();
			$(".barline").hide();
		}
	}

	function uploadCompleted() {
		fileIndex = 0;
		//alert("Completed!");
		getImages(0);
	}

	function submit(index) {
		options.file = fileList[index];
		$("#imgForm").ajaxSubmit(options);
	}

	var inputElement = document.getElementById("loadInput");
	inputElement.addEventListener("change", handleFiles, false);

	function handleFiles() {
		fileList = this.files;
		fileIndex = 0;
		//添加进度条
		$(".wrap").show();
		$(".barline").show();
		submit(fileIndex);
	}
	function getImages(page) {
		$.get("image/get.ds?page="+page+"&size=20", null, function(result) {
			//alert(result);
			imgObj.Imgs(result);
		})
	}

	function progress(progress, currentNum, allNum) {
		$("#line").css("width", progress + "%");
		$("#all").html(allNum);
		$("#already").html(currentNum);
		$("#no").html(allNum - currentNum);
	}
	getImages(0);
	$.ajaxSetup({
		cache : false
	//清除AJAX相应的缓存 
	});
</script>
</html>