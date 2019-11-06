<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="java.util.*" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>编辑个人信息</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/reset.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/upload.css">
</head>
<body>

<!-- 导航条 -->
<nav class="navbar">
    <div class="nav-menu">
        <ul class="menu">
            <li><a class="active" href="/home.do">首页</a></li>
            <li><a href="/goBookStore.do">书籍良品</a></li>
            <li><a href="/goAskBookStore.do">求书区</a></li>
        </ul>
    </div><!-- nav-menu -->

    <form class="nav-search">
        <input type="search" class="searchIn" name="name" placeholder="搜图书...">
        <button class="search-logo"><img src="<%=request.getContextPath()%>/img/search2.png"></button>
    </form>

    <div class="nav-info">
        <a href="#" class="username">${user.getName()}</a>
        <a href="/myBookshelf.do" class="bookshelf">||&nbsp;&nbsp;&nbsp;我的书架</a>
        <a href="#" class="logout">[ 退 出 ]</a>
    </div> <!-- nav-info-end -->
</nav>

<div class="titleName">
    <h3>修改密码</h3>
</div>

<div class="container">
    <form enctype="multipart/form-data" id="bookForm">
        <input type="hidden" name="id" value="${user.getId()}" id="userId">
        <%--<p>
            <span class="pic-icon">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
            修改书图片： <input type="file" id="book-file" name="image">
            <img id="book-pic" src="<%=request.getContextPath()%>/img/book-list/article/${book.getBookImage().getId()}.jpg">
        </p>--%>


        <p>
            <span class="author-icon">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
            原&nbsp;密&nbsp;码&nbsp;：<input type="password" name="oldPassword" id="oldPassword" autocomplete="off" disableautocomplete>
        </p>
        <p>
            <span class="author-icon">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
            新&nbsp;密&nbsp;码&nbsp;：<input type="password" name="password" autocomplete="off" id="newPassword1">
        </p>
        <p>
            <span class="author-icon">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
            新&nbsp;密&nbsp;码&nbsp;：<input type="password" name="password2" autocomplete="off" id="newPassword2">
        </p>


        <input type="button" class="submit-btn" id="password-submit" value="提交">
    </form>
</div>
<footer>
    <a href="#">©2018-2019 二手书交易</a>
    <a href="#">意见反馈&nbsp;&nbsp;&nbsp;联系我们&nbsp;&nbsp;&nbsp;隐私权声明&nbsp;&nbsp;&nbsp;使用条款</a>
</footer>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-3.2.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.form.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/session.js"></script>
<script type="text/javascript">
    $("#password-submit").click(function (event){
        var cinOldPwd = document.getElementById("oldPassword").value;
        var pwd1 = document.getElementById("newPassword1").value;
        var pwd2 = document.getElementById("newPassword2").value;
        if(pwd1!=pwd2){
            alert("两次输入的密码不一致！");
            return false;
        }
        var oldPwd = "${user.getPassword()}";
        if(oldPwd!=cinOldPwd){
            alert("原密码错误！");
            return false;
        }
        $("#bookForm").ajaxSubmit({
            type:"POST",
            url:"/users/changePassword",
            async:false,
            dataType:"json",
            success:function(result){
                if (result.resultCode == 200){
                    alert("密码修改成功");
                    location.href = "/myBookshelf.do";
                }else {
                    alert(result.message);
                }
            }
        });
    });
</script>
</body>
</html>
