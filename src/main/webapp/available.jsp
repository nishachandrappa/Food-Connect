<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Available Food</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 20px;
        }
        h1 {
            color: #333;
            text-align: center;
            margin-bottom: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background-color: #fff;
            margin: 0 auto;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        th, td {
            padding: 10px;
            text-align: left;
            border: 1px solid #ddd;
        }
        th {
            background-color: #808080;
            color: white;
            font-weight: bold;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tr:nth-child(odd) {
            background-color: #f9f9f9;
        }
        tr:hover {
            background-color: #f9f9f9;
        }
        a {
            color: #D2691E;
            text-decoration: none;
            font-weight: bold;
        }
        a:hover {
            text-decoration: underline;
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
    <h1>Available Food</h1>

    <table>
        <thead>
            <tr>
                <th>Food Item</th>
                <th>Description</th>
                <th>Pick Date</th>
                <th>Address</th>
                <th>City</th>
                <th>Contact Person</th>
                <th>Phone Number</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <%
                try (Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/food","root","nischi@123")) {
                    Statement statement = connection.createStatement();
                    ResultSet resultSet = statement.executeQuery("SELECT * FROM food_items");
                    while (resultSet.next()) {
                        %>
                        <tr>
                            <td><%= resultSet.getString("food_item") %></td>
                            <td><%= resultSet.getString("description") %></td>
                            <td><%= resultSet.getDate("pick_date") %></td>
                            <td><%= resultSet.getString("address") %></td>
                            <td><%= resultSet.getString("city") %></td>
                            <td><%= resultSet.getString("contact_person") %></td>
                            <td><%= resultSet.getString("phone_number") %></td>
                            <td>
                                <a href="foodDetails.jsp?id=<%= resultSet.getInt("id") %>">View Details</a>
                            </td>
                        </tr>
                        <%
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            %>
        </tbody>
    </table>
</body>
</html>
