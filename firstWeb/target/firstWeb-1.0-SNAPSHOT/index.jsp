<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>物流管理系统</title>
    <link href="css/index_Style.css" rel="stylesheet">
    <script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.8.0.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap-5.1.3-dist/css/bootstrap.min.css">
</head>
<body class="text-center bg-light">
<main class="form-signin">
    <form name="login" method="post" action="Login.act">
        <h1 class="h1 mb-3 fw-bold fs-2 fst-italic">物流管理系统
        <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" fill="currentColor" class="bi bi-truck" viewBox="0 0 16 16">
            <path d="M0 3.5A1.5 1.5 0 0 1 1.5 2h9A1.5 1.5 0 0 1 12 3.5V5h1.02a1.5 1.5 0 0 1 1.17.563l1.481 1.85a1.5 1.5 0 0 1 .329.938V10.5a1.5 1.5 0 0 1-1.5 1.5H14a2 2 0 1 1-4 0H5a2 2 0 1 1-3.998-.085A1.5 1.5 0 0 1 0 10.5v-7zm1.294 7.456A1.999 1.999 0 0 1 4.732 11h5.536a2.01 2.01 0 0 1 .732-.732V3.5a.5.5 0 0 0-.5-.5h-9a.5.5 0 0 0-.5.5v7a.5.5 0 0 0 .294.456zM12 10a2 2 0 0 1 1.732 1h.768a.5.5 0 0 0 .5-.5V8.35a.5.5 0 0 0-.11-.312l-1.48-1.85A.5.5 0 0 0 13.02 6H12v4zm-9 1a1 1 0 1 0 0 2 1 1 0 0 0 0-2zm9 0a1 1 0 1 0 0 2 1 1 0 0 0 0-2z"/>
        </svg></h1>
        <h3 class="h3 mb-3 fw-light fs-5">请登录</h3>
        <div class="form-floating">
            <input class="form-control" type="text" name="username" placeholder="用户名" maxlength="20" id="floatingInput" required>
            <label for="floatingInput">用户名</label>
        </div>
        <div class="form-floating">
            <input class="form-control" type="password" name="password" placeholder="密码" maxlength="20" id="floatingPassword" required>
            <label for="floatingPassword">密码</label>
        </div>
        <button class="w-100 t-1 btn btn-lg btn-default"><a href="app/signUp.jsp" style="text-decoration: none">注册</a></button>
        <button class="w-100 t-1 btn btn-lg btn-primary --bs--red" type="submit">开始</button>
    </form>
</main>
<script type="text/javascript" src="${pageContext.request.contextPath}/bootstrap-5.1.3-dist/js/bootstrap.min.js"></script>
</body>
</html>
<script>
    var err = '<%=request.getParameter("error")%>';
    if(err == 'yes') {
        alert("用户名或密码错误!");
    }
</script>