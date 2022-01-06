<%@ page import="com.sun.xml.internal.bind.v2.runtime.reflect.Lister"
    import="com.example.firstweb.Packet"
%><%--
  Created by IntelliJ IDEA.
  User: cuiguangyuan
  Date: 2021/12/2
  Time: 18:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.firstweb.Application_Servlet" %>
<html>
<head>
    <% String usr = request.getParameter("usr");%>
    <title>欢迎回来-<%=usr%></title>
    <link href="../css/main_Style.css" rel="stylesheet">
    <script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.8.0.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap-5.1.3-dist/css/bootstrap.min.css">
    <script type="text/javascript">
        $(function() {
            $("#sending_box").hide();
            $("#receiving_box").hide();
        });
        $(function() {
            $("#show_sending").click(function() {
                $("#default").hide();
                $("#receiving_box").hide();
                $("#sending_box").show();
            });
        });
        $(function() {
            $("#show_receiving").click(function() {
                $("#default").hide();
                $("#sending_box").hide();
                $("#receiving_box").show();
            });
        });
    </script>
</head>
<body>
<main>
    <div class="d-flex flex-column flex-shrink-0 bg-light" style="width: 10rem;">
        <ul class="nav nav-pills nav-flush flex-column mb-auto text-center">
            <li class="nav-item">
                <a href="../index.jsp" class="nav-link py-3 border-bottom" aria-current="page" title="Home" data-bs-toggle="tooltip" data-bs-placement="right">
                    <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-truck" viewBox="0 0 16 16">
                        <path d="M0 3.5A1.5 1.5 0 0 1 1.5 2h9A1.5 1.5 0 0 1 12 3.5V5h1.02a1.5 1.5 0 0 1 1.17.563l1.481 1.85a1.5 1.5 0 0 1 .329.938V10.5a1.5 1.5 0 0 1-1.5 1.5H14a2 2 0 1 1-4 0H5a2 2 0 1 1-3.998-.085A1.5 1.5 0 0 1 0 10.5v-7zm1.294 7.456A1.999 1.999 0 0 1 4.732 11h5.536a2.01 2.01 0 0 1 .732-.732V3.5a.5.5 0 0 0-.5-.5h-9a.5.5 0 0 0-.5.5v7a.5.5 0 0 0 .294.456zM12 10a2 2 0 0 1 1.732 1h.768a.5.5 0 0 0 .5-.5V8.35a.5.5 0 0 0-.11-.312l-1.48-1.85A.5.5 0 0 0 13.02 6H12v4zm-9 1a1 1 0 1 0 0 2 1 1 0 0 0 0-2zm9 0a1 1 0 1 0 0 2 1 1 0 0 0 0-2z"/>
                    </svg>
                </a>
            </li>
            <li>
                <a href="#" class="nav-link py-3 border-bottom" id="show_sending" title="Dashboard" data-bs-toggle="tooltip" data-bs-placement="right">
                    <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-send" viewBox="0 0 16 16">
                        <path d="M15.854.146a.5.5 0 0 1 .11.54l-5.819 14.547a.75.75 0 0 1-1.329.124l-3.178-4.995L.643 7.184a.75.75 0 0 1 .124-1.33L15.314.037a.5.5 0 0 1 .54.11ZM6.636 10.07l2.761 4.338L14.13 2.576 6.636 10.07Zm6.787-8.201L1.591 6.602l4.339 2.76 7.494-7.493Z"/>
                    </svg>
                </a>
            </li>
            <li>
                <a href="#" class="nav-link py-3 border-bottom" id="show_receiving" title="Orders" data-bs-toggle="tooltip" data-bs-placement="right">
                    <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-cart2" viewBox="0 0 16 16">
                        <path d="M0 2.5A.5.5 0 0 1 .5 2H2a.5.5 0 0 1 .485.379L2.89 4H14.5a.5.5 0 0 1 .485.621l-1.5 6A.5.5 0 0 1 13 11H4a.5.5 0 0 1-.485-.379L1.61 3H.5a.5.5 0 0 1-.5-.5zM3.14 5l1.25 5h8.22l1.25-5H3.14zM5 13a1 1 0 1 0 0 2 1 1 0 0 0 0-2zm-2 1a2 2 0 1 1 4 0 2 2 0 0 1-4 0zm9-1a1 1 0 1 0 0 2 1 1 0 0 0 0-2zm-2 1a2 2 0 1 1 4 0 2 2 0 0 1-4 0z"/>
                    </svg>
                </a>
            </li>
            <li>
                <a href="#" class="nav-link py-3 border-bottom" title="Products" data-bs-toggle="tooltip" data-bs-placement="right">
                    <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-envelope" viewBox="0 0 16 16">
                        <path d="M0 4a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V4Zm2-1a1 1 0 0 0-1 1v.217l7 4.2 7-4.2V4a1 1 0 0 0-1-1H2Zm13 2.383-4.708 2.825L15 11.105V5.383Zm-.034 6.876-5.64-3.471L8 9.583l-1.326-.795-5.64 3.47A1 1 0 0 0 2 13h12a1 1 0 0 0 .966-.741ZM1 11.105l4.708-2.897L1 5.383v5.722Z"/>
                    </svg>
                </a>
            </li>
            <li>
                <a href="#" class="nav-link py-3 border-bottom" title="Customers" data-bs-toggle="tooltip" data-bs-placement="right">
                    <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-file-person" viewBox="0 0 16 16">
                        <path d="M12 1a1 1 0 0 1 1 1v10.755S12 11 8 11s-5 1.755-5 1.755V2a1 1 0 0 1 1-1h8zM4 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H4z"/>
                        <path d="M8 10a3 3 0 1 0 0-6 3 3 0 0 0 0 6z"/>
                    </svg>
                </a>
            </li>
        </ul>
    </div>
    <div class="m-auto h-auto w-auto bg-light p-5 rounded" id="default">
        <div class="container m-auto">
            <h4 class="mb-5 fs-2">索引</h4>
        </div>
        <div class="container" id="index_1">
            <h1 class="h1 mb-3 fw-light fs-2">
                <svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" fill="currentColor" class="bi bi-truck" viewBox="0 0 16 16">
                    <path d="M0 3.5A1.5 1.5 0 0 1 1.5 2h9A1.5 1.5 0 0 1 12 3.5V5h1.02a1.5 1.5 0 0 1 1.17.563l1.481 1.85a1.5 1.5 0 0 1 .329.938V10.5a1.5 1.5 0 0 1-1.5 1.5H14a2 2 0 1 1-4 0H5a2 2 0 1 1-3.998-.085A1.5 1.5 0 0 1 0 10.5v-7zm1.294 7.456A1.999 1.999 0 0 1 4.732 11h5.536a2.01 2.01 0 0 1 .732-.732V3.5a.5.5 0 0 0-.5-.5h-9a.5.5 0 0 0-.5.5v7a.5.5 0 0 0 .294.456zM12 10a2 2 0 0 1 1.732 1h.768a.5.5 0 0 0 .5-.5V8.35a.5.5 0 0 0-.11-.312l-1.48-1.85A.5.5 0 0 0 13.02 6H12v4zm-9 1a1 1 0 1 0 0 2 1 1 0 0 0 0-2zm9 0a1 1 0 1 0 0 2 1 1 0 0 0 0-2z"/>
                </svg> 返回登陆页面
            </h1>
        </div>
        <div class="container" id="index_2">
            <h1 class="h1 mb-3 fw-light fs-2">
                <svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" fill="currentColor" class="bi bi-send" viewBox="0 0 16 16">
                    <path d="M15.854.146a.5.5 0 0 1 .11.54l-5.819 14.547a.75.75 0 0 1-1.329.124l-3.178-4.995L.643 7.184a.75.75 0 0 1 .124-1.33L15.314.037a.5.5 0 0 1 .54.11ZM6.636 10.07l2.761 4.338L14.13 2.576 6.636 10.07Zm6.787-8.201L1.591 6.602l4.339 2.76 7.494-7.493Z"/>
                </svg> 创建订单
            </h1>
        </div>
        <div class="container" id="index_3">
            <h1 class="h1 mb-3 fw-light fs-2">
                <svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" fill="currentColor" class="bi bi-cart2" viewBox="0 0 16 16">
                    <path d="M0 2.5A.5.5 0 0 1 .5 2H2a.5.5 0 0 1 .485.379L2.89 4H14.5a.5.5 0 0 1 .485.621l-1.5 6A.5.5 0 0 1 13 11H4a.5.5 0 0 1-.485-.379L1.61 3H.5a.5.5 0 0 1-.5-.5zM3.14 5l1.25 5h8.22l1.25-5H3.14zM5 13a1 1 0 1 0 0 2 1 1 0 0 0 0-2zm-2 1a2 2 0 1 1 4 0 2 2 0 0 1-4 0zm9-1a1 1 0 1 0 0 2 1 1 0 0 0 0-2zm-2 1a2 2 0 1 1 4 0 2 2 0 0 1-4 0z"/>
                </svg> 查看本人订单
            </h1>
        </div>
        <div class="container" id="index_4">
            <h1 class="h1 mb-3 fw-light fs-2">
                <svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" fill="currentColor" class="bi bi-envelope" viewBox="0 0 16 16">
                    <path d="M0 4a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V4Zm2-1a1 1 0 0 0-1 1v.217l7 4.2 7-4.2V4a1 1 0 0 0-1-1H2Zm13 2.383-4.708 2.825L15 11.105V5.383Zm-.034 6.876-5.64-3.471L8 9.583l-1.326-.795-5.64 3.47A1 1 0 0 0 2 13h12a1 1 0 0 0 .966-.741ZM1 11.105l4.708-2.897L1 5.383v5.722Z"/>
                </svg> 留言板(暂未开通)
            </h1>
        </div>
        <div class="container" id="index_5">
            <h1 class="h1 mb-3 fw-light fs-2">
                <svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" fill="currentColor" class="bi bi-file-person" viewBox="0 0 16 16">
                    <path d="M12 1a1 1 0 0 1 1 1v10.755S12 11 8 11s-5 1.755-5 1.755V2a1 1 0 0 1 1-1h8zM4 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H4z"/>
                    <path d="M8 10a3 3 0 1 0 0-6 3 3 0 0 0 0 6z"/>
                </svg> 个人信息(暂未开通)
            </h1>
        </div>
    </div>
    <div class="container p-5" id="sending_box">
        <h4 class="mb-5 fs-2">包裹基本信息</h4>
        <form class="needs-validation" method="post" action="Sending.app">
            <div class="row g-3">
                <div class="col-sm-4">
                    <label for="sending" class="form-label">发货人</label>
                    <input name="sender" type="text" class="form-control" id="sending" placeholder="" value="" required>
                    <div class="invalid-feedback">
                        请填写发货人姓名
                    </div>
                </div>
                <div class="col-sm-4">
                    <label for="receiving" class="form-label">收货人</label>
                    <input name="receiver" type="text" class="form-control" id="receiving" placeholder="" value="" required>
                    <div class="invalid-feedback">
                        请填写收货人姓名
                    </div>
                </div>

                <div class="col-8">
                    <label for="sender_number" class="form-label">发货人联系方式</label>
                    <input name="o_number" type="text" class="form-control" id="sender_number" placeholder="" required>
                    <div class="invalid-feedback">
                        请输入发货人的联系方式
                    </div>
                </div>

                <div class="col-8">
                    <label for="receiver_number" class="form-label">收货人联系方式</label>
                    <input name="i_number" type="text" class="form-control" id="receiver_number" placeholder="" required>
                    <div class="invalid-feedback">
                        请输入收货人的联系方式
                    </div>
                </div>

                <div class="col-8">
                    <label for="pkt_name" class="form-label">货物名称</label>
                    <input name="obj_name" type="text" class="form-control" id="pkt_name" placeholder="" required>
                    <div class="invalid-feedback">
                        请输入货物名称
                    </div>
                </div>

                <div class="col-8">
                    <label for="volume" class="form-label">货物体积<span class="text-muted">(Optional)</span></label>
                    <input name="volume" type="text" class="form-control" value="0" id="volume" placeholder="">
                </div>

                <div class="col-8">
                    <label for="weight" class="form-label">货物重量<span class="text-muted">(Optional)</span></label>
                    <input name="weight" type="text" class="form-control" value="0" id="weight" placeholder="">
                </div>
                <button class="w-50 my-5 ms-2 btn btn-outline-success btn-lg rounded-pill" type="submit">提交</button>
            </div>
        </form>
    </div>
    <div id="receiving_box" class="container p-3">
        <h4 class="mb-5 fs-2">我的订单</h4>
        <% Application_Servlet.setHost(usr); %>
        <%@ include file="packet_list.jsp"%>
        <div class="container my-5">
            <h4 class="mb-5 fs-2">确认收货</h4>
            <form class="needs-validation" method="post" action="Receiving.app">
                <div class="row g-3">
                    <div class="col-8">
                        <label for="packet_id" class="form-label">订单号</label>
                        <input name="pkt_id" type="text" class="form-control" id="packet_id" placeholder="" required>
                        <div class="invalid-feedback">
                            请填写订单号
                        </div>
                    </div>
                    <button class="col-8 my-5 btn btn-outline-success btn-lg rounded-pill" type="submit">我已收货</button>
                </div>
            </form>
        </div>
        <%
            if(request.getParameter("receive_set") != null) {
                String flag = request.getParameter("receive_set");
                if(flag.equals("fail")) {
                    out.print("<script>alert('收货失败, 请重试!')</script>");
                }
                else if(flag.equals("success")) {
                    out.print("<script>alert('收货成功!')</script>");
                }
            }
        %>
    </div>
</main>
<script type="text/javascript" src="${pageContext.request.contextPath}/bootstrap-5.1.3-dist/js/bootstrap.min.js"></script>
</body>
</html>
<script src="../js/control_1.js"></script>
<script type="text/javascript">
    var success = <%=request.getParameter("success")%>
    if(success == 1) alert("订单生成成功!");
    else if(success == 0) alert("订单生成失败, 请重试!");
</script>