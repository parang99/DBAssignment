<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>수강신청 조회</title>
</head>
<body>

<%@ include file="top.jsp" %>
<% if (session_id == null) response.sendRedirect("login.jsp"); %>

<table width="75%" align="center" border>
<br>
<tr> <th>과목번호</th> <th>분반</th> <th>과목명</th> <th>학점</th> <th>시간</th> <th>장소</th></tr>
<%
Connection myConn = null;
Statement stmt = null;
ResultSet myResultSet = null;
String mySQL = "";
String dburl = "jdbc:oracle:thin:@localhost:1521:orcl";
String user = "dbdb";
String passwd = "oracle";
String dbdriver = "oracle.jdbc.driver.OracleDriver";

try{
	Class.forName(dbdriver);
	myConn = DriverManager.getConnection(dburl, user, passwd);
	stmt = myConn.createStatement();
} catch(SQLException ex){
	System.err.println("SQLException: " + ex.getMessage());
}

mySQL = "select c_id, c_no, c_name, c_credit, c_time, c_where from course, enroll where e_sid = '" + session_id + "' and c_id = e_cid and c_no = e_cno and c_year = e_year and c_semester = e_semester";

myResultSet = stmt.executeQuery(mySQL);

if (myResultSet != null){
	while(myResultSet.next()){
		String c_id = myResultSet.getString("c_id");
		int c_no = myResultSet.getInt("c_no");
		String c_name = myResultSet.getString("c_name");
		int c_credit = myResultSet.getInt("c_credit");
		int c_time = myResultSet.getInt("c_time");
		String c_where = myResultSet.getString("c_where");
		
		
		String[] day = {"월", "화", "수", "목", "금"};
		String convertedTime = day[c_time / 10 - 1] + "요일 " + (c_time % 10) + "교시";
%>
<tr>
	<td align="center"><%= c_id %></td> <td align="center"><%= c_no %></td>
	<td align="center"><%= c_name %></td> <td align="center"><%= c_credit %></td>
	<td align="center"><%= convertedTime %></td> <td align="center"><%= c_where %></td>
</tr>
<% 
		}
	}
	stmt.close();
	myConn.close();
%>

</body>
</html>