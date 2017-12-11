

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dbService.DBException;
import dbService.DBService;
import dbService.dataSets.BossDataSet;
import dbService.dataSets.UsersDataSet;


@WebServlet("/pages/logon")
public class Hello extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
    public Hello() {
        super();
        
    }
  
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	request.getRequestDispatcher("/pages/index.jsp").forward(request, response);
    }
    public void doPost(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
    	
    	String login;
    	String pass;
    	String isaboss;
    	
    		 login = request.getParameter("username");
    		 isaboss = request.getParameter("isaboss");
    		 pass = request.getParameter("password");
    	
    		 PrintWriter out = response.getWriter();
    		 response.setContentType("text/html;charset=utf-8");
    		
    		 if(login.length()>0&&pass.length()>0){
    

response.setStatus(HttpServletResponse.SC_OK);


DBService dbService = new DBService();

//если отмечен чекбокс, загружаем босса
if(isaboss!=null){
	
	BossDataSet set = null;
	Map<String,String> message = null;
	ArrayList<String> achives = null;
	
	
	try {
		set = dbService.getBossProfile(login, pass);
		
	} catch (DBException e) {	
		e.printStackTrace();
	}
		if(set!=null){
			try {
				message = dbService.getAchivesonApproval(set.getId());
		achives = dbService.getAchivesList(set.getId());
		
	} catch (DBException e) {	
		e.printStackTrace();
	}
	HttpSession session = request.getSession(); 
	session.setAttribute("profile", set);
	session.setAttribute("message", message);
	session.setAttribute("achives", achives);
	session.setAttribute("password", pass);
	
	request.getRequestDispatcher("/pages/bossprofile.jsp").forward(request, response);
	}
		else{
		out.print(
		       
		                  "Что-то пошло не так при загрузке босса" 
		              
		          );   
	}}
	
//не отмечен чекбокс, загружаем юзера
else {
	
	UsersDataSet dataSet = null;
	ArrayList<String> answerfromboss = null;
	try {
		
		dataSet = dbService.getUser(login,pass);
		
	} catch (DBException e) {
		
		e.printStackTrace();
	}
	//при загрузке юзера проверяем, не пустой ли датасет
if(dataSet!=null){
	try {
		answerfromboss = dbService.getAnswerfromBoss(dataSet.getId());
	} catch (DBException e) {
		
		e.printStackTrace();
	}
HttpSession session = request.getSession(); 
session.setAttribute("profile", dataSet);
session.setAttribute("password", pass);
session.setAttribute("answerfromboss", answerfromboss);
	request.getRequestDispatcher("/pages/profile.jsp").forward(request, response);
	
}
//если пустой датасет юзера, выдаем текст на экран
else {
	out.print(
	        "<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" +" +
	                "http://www.w3.org/TR/html4/loose.dtd\">\n" +
	            "<html> \n" +
	              "<head> \n" +
	                "<meta http-equiv=\"Content-Type\" content=\"text/html; " +
	                  "charset=ISO-8859-1\"> \n" +
	                "<title> Упс!  </title> \n" +
	              "</head> \n" +
	              "<body> <div align='center'> \n" +
	                "<style= \"font-size=\"12px\" color='black'\"" + "\">" +
	                  "Empty dataset" +
	              "</font></body> \n" +
	            "</html>" 
	          );   
}
}//здесь заканчивается проверка и загрузка юзера
    		 }//заканчивается проверка на пустоту пароля и логина
    		 else{
    			 out.print(
    			        "<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" +" +
    			                "http://www.w3.org/TR/html4/loose.dtd\">\n" +
    			            "<html> \n" +
    			              "<head> \n" +
    			                "<meta http-equiv=\"Content-Type\" content=\"text/html; " +
    			                  "charset=ISO-8859-1\"> \n" +
    			                "<title> Упс!  </title> \n" +
    			              "</head> \n" +
    			              "<body> <div align='center'> \n" +
    			                "<style= \"font-size=\"12px\" color='black'\"" + "\">" +
    			                  "Не введен логин или пароль" +
    			              "</font></body> \n" +
    			            "</html>" 
    			          );   }
    		 }// здесь заканчивается dopost
      }

 
