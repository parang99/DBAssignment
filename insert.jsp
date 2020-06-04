<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수강신청 입력</title>
</head>
<body>
<%@ include file="top.jsp" %>
<% if (session_id == null) response.sendRedirect("login.jsp"); %>

<table width="75%" align="center" border>
<br>
<tr> <th>과목번호</th> <th>분반</th> <th>과목명</th> <th>학점</th> <th>수강신청</th></tr>
<%
Connection myConn = null;
Statement stmt = null;
ResultSet myResultSet = null;
String mySQL = "";
String dburl = "jdbc:oracle:thin:@localhost:1521:orcl";
String user = "dbdb";
String passwd = "oracle";
String dbdriver = "oracle.jdbc.driver.OracleDriver";
String s_id = (String)session.getAttribute("user");

int nSum = 0;
int nCredit = 0;
try{
	Class.forName(dbdriver);
	myConn = DriverManager.getConnection(dburl, user, passwd);
	stmt = myConn.createStatement();
} catch(SQLException ex){
	System.err.println("SQLException: " + ex.getMessage());
}

mySQL = "select c_id, c_no, c_name, c_credit from course where (c_id, c_no) not in (select e_cid, e_cno from enroll where e_sid = '" + session_id + "')";

myResultSet = stmt.executeQuery(mySQL);

if (myResultSet != null){
	while(myResultSet.next()){
		String c_id = myResultSet.getString("c_id");
		int c_no = myResultSet.getInt("c_no");
		String c_name = myResultSet.getString("c_name");
		int c_credit = myResultSet.getInt("c_credit");		
%>

<tr>
	<td align="center"><%= c_id %></td> <td align="center"><%= c_no %></td>
	<td align="center"><%= c_name %></td> <td align="center"><%= c_credit %></td>
	<td align="center"><a href="insert_verify.jsp?c_id=<%=c_id%>&c_no=<%=c_no %>">신청</a></td>
</tr>
<% 
		}
	}

	CallableStatement cstmt = myConn.prepareCall("{call SelectTimeTable(?, ?, ?, ?, ?)}");
	cstmt.setString(1, s_id);
	cstmt.setInt(2, 2020);
	cstmt.setInt(3, 2);
	cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
	cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
	try{
		cstmt.execute();
		nSum = cstmt.getInt(4);
		nCredit = cstmt.getInt(5);
	
	} catch(SQLException ex){
		System.err.println("SQLException: " + ex.getMessage());
	}
	stmt.close();
	myConn.close();
%>
</table>
<br>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	현재 신청 학점 수 : <%= nCredit %> </div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	신청 가능 학점 수 : <%= 18 - nCredit %> </div>
<div align="center">
   <br><button type="button" onclick="location.href='main.jsp'">메인 화면</button>
</div>
</body>
</html>