<%--
  Created by IntelliJ IDEA.
  User: cuiguangyuan
  Date: 2021/9/16
  Time: 18:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>用户注册</title>
    <link href="../css/signup_Style.css" rel="stylesheet">
    <script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.8.0.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap-5.1.3-dist/css/bootstrap.min.css">
</head>
<body class="text-center bg-light">
    <main class="form-signin">
        <form name="login" method="post" action="SignUp.act">
            <h1 class="h1 mb-3 fw-bold fs-2 fst-italic">用户注册</h1>
            <div class="form-floating">
                <input class="form-control" type="text" name="username" placeholder="用户名" maxlength="20" id="floatingInput" required>
                <label for="floatingInput">用户名</label>
            </div>
            <div class="form-floating">
                <input class="form-control" type="password" name="password_1" placeholder="密码" maxlength="20" id="floatingPassword_1" required>
                <label for="floatingPassword_1">密码</label>
            </div>
            <div class="form-floating">
                <input class="form-control" type="password" name="password_2" placeholder="密码" maxlength="20" id="floatingPassword_2" required>
                <label for="floatingPassword_2">确认密码</label>
            </div>
            <button class="w-100 t-1 btn btn-lg btn-primary" type="submit">注册并开始</button>
        </form>
    </main>
<script type="text/javascript" src="${pageContext.request.contextPath}/bootstrap-5.1.3-dist/js/bootstrap.min.js"></script>
</body>
</html>
<script>
    var incorrect = '<%=request.getParameter("incorrect")%>';
    if(incorrect == 'yes') {
        alert("两次输入密码不同!");
    }
</script>
<script>
    var err = '<%=request.getParameter("exist")%>';
    if(err == 'yes') {
        alert("用户已存在!");
    }
</script>
