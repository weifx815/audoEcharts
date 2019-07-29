package com;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LineServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public LineServlet() {
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
		 Random rand = new Random();
         int[] data0 = new int[7];
         int[] data1 = new int[7];
         int[] data2 = new int[7];
         int[] data3 = new int[7];
         int[] data4 = new int[7];
         for (int i = 0; i < 7; i++) {
        	 data0[i] = rand.nextInt((500 - 100) + 1) + 10;
        	 data1[i] = rand.nextInt((500 - 100) + 1) + 10;
        	 data2[i] = rand.nextInt((500 - 100) + 1) + 10;
        	 data3[i] = rand.nextInt((500 - 100) + 1) + 10;
        	 data4[i] = rand.nextInt((500 - 100) + 1) + 10;
		}
         Map<String,Object> map = new HashMap<String,Object>();
    	 map.put("data0", data0);
    	 map.put("data1", data1);
    	 map.put("data2", data2);
    	 map.put("data3", data3);
    	 map.put("data4", data4);
		 out.println(JsonUtil.MapObjToJson(map));
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
