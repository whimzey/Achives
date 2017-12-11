<%@page import="dbService.dao.UsersDAO"%>
<%@page import="java.util.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dbService.dataSets.UsersDataSet"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
   
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script type="text/javascript" src="https://js.cx/script/jquery.documentReady.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-2.0.2.min.js"></script>
<script src="<c:url value="/js/js_active.js"/>" type="text/javascript"></script>
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
<meta http-equiv="Pragma" content="no-cache"> 
 <meta http-equiv="Cache-Control"      content="no-cache"> 
<meta http-equiv="Expires" content="0">
<link type="text/css" href="<c:url value="/css/button.css" />" rel="stylesheet" />
 <link  type="text/css" href="<c:url value="/css/back.css"/>" rel="stylesheet"/>
<title>Мой профиль</title>
</head>
  <body>
  <%UsersDataSet profile = (UsersDataSet)session.getAttribute("profile");
 ArrayList<String> answerfromboss = (ArrayList<String>)session.getAttribute("answerfromboss");
 String success = (String)session.getAttribute("success"); %>
    
<div  id="achives" >

<div id = "header" >
<div style="float:left; margin-left:10px; width:40%; text-align:left; color: white; margin: auto;">
<h3 >Фантастические ништяки, <br>и за что их дают <input type="hidden" name="hiddentag" value="Userprofile" /></h3>
</div>


<div style="margin-right:5px; align:right;    margin: auto; ">
<%if(answerfromboss.size()!=0){
	out.println("<div > <input type=\"button\" id=\"button22\" onclick=\"javascript:PopUpShow()\" value=\"Ответы на заявки\"></div>");
}%>
 
<div class="b-popup" id="popup1">
    <div class="b-popup-content" >
        <% if(answerfromboss.size()!=0){
        for (int i = 0; i < answerfromboss.size(); i++) {
        	out.print("<p style=\"font-color:black;\">");   	
        	out.println(answerfromboss.get(i));
        	out.print("</p>");
        	out.println("<hr>");
        }
   out.println("<br><form action=\"deleteanswerfromboss\" method=\"POST\">"+ 
    "<input type=\"submit\" onclick=\"javascript:PopUpHide()\" id=\"button22\" value=\"ОК\">"+
    "<input type=\"hidden\" name=\"id\" value=\""+profile.getId()+"\" /></form>");}%>
    </div>
</div>

</div>
<div style="margin-right:5px; align:right; color: white;    margin: auto; ">
	<%out.println("<form action=\"ChoosePrize\" method=\"POST\">"+
	"<input type=\"submit\" id=\"button22\" value=\"Потратить баллы ("+ profile.getScore()+")\"></form>");%>
	    

    
</div>
<div style="margin-right:5px; align:right; color: white;    margin: auto; ">
<input type="button" id = "button22" value="Выйти" onclick='location.href="<c:url value="/pages/logout"/>"'> 
</div>

</div>

 
<p style="text-align:right; margin-right: 10px;" >
Сейчас в системе: <span ><%=profile.getName() %></span><br>
Руководитель: <%=profile.getBossName() %></p>



<div id = "achives1" style="margin-left:4%; ">
<h3 style="text-align:center;">Доступные достижения</h3> <br>
<% ArrayList<String> list = profile.getAvaliableachevesArray(); %>


<%  for (int i = 0; i < list.size(); i++) {
	
	out.println("<form action=\"lettertoboss\" method=\"POST\">"+ list.get(i)+" "+
	        "<input type=\"submit\"  id=\"button22\" value=\"Выполнено!\">"+
	        		"<input type=\"hidden\" name=\"name\" value=\""+profile.getName()+"\" />"+
	        				"<input type=\"hidden\" name=\"achive\" value=\""+list.get(i)+"\" />"+
	        "</form>");
	out.println("<br>");
	} %>
	
</div>
	
<div id="achives1" style="border-left:1px dashed rgba(255, 193, 7, 1); padding-left: 4%;">
<h3 style="text-align:center;">Выполненные задачи</h3> <br>
<% ArrayList<String> donelist = profile.getReachedachivesArray(); %>
<%  for (int i = 0; i < donelist.size(); i++) {
	out.println(donelist.get(i));
	out.println("<br><br>");
	}
	 %></div>
	 </div>
	 
	<%if (success!=null){
    	
	out.println("<div class=\"b-popup\" id=\"popup1\">"+
						"<div class=\"b-popup-content\">"+"Уведомление руководителю отправлено"+
								"<br><br><input type=\"submit\" id=\"button22\" onclick=\"javascript:PopUpReload()\" value=\"ОК\">"+
						"</div></div>");
	session.removeAttribute("success");
}%>

<script type="text/javascript">
$(document).on("click", "#logout_button", function() { 
	$.ajax({
		  url: 'pages/Logout',
		  data: session,
		  success: window.location.replace("/Achives/pages/index.jsp"),
    });
});</script>
</body>
</html>
