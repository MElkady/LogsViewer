<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">

<%@ page contentType="text/html;charset=windows-1256"%>

<html>
<head>
	<title>Logs Manager</title>
</head>
<%! String dir = ""; %>
<% dir = request.getParameter("dir");
if(dir == null || dir.length() < 1){
	dir = "logs";
} %>
<frameset cols="20%, 80%">
	<frame src="browser.jsp?dir=<%= dir %>" name="browser" />
	<frame src="viewer.jsp" name="viewer" />
</frameset>
</html>