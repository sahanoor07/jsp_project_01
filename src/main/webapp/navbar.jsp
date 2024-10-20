<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>What to Do</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="styles.css">
</head>
<body>

<!-- Navigation Bar -->
<nav class="navbar">
    <div class="logo">
        <a href="PostServlet">
         <img src="https://i.ibb.co/fFxZW6T/IMG-20241017-110432.png" alt="alt" style="width:150px; height: auto; overflow: hidden;"/>
        </a>
    </div>
    <div class="search-container">
        <input type="text" placeholder="Search What to Do" />
    </div>
    <div class="navbar-right">
        <button class="create-button" onclick="window.location.href='postform.jsp'">
            <i class="fas fa-plus"></i> Create
        </button>
        <i class="fas fa-bell bell-icon"></i>
        
    <c:if test="${not empty sessionScope.profile_name}">
    <span class="profile-icon">
        <a href="userprofile.jsp">
            <img src="${sessionScope.image_url}" alt="Profile" class="profile-pic" />
        </a>
    </span>
</c:if>

        
        <c:if test="${empty sessionScope.profile_name}">
            <button class="login-button" onclick="window.location.href='login.jsp'">Login</button>
        </c:if>
    </div>
</nav>

<!-- Main Content -->
<div class="content-container">
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="menu-options">
            <a href="PostServlet">
            <div class="menu-item" >
                <i class="fas fa-home"></i>
                <span>Home</span>
            </div>
            </a>
            <div class="menu-item">
                <i class="fas fa-fire"></i>
                <span>Popular</span>
            </div>
            <div class="menu-item">
                <i class="fas fa-compass"></i>
                <span>Explore</span>
            </div>
            <div class="menu-item">
                <i class="fas fa-th-large"></i>
                <span>All</span>
            </div>
        </div>

        <hr>
        
        <div class="menu-options">
            <div class="section-heading">Resources</div>
            <div class="menu-item">
                <i class="fas fa-info-circle"></i>
                <span>About</span>
            </div>
            <div class="menu-item">
                <i class="fas fa-question-circle"></i>
                <span>Reddit Help</span>
            </div>
            <div class="menu-item">
                <i class="fas fa-bullhorn"></i>
                <span>Advertise</span>
            </div>
            <div class="menu-item">
                <i class="fas fa-blog"></i>
                <span>Blog</span>
            </div>
            <div class="menu-item">
                <i class="fas fa-briefcase"></i>
                <span>Careers</span>
            </div>
            <div class="menu-item">
                <i class="fas fa-newspaper"></i>
                <span>Press</span>
            </div>
        </div>

        <div class="adbar">
            <div class="ad-column">
                <div class="ad-label">Ad</div>
                <img src="https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/09f4a241993425.57bc86ea86b4e.jpg" alt="Ad 1" class="ad-image" />
            </div>
            <div class="ad-column">
                <div class="ad-label">Ad</div>
                <img src="https://d1csarkz8obe9u.cloudfront.net/posterpreviews/join-our-facebook-community-design-template-98acfa9c59c320333332b299412f088e_screen.jpg?ts=1694263319" alt="Ad 2" class="ad-image" />
            </div>
            <div class="ad-column">
                <div class="ad-label">Ad</div>
                <img src="https://newspaperads.ads2publish.com/wp-content/uploads/2019/01/zomato-order-food-on-zomato-upto-50-all-month-ad-times-of-india-mumbai-20-01-2019.png" alt="Ad 3" class="ad-image" />
            </div>
        </div>
    </div>
</div>

</body>
</html>
