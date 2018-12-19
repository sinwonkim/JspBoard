<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %> <!-- 스크립트 문장을 실행할 수 있도록 라이브러리 불러올 수 있도록 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1"> <!-- 컴,핸폰 어느것이든  해상도에 맞게 디자인 맞추는 용도  -->
<link rel="stylesheet" href="css/bootstrap.css"> <!-- 부트스트랩 사용하겠다. -->
<link rel="stylesheet" href="css/custom.css"> <!-- 커스텀 css참조 -->
<title>Insert title here</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") !=null){
			userID = (String) session.getAttribute("userID");
		}
	
	%>



<button id="night_day" type="button" value="night" onclick="myFunction()">배경색 변경</button>
	
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
				<li class="active"><a href="main.jsp">메인</a></li>
				<li><a href="bbs.jsp">게시판</a></li>
			</ul>
			<%
				if(userID ==null){ 	/* 로그인이 되어 있지 않다면 회원가입이나 로그인 할 수 있도록 */
			%>	
				<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><!--  #을 해서 현재 가리키는 링크 없다는 곳을 알려주고 -->
					<a href="#" class="dropdown-toggle"  
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expended="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li> <!-- active란  선택 현재의 홈페이지를 의미 -->
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>		
			<% 			
				} else {
							
			%><!-- else 써서 로그인 되지 않은 사람이 볼 수 있는 화면  -->
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><!--  #을 해서 현재 가리키는 링크 없다는 곳을 알려주고 -->
					<a href="#" class="dropdown-toggle"  
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expended="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">로그아웃</a></li>  <!-- 링크 타고갔을땐 로그아웃 쪽가서 세션 해제되도록 -->
					</ul>
				</li>
			</ul>		
			<%
				}
			%>
		</div>
	</nav> 
	<div class="container">
		<div class="jumbotron">
			<div class="container">
				<h1>웹 사이트</h1>
				<p> JSP로 게시판을 연습해 보았습니다.
				<p><a class="btn btn-primary btn-pull" href="#" role="button">자세히 알아보기</a>		
			</div>	
		</div>
	</div>
	<div class="container">
		<div id="myCarousel" class="carousel slide" data-ride="carousel">
			<ol class="carousel-indicators">
				<li data-targer="#myCarousel" data-slide-to="0" class="active"></li>
				<li data-targer="#myCarousel" data-slide-to="1" ></li>
				<li data-targer="#myCarousel" data-slide-to="2" ></li>
			</ol>
			<div class="carousel-inner">
					<div class="item active">
						<img src="imgs/1.jpg">
					</div>
					<div class="item">
						<img src="imgs/2.jpg">
					</div>
					<div class="item">
						<img src="imgs/3.jpg">
					</div>
			</div>
			<a class="left carousel-control" href="#myCarousel" data-slide="prev">
				<span class="glyphicon glyphicon-chevron-left"></span>
			</a>
			<a class="right carousel-control" href="#myCarousel" data-slide="next">
				<span class="glyphicon glyphicon-chevron-right"></span>
			</a>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="js/bootstrap.min.js"></script> 
	
	
</body>
	<script>
	function myFunction() {
	if(document.querySelector('#night_day').value === 'night'){
		 document.body.style.backgroundColor = "black";
		 document.body.style.color ='#2E2EFE';
		 document.querySelector('#night_day').value = 'day'; 
	}else if(document.querySelector('#night_day').value === 'day'){
		 document.body.style.backgroundColor = "white";
		 document.body.style.color ='black';
		 document.querySelector('#night_day').value = 'night'; 
		}
	}
</script>
</html>