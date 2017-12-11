
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebFilter("/*")
public class ErrorFilter implements Filter {

	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws ServletException, IOException {
		HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
		ArrayList <String> paths = new  ArrayList<String>();
		paths.add(request.getContextPath() + "/pages/logon");
		paths.add(request.getContextPath() + "/pages/logon");
		paths.add(request.getContextPath() + "/pages/registration.jsp");
		paths.add(request.getContextPath() + "/pages/achives.jsp");
		paths.add(request.getContextPath() + "/pages/bossprofile.jsp");
		paths.add(request.getContextPath() + "/pages/profile");
		paths.add(request.getContextPath() + "/pages/index.jsp");
		
		if(paths.contains(request.getRequestURI())){
        	chain.doFilter(request, response);
        	
		}
         
        	else {
        		chain.doFilter(request, response);
        		//response.sendRedirect("/Achives/pages/error404.jsp");
        }
		
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub
		
	}
	   
        
	

}
