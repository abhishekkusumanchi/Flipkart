package com.amazon.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import com.amazon.DAL.ProductsDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/checkAvailability")
public class CheckPinCodeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Get the product ID and pincode from the request parameters
		int productId = Integer.parseInt(request.getParameter("productId"));
		int pincode = Integer.parseInt(request.getParameter("pincode"));

		HttpSession httpSession = request.getSession();
		httpSession.setAttribute("previousUrl", request.getRequestURI());
		ProductsDAO productsDAO = (ProductsDAO) httpSession.getAttribute("productsDAO");
		if (productsDAO == null) {
			productsDAO = new ProductsDAO();
			httpSession.setAttribute("productsDAO", productsDAO);
		}
		// Check product availability based on the pincode (Assuming a DAO class for product availability)
		boolean available = productsDAO.isProductAvailable(productId, pincode);

		// Prepare the JSON response
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		out.print("{\"available\": " + available + "}");
		out.flush();
	}

}
