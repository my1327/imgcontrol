<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String basePath = request.getServletContext().getServletContextName();
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<link rel="stylesheet" href="/<%=basePath %>/res/css/imgUpload.css" />
		<link rel="stylesheet" href="/<%=basePath%>/res/css/basic.css" />
	</head>
	<body>
		<div id="bg"></div>
		<header>
		    <div class="header_top">
		        <div class="header_logo">
		            <img src="/<%=basePath %>/img/logo.png"/>
		            <p>绿色摩登农业科技投资管理(苏州)有限公司</p>
		        </div>
		        <div class="header_login">
		            <a href="login.html">登录</a>
		            <p>商户个数：<span class="header_num">100</span></p>
		        </div>
		    </div>
		</header>
		<div class="barline hidden" id="probar">
			<div id="line"></div>
			<div id="msg">共<span id="all"></span>张,已完成<span id="already"></span>张,未完成<span id="no"></span>张</div>
		</div>
		<form id="imgForm" method="post" enctype="multipart/form-data">	
			<div class="imgUpload">
				<div class="closeBtn">
					<div class="imgFile">
						<a href="#" >上传图片
						<input type="file" name="file" id="fileId" multiple="multiple"/></a>
					</div><!--imgFile-->
					<input type="button" class="close"/>
				</div><!--imgUpload-->
				<div class="imgList clearFix" data-bind=" foreach: Imgs ">
					<div class="imgs" id="imgs">
						<div class="imgNew" data-bind="click:$root.choseImg" onmouseover="showBtn(this)" onmouseout="hideBtn(this)">
							<img data-bind="attr:{src:url,alt:$index}"/>
						</div>
						<a href="#" class="del" data-bind="click:$root.deleteclick"></a>
						<a href="#" class="showImg" data-bind="click:$root.showImg"  onmouseover="showBtn(this)"  onmouseout="hideBtn(this)">查看原图</a>
						<a href="#" class="chose" data-bind="attr:{id:id}"></a>  
					</div><!--imgs-->						
				</div><!--imgList-->			
				<div class="sureBtn">
					<div class="fav_list clearFix">
					    <ul>
					        <li><a id="pageFirst" onClick="firstPage()" href="#"></a></li>
							<li><a id="pageForward" href="#" onClick="forwardPage()"></a></li>
							<li><input id="pageNum" class="num" type="text" value=""/></li>
							<li class="jump"><input id="pageJump" type="button" onClick="jumpPage()" value="跳转"/></li>
							<li><a id="pageNext" onClick="nextPage()" href="#"></a></li>
							<li><a id="pageEnd" onClick="endPage()" href="#"></a></li>
					    </ul> 
					</div>
					<input class="sure" type="button" value="确认" data-bind="click:$root.sureClick"/>
				</div><!--sureBtn-->
			</div><!--imgupload-->
			<div id="showBox" class="showBox">
				<div class="prevBtn" onclick="toPrev()"></div>
				<div class="imgContain" id="imgContain"  onclick="Boxs('none')">
				</div>
				<div class="nextBtn" onclick="toNext()"></div>
			</div>
		</form>
		<div class="footer"></div>
	</body>
	<script src="/<%=basePath%>/res/js/jquery.min.js"></script>
	<script src="/<%=basePath%>/res/js/jquery.form.js"></script>
	<script src="/<%=basePath %>/res/js/knockout-3.4.0.js"></script>
	<script src="/<%=basePath%>/res/js/page.js"></script>
	<script src="/<%=basePath%>/res/js/my_imgUpload.js"></script>
</html>