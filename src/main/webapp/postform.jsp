<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.*" %>
<%@ page import="jakarta.servlet.http.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create a Post</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="styles.css">
    <link rel="stylesheet" href="forms.css">
    <script>
        function showAlertAndRedirect() {
            alert("Please log in to create a post."); // Show alert
            window.location.href = "login.jsp"; // Redirect to login page
        }
    </script>
</head>
<body>

<%
    // Check if the user is logged in
    if (session.getAttribute("profile_name") == null) {
%>
    <script>
        showAlertAndRedirect(); // Call the JavaScript function
    </script>
<%
        return; // Stop further processing
    }
%>

<!-- Main Content -->
<div class="content-container">
    <h2>Create a New Post</h2>
    <div class="form-container">    
        <div class="form-header">
            <h2>Create a Post</h2>
        </div>
        <form action="postformServlet" method="post">
            <div class="form-group">
                <label for="post_title">Post Title <span class="required">*</span></label>
                <input type="text" id="post_title" name="post_title" placeholder="Enter post title" required>
            </div>
            <div class="form-group">
                <label for="content">Content</label>
                <textarea id="content" name="content" placeholder="Write your post here..." required></textarea>
            </div>
            <div class="form-group">
                <label for="community">Select a Community<span class="required">*</span></label>
                <select id="community" name="community" required>
                    <option value="" disabled selected>Select a community</option>
                    <option value="r/technology">r/technology</option>
                    <option value="r/science">r/science</option>
                    <option value="r/gaming">r/gaming</option>
                    <option value="r/books">r/books</option>
                    <option value="r/music">r/music</option>
                </select>
            </div>
            <div class="form-group">
                <label for="post_image_url">Post Image URL <span class="required">*</span></label>
                <input type="url" id="post_image_url" name="post_image_url" placeholder="Enter post image URL" required>
            </div>
            <div class="form-buttons">
                <button type="button" class="cancel-button" onclick="window.history.back()">Cancel</button>
                <button type="submit" class="submit-button">Post</button>
            </div>
        </form>

        <% 
            // Optional: Display feedback from the servlet if redirected here after submission
            String message = request.getParameter("message");
            if (message != null) { 
        %>
            <h3><%= message %></h3>
        <% 
            } 
        %>
    </div>
</div>
    
<%@ include file="navbar.jsp" %>

</body>
</html>
