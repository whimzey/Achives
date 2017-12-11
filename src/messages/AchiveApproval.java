package messages;

import java.io.IOException;
import java.sql.SQLException;
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


@WebServlet("/pages/AchiveApproval")
public class AchiveApproval extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public AchiveApproval() {
        super();
       
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		String approval = request.getParameter("approve");
		String name = request.getParameter("employeeName");
		String achive = request.getParameter("achive");
		String idmessage = request.getParameter("idmessage");
		String bossname = request.getParameter("name");
		String pass = (String) session.getAttribute("password");
		
		String id = (String) request.getParameter("id");
		
		DBService dbService = new DBService();
		long idUser =0;
		try {
			idUser = dbService.getUserbyName(name).getId();
		} catch (DBException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		try {
		switch(approval){
		case "Подтвердить": 
				dbService.addAnswer(idUser, id+","+achive+",Подтверждено");
				dbService.addscore(idUser,achive);
				dbService.deleteUserRequest(idmessage);
				dbService.addRecievedAchives(idUser,achive);
				break;
			
		case "Отказать":dbService.addAnswer(idUser, id+","+achive+",Отказано");
		dbService.deleteUserRequest(idmessage);
		break;
	
		}
		} catch (NumberFormatException e) {
			
			e.printStackTrace();
		} catch (DBException e) {
			
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
		
		response.setContentType("text/html;charset=utf-8");
		
		
		BossDataSet set = null;
		Map<String,String> message = null;
		try {
			set = dbService.getBossProfile(bossname,pass);
			message = dbService.getAchivesonApproval(set.getId());
		} catch (DBException e) {
			
			e.printStackTrace();
		}
		session.removeAttribute("message");
		session.setAttribute("message", message);
		session.removeAttribute("profile");
		session.setAttribute("profile", set);
		response.setHeader("Refresh", "0; URL=/Achives/pages/bossprofile.jsp");
		
	}

}
