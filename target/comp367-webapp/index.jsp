<%@ page import="java.time.LocalTime" %>
<%
    String name = "Abdulkadir";
    String greeting = LocalTime.now().getHour() < 12 ? "Good morning" : "Good afternoon";
%>

<html>
<body>
h2><%= greeting %>, <%= name %>, Welcome to COMP367</h2>
</body>
</html>
