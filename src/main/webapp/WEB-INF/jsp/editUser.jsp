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
            <li><a href="#">服务区</a></li>
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
    <h3>编辑个人信息</h3>
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
    <span class="name-icon">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
    姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名：<input type="text" name="name" value="${user.getName()}" id="userName">
</p>
<p>
    <span class="name-icon">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
    姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别：<input type="text" name="sex" value="${user.getSex()}" id="userSex">

</select>
</p>
<p>
    <span class="name-icon">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
    电&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;话：<input type="text" name="tel" value="${user.getTel()}" id="userTel">
</p>
<p>
    <span class="name-icon">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
    地&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;址：<input type="text" name="address" value="${user.getAddress()}" id="userAddress">
</p>
<p>
    <span class="press-icon">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
    专&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;业：<input type="text" name="major" value="${user.getMajor()}" id="userMajor">
</p>

<input type="button" class="submit-btn" id="user-submit" value="提交">
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

window.onload = function () {
var id = $("#userId").val();
var id_ = {"id":id};
var jsonData = JSON.stringify(id_);
$.ajax({
    type:"POST",
    url:"/books/categories",
    async:false,
    dataType:"json",
    contentType:"application/json;charset=UTF-8",
    data:jsonData,
    success:function (result) {
        var opts = document.getElementById("category");
        var categoryId = result.data.categoryId;
        console.log(categoryId);
        if (categoryId != ""){
            for(var i = 0;i<opts.options.length;i++){
                if(categoryId == opts.options[i].value){
                    opts.options[i].selected = "selected";
                    break;
                }
            }
        }
    }
});
};

$("#user-submit").click(function (event){
$("#bookForm").ajaxSubmit({
    type:"POST",
    url:"/users/updateUser",
    async:false,
    dataType:"json",
    success:function(result){
        if (result.resultCode == 200){
            alert("修改成功");
            location.href = "/myBookshelf.do";
        }else {
            alert(result.message);
        }
    }
});
});

$(function(){
$("#book-file").change(function(){
    var filePath = $(this).val().split("\\");
    var len = filePath.length;
    var file = filePath[len-1];
    if (!file) {
        filePath = "img/loadPic.png"
    }
    filePath = "img/"+file;
    // console.log(filePath);
    $("#book-pic").attr("src",filePath);

})
});
</script>
</body>
</html>
