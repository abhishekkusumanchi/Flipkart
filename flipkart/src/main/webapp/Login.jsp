<%@ page language="java" import="com.amazon.models.Product,java.util.List,java.util.ArrayList" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Login Form</title>
<style>
body {
    font-family: "Amazon Ember", Arial, sans-serif;
    background-color: #f3f3f3;
    margin: 0;
    padding: 0;
    background-image: url('https://img.freepik.com/free-photo/arrangement-black-friday-shopping-carts-with-copy-space_23-2148667047.jpg'); /* Replace 'background-image-url.jpg' with your image URL */
    background-size: cover;
    background-position: center;
}

h2 {
    text-align: center;
    margin-bottom: 30px;
    color: #FFD700; /* Dark text color */
}

form {
    max-width: 400px;
    margin: 30px auto;
    padding: 30px;
    border: 1px solid #ddd;
    border-radius: 5px;
    background-color: rgba(255, 255, 255, 0.4); /* Semi-transparent background */
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    animation: fadeIn 1s ease; /* Fade-in animation */
}

@keyframes fadeIn {
    from {
        opacity: 0;
    }
    to {
        opacity: 1;
    }
}

label, input, button, .register-link {
    display: block;
    margin-bottom: 20px;
}

input[type="text"], input[type="password"] {
    width: calc(100% - 20px);
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 4px;
}

button {
    padding: 12px 20px;
    background-color: #ff9900;
    color: #fff;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    transition: background-color 0.3s ease; /* Smooth transition */
}

button:hover {
    background-color: #ffad33;
}

.error-message {
    color: red;
    margin-top: 10px;
}

.register-link {
    font-size: 16px;
    text-align: center;
}

.register-link a {
    color: #0066c0;
    text-decoration: none;
    transition: color 0.3s ease; /* Smooth transition */
}

.register-link a:hover {
    color: #004080; /* Darker shade on hover */
}

</style>
</head>
<body>
	<h2>Login</h2>
	<form id="loginForm">
		<label for="loginUsername">UserId:</label>
		<input type="text" id="loginUsername" required><br>
		<label for="loginPassword">Password:</label>
		<input type="password" id="loginPassword" required><br>
		<button type="submit">Login</button>

		<div class="register-link">
			<a href="Register.jsp">Register</a>
		</div>
	</form>

	<div id="loginError" style="color: red;"></div>

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
		$(document).ready(function() {
			$('#loginForm').on('submit', function(event) {
				event.preventDefault();
				validateLogin();
			});

			function validateLogin() {
				var username = $('#loginUsername').val();
				var password = $('#loginPassword').val();
				var errorDiv = $('#loginError');
				errorDiv.html('');

				// Perform client-side validations
				if (!username || !password) {
					errorDiv.html('Username and password are required.');
					return false;
				}

				// Send AJAX request to validate credentials
				$.ajax({
					url: 'http://localhost:9090/flipkart/validateLogin', 
					method: 'POST',
					data: { username: username, password: password },
					success: function(response) {
						if (response.valid) {
							window.location.href = response.url;
						} else {
							errorDiv.html('Invalid username or password.');
						}
					},
					error: function(xhr, status, error) {
						alert(error);
						errorDiv.html('Error occurred while processing the request.');
					}
				});
			}
		});
	</script>
</body>
</html>
