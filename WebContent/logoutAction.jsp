<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
		<%	
			session.invalidate(); /* 현재 이페이지 접속한 사람 세션 빼앗기게 해서 로그아웃되게 */
		%>
		<script>
			location.href = "main.jsp";
		</script>
</body>
</html>