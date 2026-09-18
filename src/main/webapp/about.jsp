<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Food Waste Management</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
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
            padding: 15px 20px;
            text-decoration: none;
            font-size: 15px;
            transition: background-color 0.3s;
        }
        .navbar a:hover {
            background-color: #34495e;
        }
        .page-container {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: calc(100vh - 50px); /* Full height minus navbar */
            background-color: #f4f4f4;
        }
        .container {
            display: flex;
            flex-direction: row; /* Ensure horizontal alignment */
            width: 60%;
            background-color:#E0FFFF;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            border-radius: 10px;
            overflow: hidden;
        }
        .image-section {
            flex: 1.5; /* Take up 1/3 of the container width */
            background-color: #e0e0e0;
        }
        .image-section img {
            width: 100%; /* Stretch image to fill the section */
            height: 100%; /* Stretch image to fill the section */
            object-fit: cover;
        }
        .text-section {
            flex: 2; /* Take up 2/3 of the container width */
            padding: 30px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        h1 {
            color: #2c3e50;
            border-bottom: 2px solid #2c3e50;
            padding-bottom: 10px;
        }
        .description {
            line-height: 1.6;
            color: #333;
        }
    </style>
</head>
<body>
    <%-- Navigation Bar --%>
    <div class="navbar">
        <a href="<%=request.getContextPath()%>/index.jsp">Home</a>
        <a href="<%=request.getContextPath()%>/about.jsp">About</a>
        <a href="<%=request.getContextPath()%>/available.jsp">Available List</a>
        <a href="<%=request.getContextPath()%>/contact.jsp">Contact</a>
        <a href="<%=request.getContextPath()%>/donor.jsp">Donor</a>
        <a href="<%=request.getContextPath()%>/admin.jsp">Admin</a>
    </div>

    <%-- Page Content --%>
    <div class="page-container">
        <div class="container">
            <div class="image-section">
                <img src="<%=request.getContextPath()%>/images/aboutimg.jpg" alt="Food Waste Management">
            </div>
            <div class="text-section">
                <h1>Food Waste Management</h1>
                <div class="description">
                    <p style="font-family: Georgia, serif; font-size: 16px;">
    <b>For Donors:</b> Easily list surplus food items with details like
    pickup location and availability. Help reduce waste and make a positive impact.
</p>
<p style="font-family: Georgia, serif; font-size: 16px;">
    <b>For Receivers:</b> Request food with just a few clicks. Together, we can ensure that no one goes hungry.
</p>
<p style="font-family: 'Times New Roman', serif; font-size: 16px;">
    We believe in the power of community and sustainability. Founded with a mission
    to combat food waste and hunger, our platform connects food donors with those in need,
    creating a seamless and efficient system for sharing surplus food.
</p>

                </div>
            </div>
        </div>
    </div>
</body>
</html>