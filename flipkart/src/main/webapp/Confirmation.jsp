<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<title>Payment Confirmation</title>
</head>
<body>
	<nav>
		<a href="/flipkart/home"><img alt="logo"
			src="./assets/images/logo.png" width="120px" height="41px"></a>
		<div>

			<%
			if (session.getAttribute("LOGGEDIN") != null && session.getAttribute("LOGGEDIN").equals("yes")) {
				String username = (String) session.getAttribute("USERNAME");
			%>
			<span>Welcome, <%=username%></span>
			<%
			} else {
			%>
			<a href="Login.jsp">Login</a>
			<%
			}
			%>

		</div>
	</nav>
	<div class="heading-and-link">
		<h1>Payment Confirmation</h1>
		<p>Thank you for your payment!</p>
		<p>
			Payment ID:
			<%=request.getParameter("payment_id")%></p>
		<!-- Additional confirmation details or actions can be added here -->

		<a href="home">Continue Shopping</a>
	</div>
	</div>

</body>
</html>