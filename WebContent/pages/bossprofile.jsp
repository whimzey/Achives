<%@page import="dbService.dao.UsersDAO"%>
<%@page import="messages.MessageDAO"%>
<%@page import="dbService.dataSets.BossDataSet"%>
<%@page import="java.util.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dbService.dataSets.UsersDataSet"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link type="text/css" href="<c:url value="/css/button.css" />" rel="stylesheet" />
 <link  type="text/css" href="<c:url value="/css/back.css"/>" rel="stylesheet"/>
 <title>Мой профиль</title>
</head>
  <body>
 

<% Map<String,String> messageMap = (Map<String,String>)session.getAttribute("message");%>
<% BossDataSet bossProfile = (BossDataSet)session.getAttribute("profile");%>
<% ArrayList<String> achives = (ArrayList<String>) session.getAttribute("achives");%>
<%String name = bossProfile.getName();
long id = bossProfile.getId();%>


<div  id="achives" >

<div id = "header" >

<div style="float:left; margin-left:10px; width:70%; text-align:left; color: white;      margin: auto;">
<h3 >Фантастические ништяки, <br>и за что их дают <input type="hidden" name="hiddentag" value="Bossprofile" /></h3>
</div>

<div style="margin-right:5px; align:right; color: white;    margin: auto; ">

<input type="button" id = "button22" value="Выход" onclick='location.href="<c:url value="/pages/logout"/>"'>
</div>
 </div>
 
<p style="text-align:right; margin-right: 10px;" >Сейчас в системе: <%=name %></p><br>

<div id="achives1" style="margin-left:4%; border-right:1px dashed rgba(255, 193, 7, 1);">
<h3 style="text-align:center;">Задачи моих проектов</h3> 


<input type="button" id = "button22" name="add_achive" value="Добавить достижение"><br>
<%if(session.getAttribute("add_achive")!=null){
	out.print(session.getAttribute("add_achive_fail"));
}%>
<div id='add_achive_form' style="display:none;">

Заголовок: <input type="text" id="achive" ><br>
Количество баллов: <input type="text" id="price" ><br>
<%  
out.println("<input type=\"hidden\" id=\"bossid\" value=\""+String.valueOf(id)+"\" />");
	 %>
<button id = "button22" name="add_achive_to_DB">Подтвердить</button> 
<input id = "button22" type="button" name="add_cancel" value="Отменить"><br>

</div>


<% ArrayList<String> list = achives; %>
<%  for (int i = 0; i < list.size(); i++) {
	out.println(list.get(i));
	out.println("<br><br>");
	}
	 %>
	<script src="http://code.jquery.com/jquery-2.0.2.min.js"></script>
	</div>



<div id="achives1" style="margin-left:3%;">
<h3 style="text-align:center;">Достижения на согласовании</h3> 



<% if(messageMap!=null){ 
	for (Map.Entry<String, String> entry : messageMap.entrySet())

{
    String[]x = entry.getValue().split(",");
	
	out.println("<form action=\"AchiveApproval\" method=\"POST\">"+ x[0]+" просит подтвердить выполнение достижения " + "\""+ x[1]+
			"\"" + "<br><input type=\"submit\" name=\"approve\" id = \"button22\" value=\"Подтвердить\"\">"+
					"<input type=\"hidden\" name=\"employeeName\" value=\""+x[0]+"\" />"+
							"<input type=\"hidden\" name=\"achive\" value=\""+x[1]+"\" />"+
									"<input type=\"hidden\" name=\"id\" value=\""+String.valueOf(id)+"\" />"+
											"<input type=\"hidden\" name=\"idmessage\" value=\""+String.valueOf(entry.getKey())+"\" />"+
													"<input type=\"hidden\" name=\"name\" value=\""+bossProfile.getUsername()+"\" />"+
			"<input type=\"submit\" name=\"approve\" id = \"button22\" value=\"Отказать\">"+
	        "</form>");
	out.println("<br>");
	}}
else {
	out.println("Сейчас ничего нет, но скоро обязательно что-нибудь появится!");
}%>
	</div>
	</div>
<script type="text/javascript">
	
	$(document).ready(function(){
		$('input[name="add_achive"]').click(function(){
		$('#add_achive_form').fadeIn('slow');
		});
		$('input[name="add_cancel"]').click(function(){
		$('#add_achive_form').fadeOut('slow');
		});
		});
	
	$(document).on("click", 'button[name="add_achive_to_DB"]', function() { 
		if($("#achive").val()!=null&$("#price").val()!=null){
			$.ajax({
		
	        type: "POST",
	        url: 'add_achive_to_DB',
	        data: {
	            a_achive: $("#achive").val(),
	            a_price: $("#price").val(),
	            a_bossid: $("#bossid").val(),
	        },
	        success: function(data)
	        {
	        	location.href = "/Achives/pages/bossprofile.jsp";
  }
	    });}
		else{
			 alert("Не все обязательные поля заполнены!");
		}
		});
</script>
</body>
</html>
