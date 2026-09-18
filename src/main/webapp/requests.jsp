<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Requests</title>
</head>
<body>
    <h1>Requests</h1>

    <table border="1">
        <thead>
            <tr>
                <th>Requester Name</th>
                <th>Requester Address</th>
                <th>Requester Email</th>
                <th>Request Status</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <%
                try (Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/food", "root", "nischi@123")) {
                    Statement statement = connection.createStatement();
                    ResultSet resultSet = statement.executeQuery("SELECT * FROM food_requests");
                    while (resultSet.next()) {
                        int requestId = resultSet.getInt("food_id"); // Ensure this column exists in your database table
                        String requesterName = resultSet.getString("requester_name");
                        String requesterAddress = resultSet.getString("requester_address");
                        String email = resultSet.getString("email");
                        String requestStatus = resultSet.getString("request_status");
                        %>
                        <tr>
                            <td><%= requesterName %></td>
                            <td><%= requesterAddress %></td>
                            <td><%= email %></td>
                            <td><%= requestStatus %></td>
                            <td>
                                <!-- Ensure 'id' is dynamically inserted -->
                                <a href="FoodManagementServlet?action=completeRequest&id=<%= requestId %>">Complete</a>
                                <a href="FoodManagementServlet?action=rejectRequest&id=<%= requestId %>">Reject</a>
                            </td>
                        </tr>
                        <%
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                    %>
                    <tr>
                        <td colspan="5">Error fetching requests: <%= e.getMessage() %></td>
                    </tr>
                    <%
                }
            %>
        </tbody>
    </table>
</body>
</html>
