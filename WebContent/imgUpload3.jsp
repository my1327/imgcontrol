<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String basePath = request.getServletContext().getServletContextName();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>图片上传</title>
<link rel="stylesheet" href="/<%=basePath %>/res/css/imgUpload.css" />
</head>
<body>
	<form method="post" enctype="multipart/form-data" id="imgForm">
	<div class="imgUpload">
			<div class="closeBtn" onclick="">
				<input type="button" value="删除"/>
			</div><!--imgUpload-->
			<div class="imgFile">
				<input type="file" id="fileId"/>
			</div><!--imgFile-->
			<div class="sureBtn" onclick="">
				<input type="button" value="确认"/>
			</div><!--sureBtn-->
			<div class="containDiv">
				<div class="contain">
					<div class="imgList" data-bind=" foreach: imgs ">
						<div class="imgs">
							<div class="imgNew">
								<img data-bind="attr:{src:src}" alt="图片" />
							</div>
							<a href="#" class="del">删除</a>
							<a href="#" class="showImg">查看原图</a>
							<a href="#" class="chose">选择</a>
						</div><!--imgs-->
					</div><!--imgList-->
				</div><!--contain-->
			</div><!--containDiv-->			
		</div>
	</form>
</body>
<script src="/<%=basePath %>/res/js/jquery.min.js"></script>
<script src="/<%=basePath %>/res/js/jquery.form.js"></script>
<script src="/<%=basePath %>/res/js/knockout-3.4.0.js"></script>
<script>
var imgUp=new Array();
function Array(){
	var self = this;
	self.imgs =
	ko.observableArray([
		
	]);
}
$("#fileId").change(function(){
	//var list=document.getElementById("fileId").files;
	//for (var i = 0, file; file = list[i]; i++) {
	    // 文件名称，文件对象
	    alert(file.name);
	//}
})


ko.applyBindings(imgUp);
</script>
</html>