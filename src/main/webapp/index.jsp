<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Waste Management System</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        .navbar {
            background-color: #2c3e50;
            overflow: hidden;
            display: flex;
            justify-content: center;
        }
        .navbar a {
            color: white;
            text-align: center;
            padding: 14px 20px;
            text-decoration: none;
            font-size: 15px;
            transition: background-color 0.3s;
        }
        .navbar a:hover {
            background-color: #34495e;
        }
        .image-container {
            width: 100%;
            height: 80vh;
            overflow: hidden;
        }
        .image-container img {
            width: 100%;
            height: 110%;
            object-fit: cover;
        }
        .content {
            text-align: center;
            padding: 20px;
            background-color:#87CEEB;
            font-size:15;
        }
        .description {
            max-width: 800px;
            margin: 0 auto;
            line-height: 1.6;
            color: #333;
        }
    </style>
</head>
<body>
    <%-- Navigation Bar --%>
    <div class="navbar">
        <%-- Modify the navigation to use explicit page redirects --%>
        <a href="<%=request.getContextPath()%>/index.jsp">Home</a>
        <a href="<%=request.getContextPath()%>/about.jsp">About</a>
        <a href="<%=request.getContextPath()%>/available.jsp">Available</a>
        <a href="<%=request.getContextPath()%>/contact.jsp">Contact</a>
        <a href="<%=request.getContextPath()%>/donor.jsp">Donor</a>
        <a href="<%=request.getContextPath()%>/admin.jsp">Admin</a>
    </div>

    <%-- Image Container --%>
    <div class="image-container">
        <img src="<%=request.getContextPath()%>/images/projecthome.jpg" alt="Waste Management Background">
    </div>

    <%-- Content Section --%>
    <div class="content">
        <h1>Welcome to Food Connect</h1>
        <div class="description">
            <p>
               <h2> "Share More, Waste Less"</h2>

In today's world, food waste is a critical issue that impacts millions of people and our planet. 
At Food Connect, we aim to bridge the gap between surplus food and those in need. Our platform empowers
 individuals, restaurants, and organizations to donate excess food, ensuring it reaches people who need it the most.
Whether you're a donor looking to share your surplus or a receiver searching for meals, 
Food Connect is your go-to solution for minimizing food waste and fostering a sustainable community.

            </p>
          
          
        </div>
    </div>
</body>
</html>

