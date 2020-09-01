<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>

<%
	String dbdriver = "oracle.jdbc.driver.OracleDriver";
	String dburl = "jdbc:oracle:thin:@localhost:1521:orcl";
	String s_id = (String)session.getAttribute("user");
	String c_id = request.getParameter("c_id");	
	
	Connection myConn = null;
	Statement stmt = null;
	String mySQL = null;
	
	String user = "dbdb";
	String passwd = "oracle";
	
	try{
		Class.forName(dbdriver);
		myConn = DriverManager.getConnection(dburl, user, passwd);
		stmt = myConn.createStatement();
		
		mySQL = "delete from enroll where e_sid = '" + s_id + "' and e_cid = '" + c_id + "'";
		int res = stmt.executeUpdate(mySQL);
		
		if(res > 0){%>
			<script>
				alert("<%=c_id%> 강의를 삭제했습니다. ");
				location.href = "delete.jsp";
			</script>
<% 		}
		else{ %>
			<script>
				alert("<%=c_id%> 강의 삭제가 실패했습니다. <%=s_id%> ");
				location.href = "delete.jsp";
			</script>
<%		}
	} catch (SQLException ex){
		System.err.println("SQLException: " + ex.getMessage());
	}
	stmt.close();
	myConn.close();
%>
