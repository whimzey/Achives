<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <style>
     <%@ include file="/css/index.css"%>
     <%@ include file="/css/button.css"%>
</style>
<!DOCTYPE html>
<html>
<head>
 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script type="text/javascript" src="https://js.cx/script/jquery.documentReady.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-2.0.2.min.js"></script>

<link type="text/css" href="<c:url value="/css/button.css" />" rel="stylesheet" />
 <link  type="text/css" href="<c:url value="/css/index.css"/>" rel="stylesheet"/>
<title>Ништяки Апланы</title>
</head>

<body>

    <div id="autorization" >
 <h3>Добро пожаловать в обитель ништяков!</h3>
        
            <input type="text" id="username" placeholder="Введите username" size="20px"> <br><br>
            <input type="text" id="password" placeholder="Введите пароль" size="20px"> <br><br>
            Жмяк, если супербосс <input type="checkbox" class="messageCheckbox" id="isaboss" value="logon" /><br><br>
        <button id="login_button">Войти</button> 
        <input type="button" id="button22" name="register" value="Зарегистрироваться" onclick='location.href="<c:url value="/pages/registration.jsp"/>"'>
    </div>
<script type="text/javascript">
$(document).on("click", "#login_button", function() { 
	$.ajax({
        type: "POST",
        url: 'logon',
        data: {
            username: $("#username").val(),
            password: $("#password").val(),
            isaboss: $('.messageCheckbox:checked').val()
        },
        success: function(data)
        {
        	 if (data.indexOf('Bossprofile')!=-1) {
            	window.location.replace("/Achives/pages/bossprofile.jsp");
            }
        	 else if (data.indexOf('Userprofile')!=-1) {
        		
            	window.location.replace("/Achives/pages/profile.jsp");
            }
            else {
            	 
            	 alert("Что-то пошло не так! Проверьте имя\пароль или зарегистрируйтесь!");
            	 alert(data);
               
            }
        }
    });
});</script>

</body>
</html>