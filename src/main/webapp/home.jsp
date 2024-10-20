<%-- 
    Document   : home.jsp
    Created on : Oct 14, 2024, 10:58:25 AM
    Author     : sahan
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Get answer for anything</title>
    <link rel="icon" type="image/png" href="https://i.ibb.co/0rQ9YbJ/IMG-20241017-153525.png">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="styles.css">
</head>
<body>

<c:forEach var="post" items="${postList}">
    <div class="post-container">
        <!-- Profile Section -->
        <div class="profile-section">
            <div class="profile-left">
                <img src="${post.communityIconUrl}" alt="Community Icon">
                <div>
                    <strong class="profile-text">${post.profileName}</strong><br>
                    <small>${post.postTime}</small>
                </div>
            </div>
            <div class="profile-right">
                <button class="join-button">Join</button>
                <i class="fas fa-ellipsis-h"></i>
            </div>
        </div>

        <!-- Content Section -->
        <div class="content-section">
            <h3>${post.postTitle}</h3>
            <img src="${post.postImageUrl}" alt="Post Image">
        </div>

        <!-- Vote Section -->
        <div class="vote-section">
            <div class="vote">
                <button><i class="fas fa-arrow-up"></i>${post.upvotes}</button>
                <button><i class="fas fa-arrow-down"></i></button>
            </div>
            <div class="vote-section1">
                <button><i class="fas fa-comment"></i></button>
                <button><i class="fa-solid fa-certificate"></i></button>
                <button><i class="fas fa-share"></i>Share</button>
            </div>
        </div>
    </div>
</c:forEach>
<%@ include file="navbar.jsp" %>


</body>
</html>
