<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-image: url("https://images6.alphacoders.com/112/thumb-1920-1128590.jpg");
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .register-container {
            background-color: #121212;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
            width: 300px;
            text-align: center;
        }

        .register-container h2 {
            margin-bottom: 20px;
            color: #cccccc;
        }

        .register-container input[type="text"], 
        .register-container input[type="password"],
        .register-container input[type="email"] {
            width: 90%;
            padding: 10px 20px;
            margin: 10px 0;
            border-radius: 50px;
            border: 1px solid #ccc;
            background: transparent;
            color:#ffffff;
        }

        .register-container button {
            color: #ffffff;
            border-radius: 50px;
            padding: 10px 15px;
            cursor: pointer;
            background-color: #ff5500;
            width: 100%;
        }

        .register-container button:hover {
            background-color: #ff5501;
        }

        .social-btn {
            margin: 5px 0;
            padding: 10px;
            width: 100%;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .google-btn {
            background-color: #db4437;
            color: white;
        }

        .facebook-btn {
            background-color: #3b5998;
            color: white;
        }

        .links a {
            color: #cccccc;
            text-decoration: none;
        }

        .links {
            margin-top: 20px;
            color: #cccccc;
        }
    </style>
</head>
<body>

    <div class="register-container">
        <h2>Register</h2>

        <!-- profile_name, Email, and Password Registration -->
        <form action="RegisterServlet" method="post">
            <input type="text" name="profile_name" placeholder="Enter your username" required>
            <input type="url"  name="image_url" placeholder="Enter profile image URL" >
            <input type="email" name="email" placeholder="Enter Email" required>
            <input type="password" name="password" placeholder="Enter Password" required>
            <button type="submit">Register</button>
        </form>

        <p>OR</p>

        <!-- Social Sign Up buttons (Google and Facebook) -->
        <button class="social-btn google-btn">Sign up with Google</button>
        <button class="social-btn facebook-btn">Sign up with Facebook</button>

        <div class="links">
            <p><a href="login.jsp">Already have an account? Login</a> | <a href="PostServlet">Back to Homepage</a></p>
        </div>
    </div>

</body>
</html>
