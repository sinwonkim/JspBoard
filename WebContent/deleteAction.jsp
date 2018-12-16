<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %> <!-- 자바스크립트 문장을 작성하기 위해 -->
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
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
			if(userID == null) { // 글쓰기인 경우 로그인이 된 상태여야 하기때문에 널 아닌경우로 하면 x 
				PrintWriter script =response.getWriter();
				script.println("<script>");
				script.println("alert('로그인을 하세요')");
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
			if(!userID.equals(bbs.getUserID())) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('권한이 없습니다.')");
				script.println("location.href = 'bbs.jsp'");
				script.println("</script>");
			} else {
					BbsDAO bbsDAO = new BbsDAO();
					int result = bbsDAO.delete(bbsID);
					if (result == -1) {
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('글  삭제에 실패하였습니다.')");
						script.println("history.back()");
						script.println("</script>");
					} 
					else {
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("location.href = 'bbs.jsp'");
						script.println("</script>");
					}

			}
		%>
</body>
</html>