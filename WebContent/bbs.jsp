<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %> <!-- 스크립트 문장을 실행할 수 있도록 라이브러리 불러올 수 있도록 -->
<%@ page import="bbs.BbsDAO" %> 
<%@ page import="bbs.Bbs" %> 
<%@ page import="java.util.ArrayList" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1"> <!-- 컴,핸폰 어느것이든  해상도에 맞게 디자인 맞추는 용도  -->
<link rel="stylesheet" href="css/bootstrap.css"> <!-- 부트스트랩 사용하겠다. -->
<title>Insert title here</title>
<style type="text/css">
	a, a:hover{
		color:#000000;
		text-decoration:none;
	}
</style>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") !=null){
			userID = (String) session.getAttribute("userID");
		}
		int pageNumber = 1; //기본페이지 
		if(request.getParameter("pageNumber")!= null){
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
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
				<!-- <li><a href="bbs.jsp">게시판</a></li>  -->
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
	<div class="container"><!-- 특정한 내용을 담을 컨테이너 하나 만듬 -->
		<div class="row"> <!-- 테이블 들어갈 수 있도록 row를 만든다. -->
			<table class="table table-striped" style="text-align: center; border:1px solid #dddddd">
				<thead> <!-- 제목 -->
					<tr> <!-- tr은 하나의 행 즉 줄이 되는 것 -->
						<th style="background-color:#eeeeee; text-align: center;">번호</th><!-- th를 넣어 하나의 속성을 명시해줌 -->
						<th style="background-color:#eeeeee; text-align: center;">제목</th>
						<th style="background-color:#eeeeee; text-align: center;">작성자</th>
						<th style="background-color:#eeeeee; text-align: center;">작성일</th>
					</tr>
				</thead>
				<tbody>
					<%
						BbsDAO bbsDAO = new BbsDAO(); // 게시글 뽑아 올 수 있도록 DB접근 하기위한
						ArrayList<Bbs> list = bbsDAO.getList(pageNumber); // 현재의 페이지에서 게시글 목록을 출력하자 for문으로 
						for(int i = 0; i < list.size(); i++){
					
					%>
					<tr>
						<td><%=list.get(i).getBbsID() %></td>
						<td><a href="view.jsp?bbsID=<%=list.get(i).getBbsID()%>"><%=list.get(i).getBbsTitle().replaceAll(" ", "&nbsp").replaceAll("<", "&lt;").replaceAll(">","&gt").replaceAll("\n","<br>" ) %></td> <!-- 제목눌렀을때 해당게시글 내용 보여주는곳으로	이동해야하기 떄문에 --> 
						<td><%=list.get(i).getUserID() %></td>																																	<!-- 스크립트를 치환해서 스크립팅 공격도 막는  -->
						<td><%=list.get(i).getBbsDate().substring(0,11)+list.get(i).getBbsDate().substring(11,13)+"시"+list.get(i).getBbsDate().substring(14,16) + "분" %></td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
			<%   //페이지 넘버 1이 아니라면 2페이지 이상이기 떄문에 이전페이지로 돌아갈 수 있는 페이지가 필요
				if(pageNumber != 1){
			%>
				<a href="bbs.jsp?pageNumber=<%=pageNumber -1 %>" class="btn btn-success btn-arraw-left">이전</a>
			<%
				}if(bbsDAO.nextPage(pageNumber)){
			%>
				<a href="bbs.jsp?pageNumber=<%=pageNumber + 1%>" class="btn btn-success btn-arraw-left">다음</a>
			<% 	
				}
			%>
			<a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
		</div>
	
	
	</div>
	
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="js/bootstrap.min.js"></script> 
</body>
</html>