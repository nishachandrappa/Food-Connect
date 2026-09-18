<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    int id = Integer.parseInt(request.getParameter("id"));
    String foodItem = "", description = "", pickDate = "", address = "", city = "", contactPerson = "", phoneNumber = "";

    try (Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/food", "root", "nischi@123")) {
        PreparedStatement statement = connection.prepareStatement("SELECT * FROM food_items WHERE id = ?");
        statement.setInt(1, id);
        ResultSet resultSet = statement.executeQuery();
        if (resultSet.next()) {
            foodItem = resultSet.getString("food_item");
            description = resultSet.getString("description");
            pickDate = resultSet.getString("pick_date");
            address = resultSet.getString("address");
            city = resultSet.getString("city");
            contactPerson = resultSet.getString("contact_person");
            phoneNumber = resultSet.getString("phone_number");
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Update Food Item</title>
</head>
<body>
    <h1>Update Food Item</h1>
    <form action="FoodManagementServlet" method="post">
        <input type="hidden" name="action" value="updateFood">
        <input type="hidden" name="id" value="<%= id %>">

        <label for="foodItem">Food Item:</label>
        <input type="text" id="foodItem" name="foodItem" value="<%= foodItem %>" required>

        <label for="description">Description:</label>
        <textarea id="description" name="description" required><%= description %></textarea>

        <label for="pickDate">Pick Date:</label>
        <input type="date" id="pickDate" name="pickDate" value="<%= pickDate %>" required>

        <label for="address">Address:</label>
        <input type="text" id="address" name="address" value="<%= address %>" required>

        <label for="city">City:</label>
        <input type="text" id="city" name="city" value="<%= city %>" required>

        <label for="contactPerson">Contact Person:</label>
        <input type="text" id="contactPerson" name="contactPerson" value="<%= contactPerson %>" required>

        <label for="phoneNumber">Phone Number:</label>
        <input type="tel" id="phoneNumber" name="phoneNumber" value="<%= phoneNumber %>" required>

        <button type="submit">Update</button>
    </form>
</body>
</html>
