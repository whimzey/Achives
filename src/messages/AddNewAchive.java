package messages;

import java.io.IOException;
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


@WebServlet("/pages/add_achive_to_DB")
public class AddNewAchive extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AddNewAchive() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
	String	achive = request.getParameter("a_achive");
	String	price = request.getParameter("a_price");
	String	bossid = request.getParameter("a_bossid");
	
	
	DBService dbService = new DBService();
	ArrayList<String> achives = null;
	HttpSession session = request.getSession();
			 try {
				dbService.addNewAchive(achive, price, bossid);
				achives = dbService.getAchivesList(Integer.parseInt(bossid));
				session.setAttribute("achives", achives);
			 } catch (DBException e) {
				 session.setAttribute("add_achive_fail", "Достижение не добавлено, попробуйте снова");
					e.printStackTrace();
				}
			 request.getRequestDispatcher("/pages/bossprofile.jsp").forward(request, response);
		
	}
	

}
