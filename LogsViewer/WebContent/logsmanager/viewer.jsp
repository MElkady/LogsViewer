<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@ page contentType="text/html;charset=windows-1256"%>
<%@ page import="com.mak.*"%>
<html>
<head>
	<title>File Viewer</title>
	<script type="text/javascript" src="../js/jquery.min.js"></script>
	<script type="text/javascript">
		var autoReload = false;
		$(document).ready(function(){
			$("#refreshLink").click(function(){
				document.location.reload();
			});
			if(autoReload){
				pointToBottom();
				setTimeout(document.location.reload, 10000);
			}
		});
		
		function pointToBottom(){
			document.location.href = document.location.href + "#bottomlink";
		}
	</script>
</head>
<body>
<div>
	<% String fileToView = request.getParameter("file");
	if(fileToView != null && fileToView.length() > 0){ 
		try {%>
			<div id="control">
				<a href="saver.jsp?file=<%= fileToView %>"><img src="../images/save.png" alt="Save File" style="{border:0;}" /></a>
				<a href="#" id="refreshLink"><img src="../images/refresh.png" alt="Refresh" style="{border:0;}" /></a>
				<a href="#bottomlink" id="downLink"><img src="../images/down.png" alt="Go down" style="{border:0;}" /></a>
			</div>
			<hr />
			<div id="viewer">
				<pre><%= LoggingService.readLoggingFile(request.getParameter("file")).replaceAll("\r\n", "<br />") %></pre>
			</div>
		<% } catch (Exception ex){ 
			out.write("Error: " + ex.getMessage() + "<br /><br />");
			for(StackTraceElement elem : ex.getStackTrace()){
				out.write(elem.toString() + "<br />	");
			}
		}
	} else { 
		out.write("No file to view");
	}%>
	<a name="bottomlink">&nbsp;</a>
</div>
</body>
</html>