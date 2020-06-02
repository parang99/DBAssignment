<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
String dbdriver = "oracle.jdbc.driver.OracleDriver";
String dburl = "jdbc:oracle:thin:@localhost:1521:orcl";
String userID=request.getParameter("userID");
String userPassword=request.getParameter("userPassword");

//DBA 계정
String user = "dbdb";
String passwd = "oracle";

Connection myConn = null;
Statement stmt = null;
String mySQL = null;

try{
	Class.forName(dbdriver);
	myConn = DriverManager.getConnection(dburl, user, passwd);
	stmt = myConn.createStatement();
} catch(SQLException ex){
	System.err.println("SQLException: " + ex.getMessage());
}

mySQL="select s_id from student where s_id='" + userID + "'and s_pwd='" + userPassword + "'";
ResultSet myResultSet = stmt.executeQuery(mySQL);
%>
<% if(myResultSet.next()){%>
	<%session.setAttribute("user", userID);%>
	<script>
		location.href="main.jsp";
	</script>
	
<%} else{ %>
	<script>
		alert("로그인에 실패했습니다.");
		location.href="login.jsp";
	</script>
<% } %>
<%
stmt.close();
myConn.close();
%>