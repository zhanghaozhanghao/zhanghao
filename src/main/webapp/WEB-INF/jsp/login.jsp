<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
<title>sy6</title>
<link rel="stylesheet"
	href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css">
<style type="text/css">
body {
	font: normal 15px/1.5 Arial, Helvetica, Free Sans, sans-serif;
	color: #182F3A;
	background: #E8F3F8;
	overflow-y: scroll;
	padding: 10px 0 0 0;
	font-family: Arial, Helvetica, Sans-Serif;
}

#my-form {
	width: 500px;
	margin: 0 auto;
	border: 1px solid #ccc;
	padding: 3em;
	border-radius: 3px;
	box-shadow: 0 0 2px rgba(0, 0, 0, .2);
}

#comments {
	width: 350px;
	height: 100px;
}
</style>
<script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
<script
	src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<!-- <script type="text/javascript"
	src="http://static.blog.csdn.net/scripts/jquery.js"></script> -->
<script type="text/javascript">
	function check(code) {
		$
				.ajax({
					type : "post",
					url : "${pageContext.request.contextPath}/codeVerify/result",
					data : "code=" + code,
					success : function(data) {
						if (data != code) {
							document.getElementById("mes").innerHTML = "<a style='color: red;font-size:18px;'>×</a>";
							var submit = $("#submit");
							debugger;
							var src = submit.attr("disabled", "disabled");
						} else {
							document.getElementById("mes").innerHTML = "<a style='color: GREEN;font-size:18px;'>√</a>";
							var submit = $("#submit");
							
							var src = submit.removeAttr('disabled');
						}
					}
				});
	}
	function changeImg() {
		debugger;
		var imgSrc = $("#imgObj");
		var src = imgSrc.attr("src");
		imgSrc.attr("src", chgUrl(src));
	}
	//时间戳     
	//为了使每次生成图片不一致，即不让浏览器读缓存，所以需要加上时间戳     
	function chgUrl(url) {
		debugger;
		var timestamp = (new Date()).valueOf();
		urlurl = url.substring(0, 17);
		if ((url.indexOf("&") >= 0)) {
			urlurl = url + "×tamp=" + timestamp;
		} else {
			urlurl = url + "?timestamp=" + timestamp;
		}
		return urlurl;
	}

	function isRightCode() {
		var code = $("#veryCode").attr("value");
		code = "c=" + code;
		$.ajax({
			type : "POST",
			url : "${pageContext.request.contextPath}/codeVerify/result",
			data : code,
			success : callback
		});
	}
	function callback(data) {
		$("#info").html(data);
	}
	function loginValid() {
		var reNum =<%=request.getParameter("reNum")%>;
		var cc = reNum;
		if (cc == 0) {
			return;
		}
		if (cc == 1) {
			alert("密码错误！");
		} else if (cc == 3) {
			alert("无此用户！");
		}
	}
</script>
<style type="text/css">
#main {
	width: 540px;
	padding: 10px;
	margin: 250px auto;
	text-align: center;
	border-radius: 5px;
	box-shadow: -2px 0 10px #ccc, 2px 0 10px #ccc;
}

#main button {
	width: 70px;
	height: 50px;
	font-size: 16px;
	color: white;
	background-color: dodgerblue;
	border: none;
	border-radius: 10px;
	box-shadow: -2px 0 10px #ccc, 2px 0 10px #ccc;
}
</style>
</head>
<body onload="loginValid()">
	<%-- <div id="main">
		<form action="${pageContext.request.contextPath}/ForwardServlet"
			id="form"></form>
	</div> --%>

	<div style="height: 20px;">
		<marquee behavior="scroll" bgcolor="#33CCFF">欢迎登录&emsp;
			开发人员：张浩 &emsp; 联系方式 ：18375321090 </marquee>
		<!-- <a style="color: red; margin-left: 1260px;" href="home.jsp">返回首页</a> -->
	</div>
	<div class="row" style="padding: 120px 0 0 0;">
		<div class="eightcol last">
			<!-- Begin Form -->
			<form id="my-form" action="${pageContext.request.contextPath}/login/login" method="post">
				<div align="center">
					<h3>欢迎登录！</h3>
				</div>
				<div style="margin-top: 10px; width: 400px;">
					<label>账号:</label><input name="userName" type="text" id="inputName"
						class="form-control">
				</div>
				<div style="margin-top: 10px; width: 400px;">
					<label>密码:</label><input name="password" type="password"
						id="password" class="form-control">
				</div>
				<div style="margin-top: 10px; width: 400px;">
					<label id="validate">输入验证码：</label> <input type="text"
						name="verification" onchange="check(this.value)"
						style="width: 70px">&ensp;&ensp; <img id="imgObj"
						src="${pageContext.request.contextPath}/codeVerify/check">
					&emsp;<a href="#" onclick="changeImg()">换一张</a>&emsp;&emsp;
					<lable id="mes"></lable>
					<!-- <input
						type="submit"> <input type="button" value="验证"
						onclick="isRightCode()" /> -->
					<!-- <div id="info"></div> -->
				</div>
				<div class="row" style="width: 400px;">
					<div class="col-md-6" style="margin-top: 10px; width: 280px;">
						<button id="submit" type="submit" class="btn btn-primary"
							style="width: 120px;" >登陆</button>
					</div>
					<div class="col-md-6" style="margin-top: 20px; width: 110px;">
						<a id="wangji">忘记密码？</a>
					</div>

				</div>
			</form>
		</div>

	</div>
</body>
</html>