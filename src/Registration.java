

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
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


@WebServlet("/pages/registration")
public class Registration extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String	login =	request.getParameter("username");
	String	name = request.getParameter("name") +" "+ request.getParameter("surname");
	String	pass = request.getParameter("password");
	String	boss = request.getParameter("bossid");
	
	
	DBService dbService = new DBService();
	
	try {
		
		if(dbService.checkUser(login)){
			
			try {
			
		if(boss.equals("00")){
			 dbService.addBoss(login, pass, name);
			 BossDataSet set = dbService.getBossProfile(login,pass);
			Map<String,String>  message = dbService.getAchivesonApproval(set.getId());
			ArrayList<String>  achives = dbService.getAchivesList(set.getId());
			
				HttpSession session = request.getSession();
				session.setAttribute("profile", set);
				session.setAttribute("message", message);
				session.setAttribute("achives", achives);
			response.sendRedirect("/Achives/pages/bossprofile.jsp");
			
		}
		else{
			
				dbService.addUser(login, pass, name, boss);
				UsersDataSet set = dbService.getUser(login,pass);
				
				
				ArrayList<String> answerfromboss = dbService.getAnswerfromBoss(set.getId());
				
				
			if(set!=null){
				
				HttpSession session = request.getSession();
				session.setAttribute("profile", set);
				session.setAttribute("answerfromboss", answerfromboss);
				response.sendRedirect("/Achives/pages/profile.jsp");
				
			}}
		} catch (DBException e) {
			
			e.printStackTrace();
		}
		}
		else{
			 PrintWriter out = response.getWriter();
    		 response.setContentType("text/html;charset=utf-8");
    		 out.print(
				       
    				 "Wrong login"
	              
	          );   
		}
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}}
	
}