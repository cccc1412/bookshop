<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="java.util.*" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>校园二手书交易平台</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/reset.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/login.css">
</head>
<body>
<div id="login-container">
    <h2>请注册</h2>
    <br />
    <form>
        <input type="text" id="studentid" class="userName" placeholder="学号"><br/>
        <input type="password" id="password" class="password" placeholder="密码"><br/>
        <input type="password" id="password2" class="password" placeholder="请确认密码"><br/>
        <button class="loginBtn" id="register-button" type="submit">注册</button>
    </form>
    <p id="errorInfo"></p>
</div>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-3.2.js"></script>

<script type="text/javascript">
    $(function() {
        $('#register-button').click(function (event) {
            $('#errorInfo').html("");
            var studentid_ = $('#studentid').val();
            var password_ = $('#password').val();
            if (studentid_.length == 0 || password_.length == 0) {
                $('#errorInfo').html("学号或密码不能为空！");
                return false;
            }
            var pwd1 = document.getElementById("password").value;
            var pwd2 = document.getElementById("password2").value;
            if(pwd1!=pwd2){
                alert("两次输入的密码不一致！");
                return false;
            }

            var user_ = {"studentid": studentid_, "password": password_};
            var jsonData = JSON.stringify(user_);
            $.ajax({
                type: "POST",
                url: "/users/register",
                async: false,
                dataType: "json",
                contentType: "application/json;charset=UTF-8",
                data: jsonData,
                success: function (result) {
                    if (result.resultCode == 200) {
                        event.preventDefault();
                        location.href = "/home.do";
                    } else {
                        event.preventDefault();
                        $('#errorInfo').html(result.message);
                    }
                }
            });
        })
    })
</script>
</body>
</html>
