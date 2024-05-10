package com.amazon.servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.ResourceBundle;

import org.json.JSONObject;

import com.amazon.DAL.ProductsDAO;
import com.amazon.models.Address;
import com.amazon.models.Order;
import com.amazon.models.Product;
// Razorpay Import
import com.razorpay.RazorpayClient;
import com.razorpay.RazorpayException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession httpSession = request.getSession();
		httpSession.setAttribute("previousUrl", request.getRequestURI());
		Map<Integer, Integer> cartMap = (Map<Integer, Integer>) httpSession.getAttribute("cartMap");
		ProductsDAO productsDAO = (ProductsDAO) httpSession.getAttribute("productsDAO");
		if (productsDAO == null) {
			productsDAO = new ProductsDAO();
			httpSession.setAttribute("productsDAO", productsDAO);
		}
		List<Product> products;
		if (cartMap == null) {
			products = productsDAO.getProducts(new ArrayList<>());
		} else {
			products = productsDAO.getProducts(new ArrayList<>(cartMap.keySet()));

		}
		request.setAttribute("cartMap", cartMap);
		boolean result = productsDAO.addressFilled((String) httpSession.getAttribute("USERNAME"));
		if (result) {
			Address address = productsDAO.getAddressByUserId((String) httpSession.getAttribute("USERNAME"));
			Order order = productsDAO.createOrder((String) httpSession.getAttribute("USERNAME"), products, cartMap);
			System.out.println(order + " in checkourservlet");
			request.setAttribute("order", order);
			request.setAttribute("products", products);
			request.setAttribute("address", address);

			// Get the total order price and create the razorpay order
			double orderTotal = order.getOrderTotal();
			if (orderTotal < 500) {
				httpSession.setAttribute("shipping", "Rs.70 (Add items worth above Rs.500 for free shipping)");
				orderTotal += 70;
			} else {
				httpSession.setAttribute("shipping", "Free Shipping");
			}

			// Getting the id and key from db.properties
			ResourceBundle resourceBundle = ResourceBundle.getBundle("db");
			String key_id = resourceBundle.getString("key_id");
			String key_secret = resourceBundle.getString("key_secret");

			try {
				RazorpayClient razorpay = new RazorpayClient(key_id, key_secret);
				JSONObject orderRequest = new JSONObject();
				orderRequest.put("amount", Math.round(orderTotal * 100)); // Razorpay expects amount in paisa
				orderRequest.put("currency", "INR");
				orderRequest.put("receipt", "order_receipt_" + System.currentTimeMillis());
				com.razorpay.Order razorpayOrder = razorpay.orders.create(orderRequest); // Fully qualify Razorpay Order
				String orderId = razorpayOrder.get("id"); // Fully qualify Razorpay Order
				httpSession.setAttribute("orderId", orderId);
				httpSession.setAttribute("key", key_id);
				httpSession.setAttribute("orderAmount", Math.round(orderTotal));

				System.out.println(orderId);
			} catch (RazorpayException e) {
				// Handle Razorpay exception
				e.printStackTrace();
			}

			request.getRequestDispatcher("Checkout.jsp").forward(request, response);
		} else {
			request.getRequestDispatcher("AddressForm.jsp").forward(request, response);
		}

		request.setAttribute("products", products);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
