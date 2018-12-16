<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="java.io.PrintWriter" %> <!-- 자바스크립트 문장을 작성하기 위해 -->
<% request.setCharacterEncoding("UTF-8"); %> <!-- 건너오는 데이터를 모두 UTF-8로 만들어줌 -->
<jsp:useBean id="bbs" class="bbs.Bbs" scope="page"></jsp:useBean> <!--vo 즉 자바빈즈 사용  -->
<jsp:setProperty name="bbs" property="bbsTitle"/>  <!-- 하나의 인스턴스를 만들 수 있게 해줌 -->
<jsp:setProperty name="bbs" property="bbsContent"/> <!-- 하나의 인스턴스를 만들 수 있게 해줌 -->
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
			}else {
				if(bbs.getBbsTitle() == null || bbs.getBbsContent() == null){
							PrintWriter script =response.getWriter();
							script.println("<script>");
							script.println("alert('입력이 안 된 사항이 있습니다.')");
							script.println("history.back()");
							script.println("</script>");
						}else {
							BbsDAO bbsDAO = new BbsDAO();		
							int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent());
							if(result == -1){
								PrintWriter script =response.getWriter();
								script.println("<script>");
								script.println("alert('글쓰기에 실패하였습니다.')");
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
			
			}		
		%>
</body>
</html>