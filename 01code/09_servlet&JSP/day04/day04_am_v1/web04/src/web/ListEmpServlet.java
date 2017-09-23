package web;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ListEmpServlet extends HttpServlet{
	public void service(HttpServletRequest request,
			HttpServletResponse response)
	throws ServletException,IOException{
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		Connection conn = null;
		PreparedStatement stat = null;
		ResultSet rst = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager
			.getConnection("jdbc:mysql://localhost:3306/jsd1402db",
					"root","1234");
			stat = conn.prepareStatement(
					"select * from t_emp");
			rst = stat.executeQuery();
			out.println("<table border='1' width='60%' " +
					"cellpadding='0' cellspacing='0'>");
			out.println("<tr><td>ID</td><td>����</td>" +
					"<td>нˮ</td><td>����</td><td>����</td></tr>");
			while(rst.next()){
				int id = rst.getInt("id");
				String name = rst.getString("name");
				double salary = rst.getDouble("salary");
				int age = rst.getInt("age");
				out.println("<tr><td>" + id + "</td><td>" 
						+ name + "</td><td>" 
						+ salary + "</td><td>" 
						+ age + "</td><td>" +
								"<a href='del?id=" + id 
								+ "'>ɾ��</a>&nbsp;<a href='load?id=" + id + "'>�޸�</a></td></tr>");
			}
			out.println("</table>");
			out.println("<a href='addEmp.html'>����Ա��</a>");
		}catch(Exception e){
			e.printStackTrace();
			out.println("ϵͳ��æ���Ժ�����");
		}finally{
			if(conn != null){
				try {
					conn.close();
				} catch (SQLException e) {
				}
			}
		}
		//������ִ����service����֮�󣬻����
		//out��close���������ԣ���дout.closeҲ��
		//���Եġ�
		out.close();
		
	}
}