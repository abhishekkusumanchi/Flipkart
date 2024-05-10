<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Register Form</title>
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

label, input, button {
    display: block;
    margin-bottom: 20px;
}

input[type="text"], input[type="email"], input[type="password"] {
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

.login-link {
    font-size: 16px;
    text-align: center;
}

.login-link a {
    color: #0066c0;
    text-decoration: none;
    transition: color 0.3s ease; /* Smooth transition */
}

.login-link a:hover {
    color: #004080; /* Darker shade on hover */
}

</style>
</head>
<body>
    <h2>Register</h2>
    <form id="registerForm">
        <label for="username">Username:</label>
        <input type="text" id="username" required><br>
        <label for="email">Email:</label>
        <input type="email" id="email" required><br>
        <label for="password">Password:</label>
        <input type="password" id="password" required><br>
        <label for="confirmPassword">Confirm Password:</label>
        <input type="password" id="confirmPassword" required><br>
        
        <button type="submit">Register</button>
        <div class="login-link">
            <a href="Login.jsp">Back to Login Page</a>
        </div>
    </form>

    <div id="registerError" style="color: red;"></div>
    
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
    $(document).ready(function() {
        $('#registerForm').on('submit', function(event) {
            event.preventDefault();
            registerUser();
        });

        function registerUser() {
            var username = $('#username').val();
            var email = $('#email').val();
            var password = $('#password').val();
            var confirmPassword = $('#confirmPassword').val();
            var errorDiv = $('#registerError');
            errorDiv.html('');

            // Perform client-side validations
            if (!username || !email || !password || !confirmPassword) {
                errorDiv.html('All fields are required.');
                return false;
            }

            if (password !== confirmPassword) {
                errorDiv.html('Passwords do not match.');
                return false;
            }

            $.ajax({
                url: 'http://localhost:9090/flipkart/createUser', 
                method: 'POST',
                data: { username: username, email: email, password: password },
                success: function(response) {
                    if (response.success) {
                        window.location.href = 'http://localhost:9090/flipkart/Login.jsp';
                    } else {
                        errorDiv.html('Registration failed. Please try again.');
                    }
                },
                error: function(xhr, status, error) {
                    errorDiv.html('Error occurred while processing the request.');
                }
            })
        }
    });
</script>

</body>
</html>
