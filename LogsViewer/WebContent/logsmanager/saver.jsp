<%@ page import="com.mak.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%! String fileToView = ""; %>
<% fileToView = request.getParameter("file");
response.reset();
response.setContentType("text/plain");
response.setHeader("Content-Disposition", "attachment; filename=\"" + (new SimpleDateFormat("yyyyMMdd_HHmmss")).format(new Date()) + "_" + fileToView + "\"");
if(fileToView != null && fileToView.length() > 0){ 
	try {
		out.write(LoggingService.readLoggingFile(request.getParameter("file")));
	} catch (Exception ex){
		out.write("Error:" + ex.getMessage() + "\r\n\r\n");
		for(StackTraceElement elem : ex.getStackTrace()){
			out.write(elem.toString() + "\r\n");
		}
	}
} else {
	out.write("No file to view");
}
response.flushBuffer(); 
out.close(); %>