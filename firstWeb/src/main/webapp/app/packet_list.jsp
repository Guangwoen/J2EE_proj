<%--
  Created by IntelliJ IDEA.
  User: cuiguangyuan
  Date: 2021/12/9
  Time: 16:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.firstweb.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.example.firstweb.Packet" %>
<html>
<head>
    <link href="../css/packet_list_Style.css" rel="stylesheet">
    <script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.8.0.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/bootstrap-5.1.3-dist/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap-5.1.3-dist/css/bootstrap.min.css">
</head>
<body>
<div class="container my-2">
    <table class="table">
        <% ArrayList<Packet> dt = (new Application_Servlet()).getDataFromDB(); %>
        <% if(dt == null) out.print("<h1>获取列表失败!</h1>");
           else if(dt.size() == 0) out.println("<h1>列表为空!</h1>");
           else {
                out.print("<thead class=\"thead-light\">\n" +
                       "    <tr>\n" +
                       "        <th scope=\"col\">#</th>\n" +
                       "        <th scope=\"col\">订单号</th>\n" +
                       "        <th scope=\"col\">货物名称</th>\n" +
                       "        <th scope=\"col\">发货人</th>\n" +
                       "        <th scope=\"col\">收货人</th>\n" +
                       "        <th scope=\"col\">订单状态</th>\n" +
                       "    </tr>\n" +
                       "    </thead>\n" +
                       "<tbody>");
                int count = 1;
                for(Packet pkt : dt) {
                String st = null;
                int status = pkt.getStatus();
                if(status == 0) st = "未发货";
                else if(status == 1) st = "已发货";
                else st = "已收货";
                out.print("<tr>");
                out.print("<th scope=\"row\">" + count++ + "</th>");
                out.print("<td>" + pkt.getPacket_ID() + "</td>");
                out.print("<td>" + pkt.getPacket_Name() + "</td>");
                out.print("<td>" + pkt.getSender() + "</td>");
                out.print("<td>" + pkt.getReceiver() + "</td>");
                out.print("<td>" + st + "</td>");
                out.print("</tr>");
            }
        }%>
    </table>
</div>
</body>
</html>
