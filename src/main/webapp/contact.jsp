<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Contact Us - Waste Management System</title>
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
            font-size: 10px;
            transition: background-color 0.3s;
        }
        .navbar a:hover {
            background-color: #34495e;
        }
        .container {
            display: flex;
            justify-content: space-between;
            padding: 40px 20px;
            background-color: #f4f4f4;
            gap: 20px;  /* Equal spacing between both sections */
        }
        .form-container, .contact-info {
            flex: 1; /* Ensures both elements take up equal space */
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .form-container h2, .contact-info h2 {
            text-align: center;
            color: #333;
        }
        .form-container form input, .form-container form textarea {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .form-container form button {
            width: 100%;
            padding: 10px;
            background-color: #2c3e50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .form-container form button:hover {
            background-color: #34495e;
        }
        .contact-info p {
            margin-bottom: 10px;
            color: #333;
        }
        .contact-info h3 {
            color: #2c3e50;
        }
    </style>
</head>
<body>
    <!-- Navigation Bar -->
    <div class="navbar">
        <a href="<%=request.getContextPath()%>/index.jsp">Home</a>
        <a href="<%=request.getContextPath()%>/about.jsp">About</a>
        <a href="<%=request.getContextPath()%>/available.jsp">Available</a>
        <a href="<%=request.getContextPath()%>/contact.jsp">Contact</a>
        <a href="<%=request.getContextPath()%>/donor.jsp">Donor</a>
        <a href="<%=request.getContextPath()%>/admin.jsp">Admin</a>
    </div>

    <!-- Contact Page Container -->
    <div class="container">
        <!-- Left Side: Want to Work with Us Form -->
        <div class="form-container">
            <h2>Want to Work with Us?</h2>
            <form action="<%=request.getContextPath()%>/submitContact.jsp" method="post">
                <input type="text" name="firstName" placeholder="First Name" required>
                <input type="text" name="lastName" placeholder="Last Name" required>
                <input type="text" name="phone" placeholder="Phone Number" required>
                <input type="email" name="email" placeholder="Email Address" required>
                <textarea name="message" rows="4" placeholder="Your Message" required></textarea>
                <button type="submit">Submit</button>
            </form>
        </div>

        <!-- Right Side: Contact Us Information -->
        <div class="contact-info">
            <h2>Contact Us</h2>
            <p><strong>Address:</strong></p>
            <p>Waste Management System,Jayanagar,Bengaluru</p>

            <p><strong>Contact Number:</strong></p>
            <p>+1 234 567 890</p>

            <p><strong>Email:</strong></p>
            <p>info@wastemanagement.com</p>
        </div>
    </div>
</body>
</html>