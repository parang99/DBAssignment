<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>수강신청 사용자 정보 수정</title>
</head>
<body>
<%@ include file="top.jsp" %>

<!-- ... -->

<%

// ...

if (session_id==null) response.sendRedirect("login.jsp");

// ...

mySQL = "select s_addr, s_owd from student where s_id='" + session_id + "'";

// ...

%>

<!-- ... -->

<form method="post" action="update_verify.jsp">

<!-- ... -->

</form>
</body>
</html>