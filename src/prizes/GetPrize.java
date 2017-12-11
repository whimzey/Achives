package prizes;


import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dbService.DBException;
import dbService.DBService;
import dbService.dataSets.UsersDataSet;

@WebServlet("/pages/getprize")
public class GetPrize extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//��������� ���� �� ���������� �����
		HttpSession session = request.getSession();
		UsersDataSet profile = (UsersDataSet)session.getAttribute("profile");
		String prize = request.getParameter("prizename");
		String price = request.getParameter("price");
		String score = request.getParameter("score");
		
		
		//�������� ����� � �����
		if(Integer.parseInt(score)>=Integer.parseInt(price)){
		try {
		DBService dbService = new DBService();
		long id = profile.getId();
		dbService.minusScore(price, id);
		profile = dbService.getUser(id);
		} catch (DBException e) {
			e.printStackTrace();
		}
		
		//�������� ���� �� ����� ����������
		//Sender sender = new Sender("Sofia.Kareva@aplana.com", "rdfpb,hfrwbz");
		//sender.send("������ �������", profile.getName()+" ����� ��������"+ prize, "Sofia.Kareva@aplana.com", "sk.jobstuff@gmail.com");
		
		//������������� ��������
		session.removeAttribute("profile");
		session.setAttribute("profile", profile);
		session.setAttribute("success", "OK");
		response.sendRedirect("/Achives/pages/achives.jsp");}
		else{
			session.removeAttribute("profile");
			session.setAttribute("profile", profile);
			
			response.sendRedirect("/Achives/pages/achives.jsp");}
		
		
	}

}
