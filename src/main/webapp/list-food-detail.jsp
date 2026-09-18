<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>List Your Food Detail</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f7fc;
            margin: 0;
            padding: 0;
        }
        header {
            background-color: #3498db;
            color: white;
            padding: 20px;
            text-align: center;
        }
        header h1 {
            margin: 0;
            font-size: 2em;
        }
        h2 {
            color: #2c3e50;
            margin-top: 30px;
        }
        .container {
            max-width: 1000px;
            margin: 30px auto;
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        form {
            margin-bottom: 40px;
        }
        label {
            display: block;
            margin: 10px 0 5px;
            font-weight: bold;
            color: #2c3e50;
        }
        input[type="text"], input[type="date"], input[type="tel"], textarea {
            width: 100%;
            padding: 12px;
            margin: 8px 0 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 1em;
            color: #2c3e50;
        }
        button {
            background-color: #3498db;
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 5px;
            font-size: 1.2em;
            cursor: pointer;
        }
        button:hover {
            background-color: #2980b9;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 40px;
        }
        table th, table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        table th {
            background-color: #3498db;
            color: white;
        }
        table tr:hover {
            background-color: #f4f4f4;
        }
        .actions a {
            margin-right: 15px;
            color: #3498db;
            text-decoration: none;
        }
        .actions a:hover {
            color: #2980b9;
        }
    </style>
</head>
<body>
    <header>
        <h1>Food Listing Management</h1>
    </header>

    <div class="container">
    <%-- Success Message --%>
        <% if (request.getAttribute("message") != null) { %>
            <div style="color: green; font-weight: bold; margin-bottom: 20px;">
                <%= request.getAttribute("message") %>
            </div>
        <% } %>
        <h2>Add Food</h2>
        <form action="FoodManagementServlet" method="post">
            <input type="hidden" name="action" value="addFood">
            <label for="foodItem">Food Item:</label>
            <input type="text" id="foodItem" name="foodItem" required>

            <label for="description">Description:</label>
            <textarea id="description" name="description" required></textarea>

            <label for="pickDate">Pick Date:</label>
            <input type="date" id="pickDate" name="pickDate" required>

            <label for="address">Address:</label>
            <input type="text" id="address" name="address" required>

            <label for="city">City:</label>
            <input type="text" id="city" name="city" required>

            <label for="contactPerson">Contact Person:</label>
            <input type="text" id="contactPerson" name="contactPerson" required>

            <label for="phoneNumber">Phone Number:</label>
            <input type="tel" id="phoneNumber" name="phoneNumber" required>

            <button type="submit">Submit</button>
        </form>

        <h2>Manage Food</h2>
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
                    <th>Actions</th>
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
                    <td class="actions">
                        <a href="FoodManagementServlet?action=updateFood&id=<%= resultSet.getInt("id") %>">Edit</a>
                        <a href="FoodManagementServlet?action=deleteFood&id=<%= resultSet.getInt("id") %>" onclick="return confirm('Are you sure you want to delete this food item?')">Delete</a>
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
    </div>
</body>
</html>
