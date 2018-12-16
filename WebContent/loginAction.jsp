<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %> <!-- 자바스크립트 문장을 작성하기 위해 -->
<% request.setCharacterEncoding("UTF-8"); %> <!-- 건너오는 데이터를 모두 UTF-8로 만들어줌 -->
<jsp:useBean id="user" class="user.User" scope="page"></jsp:useBean> <!--vo 즉 자바빈즈 사용  -->
<jsp:setProperty name="user" property="userID"/>
<jsp:setProperty name="user" property="userPassword"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
		<%
			String userID = null;                                           
			if(session.getAttribute("userID")!= null){
				userID = (String) session.getAttribute("userID");
			}/* 변수하나 초기화 시켜놓고 세션에서 아이디값 없어와서 그게 널아니면 변수에 집어넣어서 아래 세션에서 뽑아놓은 값 있으면 이미 로그인 되어있다고 띄워주는 용도 */
			if(userID != null) {
				PrintWriter script =response.getWriter();
				script.println("<script>");
				script.println("alert('이미 로그인이 되어있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}																			
			UserDAO userDAO = new UserDAO();		
			int result = userDAO.login(user.getUserID(),user.getUserPassword());
			if(result==1){
				session.setAttribute("userID", user.getUserID()); /* ID컬럼에 프라이머리키로 지정해놈    */
				PrintWriter script =response.getWriter();
				script.println("<script>");
				script.println("location.href = 'main.jsp'");
				script.println("</script>");
			}
			else if(result == 0) {
				PrintWriter script =response.getWriter();
				script.println("<script>");
				script.println("alert('비밀번호가 틀립니다.')");
				script.println("history.back()");
				script.println("</script>");
			}else if(result == -1) {
				PrintWriter script =response.getWriter();
				script.println("<script>");
				script.println("alert('존재하지 않는 아디입니다.')");
				script.println("history.back()");
				script.println("</script>");
			}else if(result == -2){
				PrintWriter script =response.getWriter();
				script.println("<script>");
				script.println("alert('데이터베이스 오류가 발생했습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
		%>
</body>
</html>