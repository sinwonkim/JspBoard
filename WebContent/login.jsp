<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1"> <!-- 컴,핸폰 어느것이든  해상도에 맞게 디자인 맞추는 용도  -->
<link rel="stylesheet" href="css/bootstrap.css"> <!-- 부트스트랩 사용하겠다. -->
<title>Insert title here</title>
</head>
<body>
	<nav class="navbar navbar-default"><!-- 네비게이션이란 하나의 전반적인 구성보여주는 용도 -->
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed" 
			data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
			aria-expended="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">Jsp게시판 웹사이트</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">메인</a></li>
				<li><a href="bbs.jsp">게시판</a></li>
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><!--  #을 해서 현재 가리키는 링크 없다는 곳을 알려주고 -->
					<a href="#" class="dropdown-toggle"  
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expended="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li class="active"><a href="login.jsp">로그인</a></li> <!-- active란  선택 현재의 홈페이지를 의미 -->
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>		
		</div>
	</nav> 
	<div class="container">
	 	<div class="col-lg-4"></div>
	 	<div class="col-lg-4">
	 		<div class="jumbotron" style="padding-top: 20px;">
	 			<form method="post" action="loginAction.jsp"> <!-- 로그인액션의 페이지에 로그인 정보를 보내주겠다 -->
	 				<h3 style="text-align: center;">로그인 화면</h3>
	 				<div class="form-group">
	 					<input type="text" class="form-contorl" placeholder="아이디" name="userID" maxlength="20"><!-- placeholder어떠한것도 입력되지 않았을때 -->
	 				</div>																		<!-- name 서버프로그램때 -->
	 				<div class="form-group">
	 					<input type="password" class="form-contorl" placeholder="비밀번호" name="userPassword" maxlength="20">
	 				</div>								
	 				<input type="submit" class="btn btn-primary form-control" value="로그인">										
	 			</form>
	 		</div>
	 	</div>
	 	<div class="col-lg-4"></div>
	</div>
<script
  src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="js/bootstrap.min.js"></script> 
</body>
</html>