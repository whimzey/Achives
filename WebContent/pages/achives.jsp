<!DOCTYPE html>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page contentType="text/html; charset=utf-8" language="java" import="javax.xml.parsers.DocumentBuilderFactory,javax.xml.parsers.DocumentBuilder,org.w3c.dom.*" errorPage="" %>
<%@page import="org.w3c.dom.Node, org.w3c.dom.Element, org.w3c.dom.Document, org.w3c.dom.NodeList, javax.xml.parsers.DocumentBuilder, javax.xml.parsers.DocumentBuilderFactory" %>
<%@page import="dbService.dataSets.UsersDataSet"%>
<%@page import="prizes.PrizesBuilder"%>
<%@page import="java.util.*"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>

  <head>
  <meta http-equiv="Pragma" content="no-cache"> 
 <meta http-equiv="Cache-Control"      content="no-cache"> 
<meta http-equiv="Expires" content="0">
<link type="text/css" href="<c:url value="/css/button.css" />" rel="stylesheet" />
 <link  type="text/css" href="<c:url value="/css/back.css"/>" rel="stylesheet"/>
 <title>Ништяки Апланы</title></head>
  <body>  
 
<%UsersDataSet profile = (UsersDataSet)session.getAttribute("profile");%>
<%ArrayList<PrizesBuilder> list = (ArrayList)session.getAttribute("prizes");
 String success = (String)session.getAttribute("success"); %>
 <div  id="achives" >

<div id = "header" >
<div style="float:left; margin-left:10px; width:70%; text-align:left; color: white; margin: auto;">
<h3 >Фантастические ништяки, <br>и за что их дают <input type="hidden" name="hiddentag" value="Userprofile" /></h3>
</div>
<div style="margin-right:5px; align:right; color: white;    margin: auto; ">
<input type="button" id = "button22" value="Выйти" onclick='location.href="<c:url value="/pages/logout"/>"'> 
</div>

</div>

 
<p style="text-align:right; margin-right: 10px;" ><%out.println("Количество баллов: "+ profile.getScore());%></p>
  <h4 style="text-align:left; margin-left: 5%;" >Для отправки сообщения в службу HR жмякни по кнопке "Беру" </h4>
  <div style="display: flex;
    align-items: flex-start;
    justify-content: center;
    flex-wrap: wrap; ">
  

  <%
  for (int i = 0; i < list.size(); i++){
	  PrizesBuilder prizes = list.get(i);
  %>
  <div id="prizes"   >
  <div style=" width:100%; min-height: 50px;"><h4 style="text-align:center; "><%= prizes.getName() %></h4></div>
 
  <div style=" display:block; "> <%out.print("<img src=\"/Achives/images/"+prizes.getImage()+"\" width=\"100\" height=\"100\"  />");%>
  </div>
  <div style=" display:block; margin-bottom:10px; font-size: 11px;"><%= prizes.getDescription() %>
  </div>
  <div style="display:block; align-self: flex-end;">
  <%if(profile.getScore()>0&profile.getScore()>=Integer.parseInt(prizes.getPrice())){
	   out.println("<form action=\"getprize\" method=\"POST\">"+
				"<input type=\"submit\" id=\"button22\" value=\"Беру за "+prizes.getPrice()+
				"\"><input type=\"hidden\" name=\"prize\" value=\""+prizes.getName()+
				"\" /><input type=\"hidden\" name=\"price\" value=\""+prizes.getPrice()+
				"\" /><input type=\"hidden\" name=\"score\" value=\""+profile.getScore()+
				"\" /></form>");
  }
  else{
	  out.println("<button id=\"button22\">Беру за "+prizes.getPrice()+"</button>");
  }
	  %>
  </div></div>
   <%} %>
  

  </div>
  </div>
  <%if (success!=null){
    	
	out.println("<div class=\"b-popup\" id=\"popup1\">"+
						"<div class=\"b-popup-content\">"+"Уведомление в службу HR отправлено!"+
								"<br><br><input type=\"submit\" id=\"button22\" onclick=\"javascript:PopUpReload()\" value=\"ОК\">"+
						"</div></div>");
	session.removeAttribute("success");
}%>
<script>
$(document).ready(function(){
    //Скрыть PopUp при загрузке страницы    
    PopUpHide();
});
//Функция отображения PopUp
function PopUpShow(){
    $("#popup1").show();
}
//Функция скрытия PopUp
function PopUpHide(){
    $("#popup1").hide();}
    
function PopUpReload(){
    
    location.reload();}
 
</script>
  </body>
</html>