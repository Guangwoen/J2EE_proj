<%--
  Created by IntelliJ IDEA.
  User: cuiguangyuan
  Date: 2021/12/20
  Time: 16:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.firstweb.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.example.firstweb.Car" %>
<html>
<head>
    <link href="../css/packet_list_Style.css" rel="stylesheet">
    <script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.8.0.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/bootstrap-5.1.3-dist/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap-5.1.3-dist/css/bootstrap.min.css">
</head>
<body>
<div class="container">
    <table class="table">
        <% ArrayList<Car> ct = (new Application_Servlet()).getStaffFromDB(); %>
        <% if(ct == null) out.print("<h1>获取列表失败!</h1>");
        else if(ct.size() == 0) out.println("<h1>列表为空!</h1>");
        else {
            out.print("<thead class=\"thead-light\">\n" +
                    "    <tr>\n" +
                    "        <th scope=\"col\">#</th>\n" +
                    "        <th scope=\"col\">姓名</th>\n" +
                    "        <th scope=\"col\">车牌号</th>\n" +
                    "    </tr>\n" +
                    "    </thead>\n" +
                    "<tbody>");
            int count = 1;
            for(Car stf : ct) {
                String st = null;
                int status = stf.getStatus();
                if(status == 0) st = "空闲";
                else if(status == 1) st = "工作中";
                out.print("<tr>");
                out.print("<th scope=\"row\">" + count++ + "</th>");
                out.print("<td>" + stf.getDriver() + "</td>");
                out.print("<td>" + stf.getCar_Number() + "</td>");
                out.print("<td>" + st + "</td>");
                out.print("</tr>");
            }
        }%>
    </table>
</div>
</body>
</html>
