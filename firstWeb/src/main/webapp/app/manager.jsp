<%--
  Created by IntelliJ IDEA.
  User: cuiguangyuan
  Date: 2021/12/3
  Time: 20:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.firstweb.Application_Servlet" %>
<%@ page import="com.example.firstweb.Packet" %>
<%@ page import="com.example.firstweb.Car" %>
<%@ page import="com.sun.xml.internal.bind.v2.runtime.reflect.Lister" %>
<html>
<head>
    <title>欢迎</title>
    <link href="../css/manager_Style.css" rel="stylesheet">
    <script src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.8.0.js"></script>
    <script src="${pageContext.request.contextPath}/bootstrap-5.1.3-dist/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap-5.1.3-dist/css/bootstrap.min.css">
    <script type="text/javascript">
        $(function() {
            $('#main_box').children().hide();
        });
    </script>
</head>
<body>
<%
    if(request.getParameter("success") != null) {
        String success = request.getParameter("success");
        if(success.equals("1")) out.print("<script>alert('操作成功!')</script>");
        else if(success.equals("0")) out.print("<script>alert('操作失败, 请重试!')</script>");
        else out.print("<script>alert('不存在此用户!')</script>");
    }
%>
    <header class="p-3 mb-3 border-bottom">
        <div class="container">
            <div class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">
                <ul class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0">
                    <li class="mx-2">
                        <div class="dropdown show">
                            <a class="btn btn-secondary dropdown-toggle" href="#" id="dropdown_1" data-bs-toggle="dropdown" aria-expanded="false">
                                员工管理
                            </a>
                            <div class="dropdown-menu" aria-labelledby="dropdown_1">
                                <a class="dropdown-item" href="#" id="staff_searching">查询信息</a>
                                <a class="dropdown-item" href="#" id="staff_adding">添加员工/车辆</a>
                                <a class="dropdown-item" href="#" id="staff_deleting">删除员工/车辆</a>
                                <a class="dropdown-item" href="#" id="staff_revising">修改信息</a>
                            </div>
                        </div>
                    </li>
                    <li class="mx-2">
                        <div class="dropdown show">
                            <a class="btn btn-secondary dropdown-toggle" href="#" id="dropdown_2" data-bs-toggle="dropdown" aria-expanded="false">
                                订单管理
                            </a>
                            <div class="dropdown-menu" aria-labelledby="dropdown_2">
                                <a class="dropdown-item" href="#" id="packet_searching">查询订单</a>
                                <a class="dropdown-item" href="#" id="packet_adding">添加订单</a>
                                <a class="dropdown-item" href="#" id="packet_deleting">删除订单</a>
                                <a class="dropdown-item" href="#" id="packet_revising">修改订单</a>
                            </div>
                        </div>
                    </li>
                    <li class="mx-2"><a href="#" class="nav-link px-2 link-secondary" id="pkt_manage">订单处理</a></li>
                    <li class="mx-2"><a href="#" class="nav-link px-2 link-secondary">关于</a></li>
                </ul>

                <form class="col-12 col-lg-auto mb-3 mb-lg-0 me-lg-3">
                    <input type="search" class="form-control" placeholder="Search..." aria-label="Search">
                </form>

                <div class="dropdown text-end">
                    <a href="#" class="d-block link-dark text-decoration-none dropdown-toggle" id="dropdownUser1" data-bs-toggle="dropdown" aria-expanded="false">
                        <img src="https://github.com/mdo.png" alt="mdo" width="32" height="32" class="rounded-circle">
                    </a>
                    <ul class="dropdown-menu text-small" aria-labelledby="dropdownUser1">
                        <li><a class="dropdown-item" href="#">New project...</a></li>
                        <li><a class="dropdown-item" href="#">Settings</a></li>
                        <li><a class="dropdown-item" href="#">Profile</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item" href="#">Sign out</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </header>
    <div class="h-auto w-100 d-flex justify-content-center">

        <div class="container p-2 w-25 h-50 mx-3 bg-light rounded shadow" id="ready_to_send">
            <h4 class="text-center fs-2">待处理订单</h4>
            <div class="container">
                <% Application_Servlet.setHost("root"); %>
                <%@ include file="packet_list.jsp" %>
            </div>
        </div>

        <div class="container w-75 h-50 mx-3 bg-light rounded" id="main_box">

            <div class="container shadow" id="process_box">
                <h4 class="text-center fs-2">订单处理</h4>
                <div class="container">
                    <%@ include file="staff_list.jsp" %>
                </div>
                <div class="container">
                    <form class="needs-validation" method="post" action="Setting.app">
                        <div class="row g-3">
                            <div class="col-8">
                                <label for="packet_id" class="form-label">订单号</label>
                                <input name="packet_id" type="text" class="form-control" id="packet_id" placeholder="" required>
                                <div class="invalid-feedback">
                                    请填写订单号
                                </div>
                            </div>
                            <div class="col-8">
                                <label for="to_car_number" class="form-label">将要安排的车牌号</label>
                                <input name="to_car_number" type="text" class="form-control" id="to_car_number" placeholder="" required>
                                <div class="invalid-feedback">
                                    请填写车牌号
                                </div>
                            </div>
                            <button class="col-8 my-5 btn btn-outline-success btn-lg rounded-pill" type="submit">安排并发货</button>
                        </div>
                    </form>
                </div>
                <%
                    if(request.getParameter("setting") != null) {
                        String flag = request.getParameter("setting");
                        if(flag.equals("fail")) {
                            out.print("<script>alert('操作失败!')</script>");
                        }
                        else if(flag.equals("success")) {
                            out.print("<script>alert('操作成功, 订单已发货!')</script>");
                        }
                    }
                %>
            </div>

            <div class="container shadow" id="stf_search_box">
                <div class="container p-5">
                    <h4 class="mb-5 fs-2">查询员工信息</h4>
                    <form class="needs-validation" method="post" action="staff_search.app">
                        <div class="row g-3">
                            <div class="col-8">
                                <label for="stf_name" class="form-label">员工名称/车牌号</label>
                                <input name="info" type="text" class="form-control" id="stf_name" placeholder="" required>
                                <div class="invalid-feedback">
                                    请填写员工名称或者车牌号
                                </div>
                            </div>
                            <button class="col-8 my-5 btn btn-outline-success btn-lg rounded-pill" type="submit">查询</button>
                        </div>
                    </form>
                </div>
                <%  if(request.getParameter("wayback") != null) {
                        Car stf = (Car) request.getAttribute("staff_data");
                        if(stf != null) {
                            out.print("<script>alert('查询结果为: 员工姓名: " + stf.getDriver() + " 车牌号: " + stf.getCar_Number() + " ')</script>");
                        }
                        else {
                            out.print("<script>alert('搜索结果为空')</script>");
                        }
                    }
                %>
            </div>

            <div class="container shadow" id="stf_add_box">
                <div class="container p-5">
                    <h4 class="mb-5 fs-2">添加员工</h4>
                    <form class="needs-validation" method="post" action="staff_add.app">
                        <div class="row g-3">
                            <div class="col-8">
                                <label for="stf_name_add" class="form-label">员工名称</label>
                                <input name="name" type="text" class="form-control" id="stf_name_add" placeholder="" value="" required>
                                <div class="invalid-feedback">
                                    请填写员工名称
                                </div>
                            </div>
                            <div class="col-8">
                                <label for="stf_num_add" class="form-label">车牌号</label>
                                <input name="car_num" type="text" class="form-control" id="stf_num_add" placeholder="" value="" required>
                                <div class="invalid-feedback">
                                    请填写车牌号
                                </div>
                            </div>
                            <button class="col-8 my-5 btn btn-outline-success btn-lg rounded-pill" type="submit">添加</button>
                        </div>
                    </form>
                </div>
            </div>

            <div class="container shadow" id="stf_delete_box">
                <div class="container p-5">
                    <h4 class="mb-5 fs-2">删除员工</h4>
                    <form class="needs-validation" method="post" action="staff_delete.app">
                        <div class="row g-3">
                            <div class="col-8">
                                <label for="stf_name_delete" class="form-label">员工名称/车牌号</label>
                                <input name="info" type="text" class="form-control" id="stf_name_delete" placeholder="" value="" required>
                                <div class="invalid-feedback">
                                    请填写员工名称或者车牌号
                                </div>
                            </div>
                            <button class="col-8 my-5 btn btn-outline-success btn-lg rounded-pill" type="submit">删除</button>
                        </div>
                    </form>
                </div>
            </div>

            <div class="container shadow" id="stf_revise_box">
                <div class="container p-5">
                    <h4 class="mb-5 fs-2">修改员工信息</h4>
                    <form class="needs-validation" method="post" action="staff_revise.app">
                        <div class="row g-3">
                            <div class="col-8">
                                <label for="stf_name_revise_o" class="form-label">需要修改的员工名称/车牌号</label>
                                <input name="info" type="text" class="form-control" id="stf_name_revise_o" placeholder="" value="" required>
                                <div class="invalid-feedback">
                                    请填写员工名称或者车牌号
                                </div>
                            </div>
                            <div class="col-8">
                                <label for="stf_name_revise" class="form-label">修改后的员工名称</label>
                                <input name="name" type="text" class="form-control" id="stf_name_revise" placeholder="" value="" required>
                                <div class="invalid-feedback">
                                    请填写员工名称
                                </div>
                            </div>
                            <div class="col-8">
                                <label for="stf_num_revise" class="form-label">修改后的车牌号</label>
                                <input name="car_num" type="text" class="form-control" id="stf_num_revise" placeholder="" value="" required>
                                <div class="invalid-feedback">
                                    请填写车牌号
                                </div>
                            </div>
                            <button class="col-8 my-5 btn btn-outline-success btn-lg rounded-pill" type="submit">修改</button>
                        </div>
                    </form>
                </div>
            </div>

            <div class="container shadow" id="pkt_search_box">
                <div class="container p-5">
                    <h4 class="mb-5 fs-2">查询订单信息</h4>
                    <form class="needs-validation" method="post" action="pkt_search.app">
                        <div class="row g-3">
                            <div class="col-8">
                                <label for="pkt_name_search" class="form-label">包裹名称/订单号</label>
                                <input name="info" type="text" class="form-control" id="pkt_name_search" placeholder="" required>
                                <div class="invalid-feedback">
                                    请填写包裹名称或者订单号
                                </div>
                            </div>
                            <button class="col-8 my-5 btn btn-outline-success btn-lg rounded-pill" type="submit">查询</button>
                        </div>
                    </form>
                </div>
                <%  if(request.getParameter("wayback_") != null) {
                    Packet pkt = (Packet)request.getAttribute("pkt_data");
                    if(pkt != null) {
                        out.print("<script>alert('查询结果为: 订单状态: " + pkt.getStatus() + " 体积: " + pkt.getVolume() + " 重量: "
                                + pkt.getWeight() + " 订单号: " + pkt.getPacket_ID() +
                                " 货物名称: " +pkt.getPacket_Name() + " 发货人: " + pkt.getSender() +
                                " 收货人: " + pkt.getReceiver() + " 收货人联系方式: " + pkt.getI_Phone_Number()
                                + " 发货人联系方式: " + pkt.getO_phone_number() + " ')</script>");
                    }
                    else {
                        out.print("<script>alert('搜索结果为空')</script>");
                    }
                }
                %>
            </div>

            <div class="container shadow" id="pkt_add_box">
                <div class="container p-5">
                    <h4 class="mb-5 fs-2">添加包裹</h4>
                    <form class="needs-validation" method="post" action="pkt_add.app">
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
                            <button class="col-8 my-5 btn btn-outline-success btn-lg rounded-pill" type="submit">提交</button>
                        </div>
                    </form>
                </div>
            </div>

            <div class="container shadow" id="pkt_delete_box">
                <div class="container p-5">
                    <h4 class="mb-5 fs-2">删除订单</h4>
                    <form class="needs-validation" method="post" action="pkt_delete.app">
                        <div class="row g-3">
                            <div class="col-8">
                                <label for="pkt_name_delete" class="form-label">包裹名称/订单号</label>
                                <input name="info" type="text" class="form-control" id="pkt_name_delete" placeholder="" required>
                                <div class="invalid-feedback">
                                    请填写包裹名称或者订单号
                                </div>
                            </div>
                            <button class="col-8 my-5 btn btn-outline-success btn-lg rounded-pill" type="submit">查询</button>
                        </div>
                    </form>
                </div>
            </div>

            <div class="container shadow" id="pkt_revise_box">
                <div class="container p-5">
                    <h4 class="mb-5 fs-2">修改包裹信息</h4>
                    <form class="needs-validation" method="post" action="pkt_revise.app">
                        <div class="row g-3">
                            <div class="col-sm-4">
                                <label for="sending_revise" class="form-label">发货人</label>
                                <input name="sender" type="text" class="form-control" id="sending_revise" placeholder="" value="" required>
                                <div class="invalid-feedback">
                                    请填写发货人姓名
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <label for="receiving_revise" class="form-label">收货人</label>
                                <input name="receiver" type="text" class="form-control" id="receiving_revise" placeholder="" value="" required>
                                <div class="invalid-feedback">
                                    请填写收货人姓名
                                </div>
                            </div>

                            <div class="col-8">
                                <label for="sender_number_revise" class="form-label">发货人联系方式</label>
                                <input name="o_number" type="text" class="form-control" id="sender_number_revise" placeholder="" required>
                                <div class="invalid-feedback">
                                    请输入发货人的联系方式
                                </div>
                            </div>

                            <div class="col-8">
                                <label for="receiver_number_revise" class="form-label">收货人联系方式</label>
                                <input name="i_number" type="text" class="form-control" id="receiver_number_revise" placeholder="" required>
                                <div class="invalid-feedback">
                                    请输入收货人的联系方式
                                </div>
                            </div>

                            <div class="col-8">
                                <label for="pkt_name_revise" class="form-label">货物名称</label>
                                <input name="obj_name" type="text" class="form-control" id="pkt_name_revise" placeholder="" required>
                                <div class="invalid-feedback">
                                    请输入货物名称
                                </div>
                            </div>

                            <div class="col-8">
                                <label for="volume_revise" class="form-label">货物体积<span class="text-muted">(Optional)</span></label>
                                <input name="volume" type="text" class="form-control" value="0" id="volume_revise" placeholder="">
                            </div>

                            <div class="col-8">
                                <label for="weight_revise" class="form-label">货物重量<span class="text-muted">(Optional)</span></label>
                                <input name="weight" type="text" class="form-control" value="0" id="weight_revise" placeholder="">
                            </div>
                            <div class="col-8">
                                <label for="pkt_name_reivse_1" class="form-label">需要修改的包裹名称/订单号</label>
                                <input name="info" type="text" class="form-control" id="pkt_name_reivse_1" placeholder="" required>
                                <div class="invalid-feedback">
                                    请填写包裹名称或者订单号
                                </div>
                            </div>
                            <button class="col-8 my-5 btn btn-outline-success btn-lg rounded-pill" type="submit">提交</button>
                        </div>
                    </form>
                </div>
            </div>

        </div>
    </div>
    <script src="${pageContext.request.contextPath}/bootstrap-5.1.3-dist/js/bootstrap.bundle.min.js"></script>
    <script type="text/javascript">
        $('#staff_searching').click(function() {
            $('#main_box').children().hide();
            $('#stf_search_box').show();
        });
        $('#staff_adding').click(function() {
            $('#main_box').children().hide();
            $('#stf_add_box').show();
        });
        $('#staff_deleting').click(function() {
            $('#main_box').children().hide();
            $('#stf_delete_box').show();
        });
        $('#staff_revising').click(function() {
            $('#main_box').children().hide();
            $('#stf_revise_box').show();
        });
        $('#packet_searching').click(function() {
            $('#main_box').children().hide();
            $('#pkt_search_box').show();
        });
        $('#packet_adding').click(function() {
            $('#main_box').children().hide();
            $('#pkt_add_box').show();
        });
        $('#packet_deleting').click(function() {
            $('#main_box').children().hide();
            $('#pkt_delete_box').show();
        });
        $('#packet_revising').click(function() {
            $('#main_box').children().hide();
            $('#pkt_revise_box').show();
        });
        $('#pkt_manage').click(function() {
            $('#main_box').children().hide();
            $('#process_box').show();
        });
    </script>
</body>
</html>
