package web;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.UserDAO;
import entity.User;

public class ActionServlet extends HttpServlet {

	public void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String uri = request.getRequestURI();
		String action = 
			uri.substring(uri.lastIndexOf("/"),
					uri.lastIndexOf("."));
		if(action.equals("/login")){
			/*
			 * 先比较验证码是否正确(
			 * 用户提交的验证码和事先绑订到session对象
			 * 上的验证码),如果不正确，转发到登录页面；
			 * 否则，比较用户名和密码。
			 */
			String number1 = 
				request.getParameter("number");
			HttpSession session = 
				request.getSession();
			String number2 =
				(String)session.getAttribute("number");
			if(!number1.equalsIgnoreCase(number2)){
				//验证码不正确
				request.setAttribute("number_error",
						"验证码错误");
				request.getRequestDispatcher("login.jsp")
				.forward(request, response);
				return;
			}
			String username = 
				request.getParameter("username");
			String pwd = 
				request.getParameter("pwd");
			//查询数据库，看有没有匹配的记录
			//如果有，则登录成功；否则，登录失败。
			UserDAO dao = new UserDAO();
			try {
				User user = dao
				.findByUsername(username);
				if(user != null && 
						user.getPwd().equals(pwd)){
					//登录成功之后，绑订一些数据到
					//session对象上，用于session验证。
					session.setAttribute("user", user);
					//跳转到主功能页面
					response.sendRedirect("main.jsp");
				}else{
					//登录失败，要提示用户
					request
					.setAttribute("login_error",
							"用户名或者密码错误");
					request.getRequestDispatcher("login.jsp")
					.forward(request, response);
				}
			} catch (Exception e) {
				e.printStackTrace();
				//转发到异常处理页面。
			}
		}else if(action.equals("/regist")){
			
		}
		
	}

}
