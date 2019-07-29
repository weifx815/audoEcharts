package com;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Index4Servlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public Index4Servlet() {
		super();
	}

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	/**
	 * The doGet method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		 response.setContentType("text/html; charset=utf-8");
		 PrintWriter out=response.getWriter();
		 String ySeriesData = "12, 22, 20, 34, 39, 30, 20,12,34,26";
		 String xAxisDate = "福田区,宝安区,南山区,光明区,龙华区,龙岗区,罗湖区,坪山区,盐田区,大鹏区";
		 String[] aa = ySeriesData.split(",");
		 Random rand = new Random();
		 int randomNum = rand.nextInt(aa.length);
		 String num1 = aa[randomNum].trim();
		 int num = Integer.parseInt(num1);
		 int setNum = num+50;
		 aa[randomNum] = setNum+"";
		 StringBuffer sbb = new StringBuffer();
		 for (int i = 0; i < aa.length; i++) {
			sbb.append(aa[i]).append(",");
		}
		 String data = sbb.toString()+"||"+xAxisDate;
		 out.println(data);
		 out.flush();
		 out.close();
	}

	/**
	 * The doPost method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to post.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
		out.println("<HTML>");
		out.println("  <HEAD><TITLE>A Servlet</TITLE></HEAD>");
		out.println("  <BODY>");
		out.print("    This is ");
		out.print(this.getClass());
		out.println(", using the POST method");
		out.println("  </BODY>");
		out.println("</HTML>");
		out.flush();
		out.close();
	}

	/**
	 * Initialization of the servlet. <br>
	 *
	 * @throws ServletException if an error occurs
	 */
	public void init() throws ServletException {
		// Put your code here
	}

}
