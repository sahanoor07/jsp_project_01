<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    // No need to explicitly declare HttpSession, it is available as an implicit object
    String profile_name = (String) session.getAttribute("profile_name");

    if (profile_name == null) {
        response.sendRedirect("login.jsp"); // Redirect to login page if user is not logged in
        return;
    }

    // Database connection details
    String JDBC_URL = "jdbc:mysql://localhost:3306/whattodo";
    String JDBC_USER = "root";
    String JDBC_PASSWORD = "Sam26102004#"; // Your MySQL password here

    // Variables to hold fetched user data
    String email = "";
    String imageUrl = ""; // Initialize imageUrl as an empty string

    // Fetch user data from the database
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
        
        // Updated SQL query to include image_url
        String sql = "SELECT email, image_url FROM users WHERE profile_name = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, profile_name);
        
        ResultSet rs = stmt.executeQuery();
        
        if (rs.next()) {
            email = rs.getString("email");
            imageUrl = rs.getString("image_url"); // Fetch the image URL
            if (imageUrl == null) {
                imageUrl = ""; // Ensure imageUrl is an empty string if null
            }
        }

        rs.close();
        stmt.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<html>
<head>
    <title>Post Page</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="styles.css">
    
</head>

<style>


.profile-icon {
    display: inline-block;
    width: 40px; /* Set width for the icon */
    height: 40px; /* Set height for the icon */
    border-radius: 50%; /* Makes the image circular */
    overflow: hidden; /* Prevents overflow */
}

.profile-pic {
    width: 100%; /* Ensure the image fits within the icon */
    height: auto; /* Maintain aspect ratio */
    border-radius: 50%; /* Makes the image circular */
    overflow: hidden; /* Prevents overflow */

}


.content-section-profile {
    display: flex;
    align-items: flex-start; /* Align items to the top */
    margin-top: 10px;
}

.content-section-profile img {
    width: 100px; /* Set the width of the image */
    height: auto;
    margin-right: 20px; /* Add space between the image and the text */
    border-radius: 10px; /* Optional: rounded corners for the image */
}

.content-section-profile .text-content {
    display: flex;
    flex-direction: column; /* Stack h3 and p vertically */
}

.content-section-profile h3 {
    margin: 0;
    font-size: 18px;
    font-weight: 400;
    color: #ffffff; /* Ensure the text color is visible on dark background */
}

.content-section-profile p {
    margin: 5px 0 0 0; /* Space between h3 and p */
    color: #818181;
    font-size: 14px;
}

.update-button {
                width: 80%;
                text-align: center;
                margin-right: 10px;
                color: #ffffff;
            border-radius: 20px;
            padding: 10px 15px;
            cursor: pointer;
            background-color: #ff5500;
            margin-right: 20px;
            border: none;
            }
.delete-button {
                width: 80%;
                text-align: center;
                margin-right: 10px;
                color: #000000;
            border-radius: 20px;
            padding: 10px 15px;
            cursor: pointer;
            background-color: #00eaff;
            margin-right: 20px;
            border: none;
            }

            .logout-button {
                width: 20%;
                text-align: center;
                margin-right: 10px;
                color: #ffffff;
            border-radius: 20px;
            padding: 10px 15px;
            cursor: pointer;
            background-color: #81818100;
            margin-right: 20px;
            border: none;
            margin-left: 50%;
            border: 1px solid white;
            }

            .profile-info {
    display: flex;
    align-items: center; /* Align items vertically centered */
    margin: 20px 0; /* Space around the div */
}

.profile-info img {
    width: 50px; /* Set the profile icon size */
    height: 50px;
    border-radius: 50%; /* Make the image circular */
    margin-right: 15px; /* Space between the image and the text */
}

.profile-info .user-details {
    display: flex;
    flex-direction: column; /* Stack profile_name and email vertically */
}

.profile-info .user-details .profile_name {
    font-size: 18px;
    color: #ffffff; /* White for the profile_name */
}

.profile-info .user-details .email {
    font-size: 14px;
    color: #cccccc; /* Light gray for the email */
}

.logout-button {
                width: 20%;
                text-align: center;
                margin-right: 10px;
                color: #ffffff;
            border-radius: 20px;
            padding: 10px 15px;
            cursor: pointer;
            background-color: #81818100;
            margin-right: 20px;
            border: none;
            margin-left: 40%;
            border: 1px solid white;
            }
            
            
</style>

<body>
    <div class="post-container">
        <div class="profile-info">
            <% if (!imageUrl.isEmpty()) { %>
                <img src="<%= imageUrl %>" alt="Profile Image" class="profile-icon">
            <% } else { %>
                <img src="default-profile.png" alt="Default Profile Image" class="profile-icon"> <!-- Fallback image -->
            <% } %>
            <div class="user-details">
                <span class="profile_name"><%= profile_name %></span>
                <span class="email"><%= email %></span>
            </div>
            <button type="submit" class="logout-button" onclick="window.location.href='LogoutServlet'">Logout</button>
        </div>
        <hr>

            <div class="profile-section">
                <div class="profile-left">
                    <small>${postList.postTime}</small> <!-- You can replace this with a dynamic post time -->
                </div>
                <div class="profile-right">
                    <form action="updatePost.jsp" method="post">
                        <input type="hidden" name="postId" value="${post.id}">
                        <button type="submit" class="update-button">Update</button>
                    </form>
                    <form action="deletePost.jsp" method="post">
                        <input type="hidden" name="postId" value="${post.id}">
                        <button type="submit" class="delete-button">Delete</button>
                    </form>
                </div>
            </div>

            <div class="content-section-profile">
                <img src="${post.postImageUrl}" alt="Post Image"> <!-- Use dynamic post image URL -->
                <div class="text-content">
                    <h3>"${post.postTitle}"</h3> <!-- Use dynamic post title -->
                    <p>"${post.post}"</p> <!-- Use dynamic post content -->
                </div>
            </div>

            <div class="vote-section">
                <div class="vote">
                    <form action="vote.jsp" method="post">
                        <input type="hidden" name="postId" value="${post.id}">
                        <button type="submit"><i class="fas fa-arrow-up"></i>${post.upvotes}</button>
                        <button type="submit"><i class="fas fa-arrow-down"></i></button>
                    </form>
                </div>
                <div class="vote-section1">
                    <button><i class="fas fa-comment"></i></button>
                    <button><i class="fa-solid fa-certificate"></i></button>
                    <button><i class="fas fa-share"></i> Share</button>
                </div>
            </div>
    </div>

    <%@ include file="navbar.jsp" %>
</body>
</html>
