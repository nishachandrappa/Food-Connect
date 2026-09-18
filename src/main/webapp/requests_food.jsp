<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Request Food</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f9;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            width: 400px;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
            border: 2px solid #ddd; /* Adding a border to the container */
        }
        h1 {
            color: #333;
            margin-bottom: 20px;
        }
        form {
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        label {
            font-weight: bold;
            margin-bottom: 5px;
            color: #555;
            align-self: flex-start;
        }
        input[type="text"], input[type="submit"] {
            padding: 10px;
            font-size: 14px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            width: 100%;
        }
        input[type="submit"] {
            background-color: #28a745;
            color: #fff;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        input[type="submit"]:hover {
            background-color: #218838;
        }
        .error-message {
            color: red;
            margin-bottom: 20px;
        }
        .success-message {
            color: green;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Request Food</h1>
        <% 
            String foodIdParam = request.getParameter("foodId");
            if (foodIdParam == null || foodIdParam.isEmpty()) {
                out.print("<p class='error-message'>Error: Food ID is missing.</p>");
                return;
            }

            int id = Integer.parseInt(foodIdParam);

            if ("POST".equalsIgnoreCase(request.getMethod())) {
                // Handle form submission
                String requesterName = request.getParameter("requester_name");
                String requesterAddress = request.getParameter("requester_address");
                String email = request.getParameter("email");
                String request_status = request.getParameter("request_status");

                try (Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/food", "root", "nischi@123")) {
                    String insertSQL = "INSERT INTO food_requests (food_id, requester_name, requester_address, email, request_status) VALUES (?, ?, ?, ?, ?)";
                    PreparedStatement statement = connection.prepareStatement(insertSQL);
                    statement.setInt(1, id);
                    statement.setString(2, requesterName);
                    statement.setString(3, requesterAddress);
                    statement.setString(4, email);
                    statement.setString(5, request_status);
                    int rowsInserted = statement.executeUpdate();
                    if (rowsInserted > 0) {
                        out.print("<p class='success-message'>Submitted successfully!</p>");
                    } else {
                        out.print("<p class='error-message'>Submission failed. Please try again.</p>");
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                    out.print("<p class='error-message'>Error: " + e.getMessage() + "</p>");
                }
            }
        %>
        <form method="post">
            <input type="hidden" name="food_id" value="<%= id %>">

            <label for="requester_name">Your Name:</label>
            <input type="text" name="requester_name" required>

            <label for="requester_address">Your Address:</label>
            <input type="text" name="requester_address" required>

            <label for="email">Email:</label>
            <input type="text" name="email" required>

            <label for="request_status">Request Status:</label>
            <input type="text" name="request_status" required>

            <input type="submit" value="Submit Request">
        </form>
    </div>
</body>
</html>
