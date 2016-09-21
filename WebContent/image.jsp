<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String basePath = request.getServletContext().getServletContextName();
%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta charset="utf-8">
<meta name="renderer" content="webkit">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="作者名">
<title>绿色摩登</title>
<link rel="stylesheet" href="/<%=basePath%>/res/css/basic.css">
<link rel="stylesheet" href="/<%=basePath%>/res/css/images.css">

</head>
<body>
	<header>
		<div class="header_top">
			<div class="header_logo">
				<img src="img/logo.png" />
				<p>绿色摩登农业科技投资管理(苏州)有限公司</p>
			</div>
			<div class="header_login">
				<a href="login.html">登录</a>
				<p>
					商户个数：<span class="header_num">100</span>
				</p>
			</div>
		</div>
	</header>
	<form class="content" id="form1" action="image/upload" method="post"
		enctype="multipart/form-data">
		<div class="top">
			<div class="upload">
				<input id="fileInput" type="file" name="file" multiple="multiple" />上传图片
			</div>
			<div class="top_del">
				<img src="/<%=basePath%>/img/X.png" />
			</div>
		</div>
		<div class="main" data-bind="foreach: imageList">
			<div class="main_list">
				<div class="list_pic">
					<img data-bind="attr:{src:url}" />
				</div>
				<a href="#" data-bind="click: $parent.deleteclick"><img
					src="/<%=basePath%>/img/del.png" /></a>
				<div class="look_pic hidden">查看原图</div>
			</div>
		</div>

		<div class="fav_list clearFix">
			<%-- <ul>
				<li><a href="#"><img src="/<%=basePath%>/img/ar1.png" /></a></li>
				<li><a href="#"><img src="/<%=basePath%>/img/ar2.png" /></a></li>
				<li><a href="#"><span class="num">1</span></a></li>
				<li><a href="#"><span class="num">2</span></a></li>
				<li><a href="#"><span class="num">3</span></a></li>
				<li><a href="#"><span class="num">4</span></a></li>
				<li><a href="#"><span class="num">5</span></a></li>
				<li class="more"><a href="#"><span class="num">......</span></a></li>
				<li><a href="#"><img src="/<%=basePath%>/img/ar3.png" /></a></li>
				<li><a href="#"><img src="/<%=basePath%>/img/ar4.png" /></a></li>
			</ul> --%>
			<ul>
		        <li><a id="pageFirst" onClick="firstPage()" href="#"><img src="/<%=basePath%>/img/ar1.png"/></a></li>
				<li><a id="pageForward" href="#" onClick="forwardPage()"><img src="/<%=basePath%>/img/ar2.png"/></a></li>
				<li><input id="pageNum" class="num" type="text" style="width: 35px; height: 35px;" value=""/></li>
				<li><input id="pageJump" class="jump" type="button" onClick="jumpPage()" value="跳转"/></li>
				<li><a id="pageNext" onClick="nextPage()" href="#"><img src="/<%=basePath%>/img/ar3.png"/></a></li>
				<li><a id="pageEnd" onClick="endPage()" href="#"><img src="/<%=basePath%>/img/ar4.png"/></a></li>
		    </ul> 
			<input class="sure_btn" type="button" value="确定" />
		</div>
	</form>
	<div class="barline" id="probar">
		<div id="percent"></div>
		<div id="line"></div>
		<div id="msg"></div>
	</div>
	<div class="wrap"></div>
</body>
<script src="/<%=basePath%>/res/js/jquery.min.js"></script>
<script src="/<%=basePath%>/res/js/knockout-3.4.0.js"></script>
<script src="/<%=basePath%>/res/js/jquery.form.js"></script>
<script src="/<%=basePath%>/res/js/page.js"></script>

<script>
function Display(){
    $(".wrap").show();
    $(".wrap").css({
    width:$(window).width(),
    height:$(window).height(),
})
}

 // 背景隐藏
    function Hide(){
    $(".wrap").hide();
    }
//进度条

/* function processerbar(time){
   $("#probar").css("display","block");
    Display();
	$("#line").each(function(i,item){
		var a=parseInt($(item).attr("w"));
		$(item).animate({
			width: a+"%"
		},time);
	});

     var si = window.setInterval( 
	function(){ 
		a=$("#line").width();
		b=(a/550*100).toFixed(0);     
	    $("#percent").html(b+"%");
		$("#percent").css("left",a-12+"px");
		document.getElementById('msg').innerHTML="已完成"+fileIndex+"张,未完成3张，共"+fileList.length+"张";
		if($("#percent")=="100%") 
		{ */
		/*  clearInterval(si); */
		/* document.getElementById('msg').innerHTML="&nbsp;&nbsp;成功"; */
		/* document.getElementById('probar').style.display="none"; */
		/* Hide(); */
/* 		}
	},70);
}; */
	var imgObj = new ShopImg();
	function ShopImg() {
		var self = this;
		self.imageList = ko.observableArray([]);
		self.deleteclick = function(data, event) {
			//alert(1);
			var dataid = {
				id : data.id
			//"fea9744b046546a09f5b1780907a60c2"
			};
			$.post("image/remove.ds", dataid, function(result) {
				if (result.code == 0){
					//getImages();
					loadShoppingCount();
				}
			
			})
		}
	}
	ko.applyBindings(imgObj);

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
		var progressNum = ((fileIndex+1)/fileList.length)*100;
		progress(progressNum, fileIndex+1, fileList.length);
		++fileIndex;
		if (fileIndex < fileList.length) {
			console.log("Current index: " + fileIndex);
			submit(fileIndex);
			$("#msg").show();
		
		} 
		else
          {
			uploadCompleted();
		      alert("32534")
	           $("#probar").hide();
		        Hide();
	   }
	}
	function uploadCompleted() {
		fileIndex = 0;
		//getImages();
		loadShoppingCount();
	}

	function submit(index) {
		options.file = fileList[index];
		$("#form1").ajaxSubmit(options);
	}
	var inputElement = document.getElementById("fileInput");
	inputElement.addEventListener("change", handleFiles, false);

	function handleFiles() {
		fileList = this.files;
		fileIndex = 0;
		submit(fileIndex);
		$(".barline").show();
		Display()
	}
	function getImages() {

		$.get("image/get.ds?page=0&size=20", null, function(result) {
			//alert(result);
			imgObj.imageList(result);
		})
	}

	//getImages();
	function remove() {
		data = {
			id : "fea9744b046546a09f5b1780907a60c2"
		};
		$.post("image/remove.ds", data, function(result) {
			alert(result);
		})
	}
	function progress(progress, currentNum, allNum) {
		$("#line").css("width", progress + "%");
		/* $("#all").html(allNum);
		$("#already").html(currentNum);
		$("#no").html(allNum - currentNum); */
		$("#msg").html("已完成"+currentNum+"张,未完成"+(allNum - currentNum)+"张，共"+allNum+"张");
		
	}
	
	loadShoppingCount();
	
	function loadShoppingCount() {
		$.get("image/count.ds", null, function(result) {
			var number = $.parseJSON(result);
			//alert(number);
			setTotalCount(number);
		});
	}
	
	function loadSourceItems(start) {
		var data = {
			page: currentPage-1,
			size: 15
		}
		
		$.get("image/get.ds",data, function(result) {
			//alert(result);
			imgObj.imageList(result);
		})
	}
</script>
</html>