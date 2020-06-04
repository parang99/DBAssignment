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
<%
String dbdriver = "oracle.jdbc.driver.OracleDriver";
String dburl = "jdbc:oracle:thin:@localhost:1521:orcl";

//DBA 계정
String user = "dbdb";
String passwd = "oracle";

Connection myConn = null;
PreparedStatement pstmt = null;
String mySQL = null;
ResultSet myResultSet = null;

String new_id =  new String(request.getParameter("s_id").getBytes("ISO-8859-1"), "UTF-8");
String new_pwd =  new String(request.getParameter("s_pwd").getBytes("ISO-8859-1"), "UTF-8");
String new_name = new String(request.getParameter("s_name").getBytes("ISO-8859-1"), "UTF-8");
String new_addr =  new String(request.getParameter("s_addr").getBytes("ISO-8859-1"), "UTF-8");

try{
	Class.forName(dbdriver);
	myConn = DriverManager.getConnection(dburl, user, passwd);
	mySQL = "update student set s_id = ?, s_pwd = ?, s_name = ?, s_addr = ? where s_id = ?";
	pstmt = myConn.prepareStatement(mySQL);
	
	pstmt.setString(1, new_id);
	pstmt.setString(2, new_pwd);
	pstmt.setString(3, new_name);
	pstmt.setString(4, new_addr);
	pstmt.setString(5, session_id);
	
	int res = pstmt.executeUpdate();
	//바뀐게 없을 때 수정된 사항이 없다고도 표시...? 
	//하려면 select s_pwd from student where s_id = s_id로 s_pwd 가져온 다음에 
	//s_pwd랑 new_pwd 비교해서 같으면 수정사항 없다고 함.
	if(res > 0){%>
		<%session.setAttribute("user", new_id);%>
		<script>
			alert("수정되었습니다.");
			location.href="update.jsp";
		</script>
	<%}
} catch(SQLException ex){
	String sMessage;
	if (ex.getErrorCode() == 20002)
		sMessage = "암호는 4자리 이상이어야 합니다.";
	else if (ex.getErrorCode() == 20003)
		sMessage = "암호에 공란은 입력되지 않습니다.";
	else if (ex.getErrorCode() == 1407) //비밀번호 null값 처리
		sMessage = "비밀번호를 입력해주세요.";
	else
		sMessage = "잠시 후 다시 시도하십시오.";%>
	<script>
		alert("<%= sMessage %>");
		location.href="update.jsp";
	</script>
<%}%>
</body>
</html>