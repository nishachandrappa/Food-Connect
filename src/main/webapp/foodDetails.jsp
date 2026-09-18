<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Food Details</title>
   <style>
        body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    background-color: #d4e8f3; /* Light blue background */
    display: flex;
    justify-content: center;
    align-items: flex-start; /* Align the container to the top */
    height: auto; /* Allow the height to be flexible based on content */
    min-height: 100vh; /* Ensure it still takes full viewport height */
}

.container {
    width: 100%;
    max-width: 800px;
    padding: 20px;
    background: #ffffff; /* White background for the content */
    border-radius: 10px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    margin-top: 20px; /* Add a little margin at the top */
}

h1 {
    text-align: center;
    color: #fff;
    margin-bottom: 20px;
    padding: 10px;
    background-color: skyblue;
    color: #ffffff;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.detail-box {
    background-color: #f9f9f9;
    padding: 15px;
    margin-bottom: 10px; /* Reduced margin-bottom for less space between boxes */
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.detail-box:hover {
    transform: translateY(-3px);
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
}

.detail-box p {
    font-size: 16px;
    color: #555;
    margin: 0;
}

.detail-box strong {
    font-size: 16px;
    color: #333;
}

.back-link {
    display: inline-block;
    margin-top: 20px;
    text-decoration: none;
    color: #ffffff;
    background-color: #007BFF;
    padding: 10px 20px;
    border-radius: 5px;
    font-size: 16px;
    transition: background-color 0.3s ease;
    text-align: center;
}

.back-link:hover {
    background-color: #0056b3;
}

form {
    margin-top: 20px;
    text-align: center;
}

button {
    background-color: #28a745;
    color: #fff;
    border: none;
    padding: 12px 25px;
    font-size: 18px;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

button:hover {
    background-color: #218838;
}

    </style>
</head>
<body>
    <div class="container">
        <h1>Food Details</h1>
        <%
            int foodId = Integer.parseInt(request.getParameter("id"));
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/food", "root", "nischi@123")) {
                PreparedStatement statement = connection.prepareStatement("SELECT * FROM food_items WHERE id = ?");
                statement.setInt(1, foodId);
                ResultSet resultSet = statement.executeQuery();
                if (resultSet.next()) {
                    %>
                    <div class="detail-box">
                        <p><strong>Food Item:</strong> <%= resultSet.getString("food_item") %></p>
                    </div>
                    <div class="detail-box">
                        <p><strong>Description:</strong> <%= resultSet.getString("description") %></p>
                    </div>
                    <div class="detail-box">
                        <p><strong>Pick Date:</strong> <%= resultSet.getDate("pick_date") %></p>
                    </div>
                    <div class="detail-box">
                        <p><strong>Address:</strong> <%= resultSet.getString("address") %></p>
                    </div>
                    <div class="detail-box">
                        <p><strong>City:</strong> <%= resultSet.getString("city") %></p>
                    </div>
                    <div class="detail-box">
                        <p><strong>Contact Person:</strong> <%= resultSet.getString("contact_person") %></p>
                    </div>
                    <div class="detail-box">
                        <p><strong>Phone Number:</strong> <%= resultSet.getString("phone_number") %></p>
                    </div>
                    <!-- Button to request food -->
                    <form action="requests_food.jsp" method="get">
                        <input type="hidden" name="foodId" value="<%= foodId %>">
                        <button type="submit">Request Food</button>
                    </form>
                    <%
                } else {
                    %>
                    <div class="detail-box">
                        <p>No details found for the selected food item.</p>
                    </div>
                    <%
                }
            } catch (SQLException e) {
                e.printStackTrace();
                %>
                <div class="detail-box">
                    <p>Error retrieving food details: <%= e.getMessage() %></p>
                </div>
                <%
            }
        %>
        <a class="back-link" href="available.jsp">Back to Available Food</a>
    </div>
</body>
</html>
