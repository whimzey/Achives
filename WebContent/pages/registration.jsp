<%@page import="dbService.executor.Executor"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dbService.DBService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <style> <%@ include file="/css/index.css"%>
     <%@ include file="/css/button.css"%></style>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script type="text/javascript" src="https://js.cx/script/jquery.documentReady.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-2.0.2.min.js"></script>

 <link  type="text/css" href="<c:url value="/css/index.css"/>" rel="stylesheet"/>
 <link type="text/css" href="<c:url value="/css/button.css" />" rel="stylesheet" />
<title>Регистрация</title>
</head>
<body>

<% 
DBService dbservice = new DBService();
ArrayList bossesNames = dbservice.getBosses();
 %>

<div id="registration" >
 <h3>Все поля обязательны к заполнению</h3>
         <table align="center" style="font-size: 12px"> <tr><td>  Имя:</td><td> <input type="text" id="name" size="20px"></td></tr> 
           <tr><td> Фамилия:</td><td> <input type="text" id="surname" size="20px"> </td></tr> 
          <tr><td>  Username: </td><td> <input type="text" id="username" size="20px"> </td></tr> 
          <tr><td>  Password:</td><td>  <input type="text" id="password" size="20px"> </td></tr> 
         <tr><td>  Руководитель: </td><td>
           <select id="bossid" >
           <option value="00">Я здесь Босс!</option>
           <%
        for (int i = 0; i < bossesNames.size(); i++) {
        	int x = i+1;
   out.println("<option  value=\""+x+"\">"+bossesNames.get(i)+"</option>"
		   );} %>
        </select></td></tr> </table><br>
        <input type="button" id="reg_button" value="Зарегистрироваться">

        
 
    </div>
    <script type="text/javascript">
$(document).on("click", "#reg_button", function() { 
	
	if($("#name").val()!=null&$("#surname").val()!=null&$("#username").val()!=null&$("#password").val()!=null){
	$.ajax({
        type: "POST",
        url: 'registration',
        data: {
            name: $("#name").val(),
            surname: $("#surname").val(),
            username: $("#username").val(),
            password: $("#password").val(),
            bossid: $("#bossid").val()
        },
        success: function(data)
        {
        	if(data.indexOf('Wrong login') == -1){

        	alert("Все на мази, ты в системе");
        	
        	if (data.indexOf('Bossprofile')!=-1) {
            	window.location.replace("/Achives/pages/bossprofile.jsp");
            }
        	 else if (data.indexOf('Userprofile')!=-1) {
        		
            	window.location.replace("/Achives/pages/profile.jsp");
            }
        	}
        	else{
        		alert("Такой логин уже есть в системе");
        		window.location.reload();
        	}
        }
    });}
	else {
		alert("Что-то пошло не так! Проверьте поля!");
	}
});</script>
</body>
</html>