<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String basePath = request.getServletContext().getServletContextName();
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>图片管理系统</title>
<link rel="stylesheet" href="/<%=basePath%>/img.css" />
</head>
<body>
	<form id="imgForm" method="post" enctype="multipart/form-data">
		<div class="container">
			<div class="leftContainer">
				<input id="loadInput" type="file" name="file" value="上传图片" /> <input
					id="subInput" type="button" value="确认" onclick="submit()" />
			</div>
			<div class="imgContainer" data-bind="foreach:Imgs">
				<ul>
					<li>
						<div class="imgBox">
							<a href="#" onclick=""><img data-bind="attr:{src:imgUrl}" /></a><input
								type="checkbox" id="deleteImg">
						</div> <%-- <div class="imgBox"><a href="#" onclick=""><img data-bind="attr:{src:imgUrl}"/></a><a><img src="/<%=basePath%>/img/delete.jpg"/></a></div> --%>
					</li>
				</ul>
			</div>
		</div>
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
			//self.id = ko.ober
		    self.removeImg = function() {
		        self.Imgs.remove(this);
		    }; 
		}
		
		ko.applyBindings(imgObj);
		
		$("#loadInput").change(function() {
			submitImg();
		});  
		
		function submitImg() {
			var UpLoadUrl = "/<%=basePath%>/image/upload";

		$("#imgForm").ajaxSubmit({
			type : "POST",
			url : UpLoadUrl,
			dataType : "json",
			success : function(data, states, result) {
				var obj = $.parseJSON(data);
				alert("result:" + obj.imgurl);

				var imgurl = obj.imgurl;

				imgObj.Imgs.push({
					"imgUrl" : imgurl
				});
				
			},
			error : function() {
				alert("对不起，添加图片失败！");
			}
		});
	}
</script>
</html>