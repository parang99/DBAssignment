<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>������û ����� ���� ����</title>
</head>
<body>

<!-- ... -->

<%

// ...

try{
	
	// ...
	
} catch(SQLException ex){
	String sMessage;
	if (ex.getErrorCode() == 20002)
		sMessage = "��ȣ�� 4�ڸ� �̻��̾�� �մϴ�";
	else if (ex.getErrorCode() == 20003)
		sMessage = "��ȣ�� ������ �Էµ��� �ʽ��ϴ�.";
	else
		sMessage = "��� �� �ٽ� �õ��Ͻʽÿ�";
}

%>

<!-- ... -->

</body>
</html>