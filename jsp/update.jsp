<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수강신청 사용자 정보 수정</title>
</head>
<body>
<%@ include file="top.jsp" %>

<!-- ... -->

<%
String dbdriver = "oracle.jdbc.driver.OracleDriver";
String dburl = "jdbc:oracle:thin:@localhost:1521:orcl";

//DBA 계정
String user = "dbdb";
String passwd = "oracle";

Connection myConn = null;
Statement stmt = null;
String mySQL = null;
ResultSet myResultSet = null;

String s_id = null;
String s_pwd = null;
String s_name = null;
String s_addr = null;

if (session_id==null) response.sendRedirect("login.jsp");

try{
	Class.forName(dbdriver);
	myConn = DriverManager.getConnection(dburl, user, passwd);
	stmt = myConn.createStatement();
} catch(SQLException ex){
	System.err.println("SQLException: " + ex.getMessage());
}

mySQL = "select s_id, s_pwd, s_name, s_addr from student where s_id='" + session_id + "'";

myResultSet = stmt.executeQuery(mySQL);

if (myResultSet != null){
	while(myResultSet.next()){
		s_id = myResultSet.getString("s_id");
		s_pwd = myResultSet.getString("s_pwd");
		s_name = myResultSet.getString("s_name");
		s_addr = myResultSet.getString("s_addr");
	}
}
%>
<!-- 사용자 정보 보여주기 -->
<div align="center">
<form method="post" action="update_verify.jsp">
	<br><br><div>아이디 : &nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="s_id" value=<%= s_id %> size=40></div>
	<div>비밀번호 : <input type="text" name="s_pwd" value=<%= s_pwd %> size=40></div>
	<div>이름 : &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="s_name" value=<%= s_name %> size=40></div>
	<div>주소 : &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="s_addr" value="<%= s_addr %>" size=40></div>
	<div><br><button type="button" onclick="location.href='main.jsp'">메인 화면</button>&nbsp;&nbsp;<input type="submit" value="정보 수정"></div>
</form>
</div>
</body>
</html>