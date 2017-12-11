package prizes;


import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.*;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import dbService.dataSets.UsersDataSet;


@WebServlet("/pages/ChoosePrize")
public class ChoosePrize extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 HttpSession session = request.getSession();
		UsersDataSet profile = (UsersDataSet)session.getAttribute("profile");
		Document doc = null;
		ClassLoader loader = this.getClass().getClassLoader();
		InputStream ifile = loader.getResourceAsStream("prizes/prizes.xml");
		try{
			
        DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
        DocumentBuilder db = dbf.newDocumentBuilder();
         doc = db.parse(ifile);

		} catch (ParserConfigurationException e) {
			System.out.print("Не удалось распарсить документ");
			e.printStackTrace();
		} catch (SAXException e) {
			System.out.print("Что-то с SAX");
			e.printStackTrace();
		}
		  ArrayList<PrizesBuilder> list = new ArrayList();
		
		  NodeList prizesNodes = doc.getElementsByTagName("prize");
		  for (int i = 0; i < prizesNodes.getLength(); i++) {
              // Выводим информацию по каждому из найденных элементов
              Node node = prizesNodes.item(i);
              
                  Element element = (Element) node;
                 PrizesBuilder prizesbuilder = new PrizesBuilder(element
                         .getElementsByTagName("name").item(0)
                         .getTextContent(),element
                         .getElementsByTagName("image").item(0)
                         .getTextContent(),element
                         .getElementsByTagName("price").item(0)
                         .getTextContent(),element
                         .getElementsByTagName("description").item(0)
                         .getTextContent());
                  list.add(prizesbuilder);
              }
          
	
		  session.setAttribute("prizes", list);   
		response.sendRedirect("/Achives/pages/achives.jsp");
	}

}
