<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %> 
<%@ page import="bbs.Bbs" %> 
<%@ page import="bbs.BbsDAO" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1"> <!-- 컴,핸폰 어느것이든  해상도에 맞게 디자인 맞추는 용도  -->
<link rel="stylesheet" href="css/bootstrap.css"> <!-- 부트스트랩 사용하겠다. -->
<title>Insert title here</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") !=null){
			userID = (String) session.getAttribute("userID");
		}
		if (userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		}
		int bbsID = 0;
		if(request.getParameter("bbsID") != null){
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		if(bbsID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글 입니다.')");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");
		}
		Bbs bbs = new BbsDAO().getBbs(bbsID);
		if(!userID.equals(bbs.getUserID())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");
		}
	
	%>

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
				<li class="active"><a href="bbs.jsp">게시판</a></li>
				<li><a href="bbs.jsp">게시판</a></li>
			</ul>
			
			<!-- else 써서 로그인 되지 않은 사람이 볼 수 있는 화면  -->
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
		</div>
	</nav> 
	<div class="container"><!-- 특정한 내용을 담을 컨테이너 하나 만듬 -->
		<div class="row"> <!-- 테이블 들어갈 수 있도록 row를 만든다. -->
			<form method="post" action="updateAction.jsp?bbsID=<%=bbsID%>">
				<table class="table table-striped" style="text-align: center; border:1px solid #dddddd">
					<thead> <!-- 제목 -->
						<tr> <!-- tr은 하나의 행 즉 줄이 되는 것  colspan은 열 잡아먹는거 -->
							<th colspan="2" style="background-color:#eeeeee; text-align: center;">게시판 글수정 양식</th><!-- th를 넣어 하나의 속성을 명시해줌 -->
							
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="text" class="form-control" placeholder="글 제목" name="bbsTitle" maxlength="50" value="<%= bbs.getBbsTitle() %>"></td>
						</tr>
						<tr>
							<td><textarea class="form-control" placeholder="글 내용" name="bbsContent" maxlength="2048" style="height:350px;"><%= bbs.getBbsContent() %></textarea></td>
						</tr>
					</tbody>
				</table>
				<input type="submit" class="btn btn-primary pull-right" value="글수정">
			</form>
		</div>
	
	
	</div>
	
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="js/bootstrap.min.js"></script> 
</body>
</html>