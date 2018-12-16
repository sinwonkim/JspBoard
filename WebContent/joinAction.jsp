<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %> <!-- 자바스크립트 문장을 작성하기 위해 -->
<% request.setCharacterEncoding("UTF-8"); %> <!-- 건너오는 데이터를 모두 UTF-8로 만들어줌 -->
<jsp:useBean id="user" class="user.User" scope="page"></jsp:useBean> <!--vo 즉 자바빈즈 사용  -->
<jsp:setProperty name="user" property="userID"/>
<jsp:setProperty name="user" property="userPassword"/>
<jsp:setProperty name="user" property="userName"/>
<jsp:setProperty name="user" property="userGender"/>
<jsp:setProperty name="user" property="userEmail"/>
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
			}
			if(userID != null) {
				PrintWriter script =response.getWriter();
				script.println("<script>");
				script.println("alert('이미 로그인이 되어있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}	
			
			if(user.getUserID()== null ||user.getUserPassword() == null||user.getUserName()== null || user.getUserGender() == null
			|| user.getUserEmail()== null ){
				PrintWriter script =response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}else {
				UserDAO userDAO = new UserDAO();		
				int result = userDAO.join(user);
				if(result == -1){
					PrintWriter script =response.getWriter();
					script.println("<script>");
					script.println("alert('이미 존재하는 아이디입니다.')");
					script.println("location.href = 'main.jsp'");
					script.println("</script>");
				}
				else {
					session.setAttribute("userID", user.getUserID()); /* ID컬럼에 프라이머리키로 지정해놈    */
					PrintWriter script =response.getWriter();
					script.println("<script>");
					script.println("location.href = 'main.jsp'");
					script.println("</script>");
				}
			}		
		%>
</body>
</html>