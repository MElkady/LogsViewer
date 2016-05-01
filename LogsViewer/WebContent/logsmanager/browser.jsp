<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@ page contentType="text/html;charset=windows-1256"%>
<%@ page import="java.io.File"%>
<%@ page import="java.util.ArrayList"%>
<html>
<head>
	<title>File Browser</title>
	<script type="text/javascript" src="../js/jquery.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function(){
			$("#refreshLink").click(function(){
				window.location.reload();
			});
			$("#deleteLink").click(function(){
				parent.viewer.location = "./delete.jsp?file=" + getSelectedFiles();
			});
			$("#packLink").click(function(){
				parent.viewer.location = "./pack.jsp?files=" + getSelectedFiles();
			});
		});
		
		function getSelectedFiles(){
			var text = "";
			$(".deletionComboboxes[checked=true]").each(function(){
				text += $(this).val() + ";";
			});
			return text;
		}
	</script>
</head>
<% String dirToView = request.getParameter("dir"); 
File dir = new File(dirToView); %>
<body>
	<div>
		<a href="browser.jsp?dir=<%= dir.getParent() %>" id="upLink"><img src="../images/up.png" alt="Up one level" style="{border:0;}" /></a>
		<a href="#" id="refreshLink"><img src="../images/refresh.png" alt="Refresh" style="{border:0;}" /></a>
	</div>
	<hr />
	<div id="browser" style="white-space: nowrap;">
		<% if(dirToView != null && dirToView.length() > 0){
			if(dir.exists() && dir.isDirectory()){
				out.write("Current Path: <br />");
				out.write(dir.getAbsolutePath() + "<br />");
				String[] items = dir.list();
				if(items.length > 0){
					ArrayList<File> files = new ArrayList<File>();
					ArrayList<File> folders = new ArrayList<File>();
					for (int i = 0; i < items.length; i++)  {
						File f = new File(dirToView + "/" + items[i]);
						if(f.isDirectory()){
							folders.add(f);
						} else {
							files.add(f);
						}
					}
					
					java.util.Comparator<File> filesComparator = new java.util.Comparator<File>(){ 
						public int compare(File o1, File o2){
							return o1.getName().compareTo(o2.getName());
						}
					};
					
					java.util.Collections.sort(files, filesComparator);
					java.util.Collections.sort(folders, filesComparator);
					
					for(File folder : folders){%>
							<img src="../images/folder.png" alt="Folder" />
							<a href="browser.jsp?dir=<%= folder.getAbsolutePath() %>" title="Name: <%= folder.getName() %>" ><%= folder.getName() %></a><br />
					<%} 
					for (File file : files){ %>
							<img src="../images/file.png" alt="File" />
							<a href="viewer.jsp?file=<%= file.getAbsolutePath() %>" title="Name: <%= file.getName() %>&#10;Size: <%= file.length() %>" target="viewer" ><%= file.getName() %></a><br />
					<%}
				} else {
					out.write("Empty directory");
				}
			} else { 
				out.write("Directory dosen't exist");
			}
		} else {
			out.write("No file to view");
		} %>
	</div>
</body>
</html>