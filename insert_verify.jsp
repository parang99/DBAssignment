<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>수강신청 입력</title>
</head>
<body>
<%
	String e_sid = (String)session.getAttribute("user");
	String e_cid = request.getParameter("c_id");
	int e_cno = Integer.parseInt(request.getParameter("c_no"));
%>
<%
	Connection myConn = null;
	String result = null;
	String dburl = "jdbc:oracle:thin:@localhost:1521:orcl";
	String user = "dbdb";
	String passwd = "oracle";
	String dbdriver = "oracle.jdbc.driver.OracleDriver";
	
	try{
		Class.forName(dbdriver);
		myConn = DriverManager.getConnection(dburl, user, passwd);
	} catch (SQLException ex){
		System.err.println("SQLException: " + ex.getMessage());
	}
	//CallableStatement를 통한 저장 프로시저(insertEnroll) 사용
	CallableStatement cstmt = myConn.prepareCall("{call InsertEnroll(?, ?, ?, ?)}");
	cstmt.setString(1, e_sid);
	cstmt.setString(2, e_cid);
	cstmt.setInt(3, e_cno);
	cstmt.registerOutputParameter(4, java.sql.Trypes.VARCHAR);
	try{
		cstmt.execute();
		result = cstmt.getString(4);
%>
<!-- 저장 프로시저에서 작성된 복잡한 입력 규칙 검사를 다시 작성하지 않아도 됨 -->
<script>
	alert("<%= result %>");
	location.href = "insert.jsp";
</script>
<%
	} catch(SQLException ex){
		System.err.println("SQLException: " + ex.getMessage());
	} finally {
		if (cstmt != null)
			try { myConn.commit();
				cstmt.close();
				myConn.close();
			} catch(SQLException ex) {
				
			}
	}
%>
</body>
</html>