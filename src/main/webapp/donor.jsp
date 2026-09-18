<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Food Waste Management System</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Arial', sans-serif;
            display: flex;
            height: 100vh;
            background-color: #f4f4f4;
        }
        .sidebar {
            width: 250px;
            background-color: #2c3e50;
            padding: 20px;
            display: flex;
            flex-direction: column;
        }
        .sidebar-btn {
            background-color: transparent;
            color: white;
            border: none;
            padding: 15px 20px;
            text-align: left;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s;
            margin-bottom: 10px;
        }
        .sidebar-btn:hover, .sidebar-btn.active {
            background-color: #34495e;
        }
        .content {
            flex-grow: 1;
            padding: 20px;
            background-color: #ecf0f1;
            overflow-y: auto;
        }
        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
        }
        .dashboard-card {
            background-color: white;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            text-align: center;
        }
        .dashboard-card h3 {
            color: #2c3e50;
            margin-bottom: 10px;
        }
        .dashboard-card .value {
            font-size: 2em;
            color: #27ae60;
            font-weight: bold;
        }
        .hidden {
            display: none;
        }
    </style>
</head>
<body>
    <div class="sidebar">
        <button class="sidebar-btn active" data-section="dashboard">Dashboard</button>
        <button class="sidebar-btn" data-section="list-food">List Your Food Detail</button>
        <button class="sidebar-btn" data-section="requests">Requests</button>
    </div>

    <div class="content">
        <%
        // Database connection and data retrieval
        int totalListedFood = 0;
        int foodTakeawayCompleted = 0;
        int rejectedRequests = 0;
        int allRequests = 0;
        int newRequests = 0;

        // Ensure you replace these with your actual database connection details
        Class.forName("com.mysql.cj.jdbc.Driver");
        String dbUrl = "jdbc:mysql://localhost:3306/food";
        String dbUser = "root";
        String dbPassword = "nischi@123";

        try {
            // Load the JDBC driver
            Class.forName("com.mysql.jdbc.Driver");
            
            // Establish the connection
            try (Connection connection = DriverManager.getConnection(dbUrl, dbUser, dbPassword)) {
                try (Statement statement = connection.createStatement()) {
                    // Total Listed Food
                    try (ResultSet resultSet = statement.executeQuery("SELECT COUNT(*) AS total_listed_food FROM food_items")) {
                        if (resultSet.next()) {
                            totalListedFood = resultSet.getInt("total_listed_food");
                        }
                    }

                    // Food Takeaway Completed
                    try (ResultSet resultSet = statement.executeQuery("SELECT COUNT(*) AS food_takeaway_completed FROM food_requests WHERE request_status = 'Completed'")) {
                        if (resultSet.next()) {
                            foodTakeawayCompleted = resultSet.getInt("food_takeaway_completed");
                        }
                    }

                    // Rejected Requests
                    try (ResultSet resultSet = statement.executeQuery("SELECT COUNT(*) AS rejected_requests FROM food_requests WHERE request_status = 'Rejected'")) {
                        if (resultSet.next()) {
                            rejectedRequests = resultSet.getInt("rejected_requests");
                        }
                    }

                    // All Requests
                    try (ResultSet resultSet = statement.executeQuery("SELECT COUNT(*) AS all_requests FROM food_requests")) {
                        if (resultSet.next()) {
                            allRequests = resultSet.getInt("all_requests");
                        }
                    }

                    // New Requests
                    try (ResultSet resultSet = statement.executeQuery("SELECT COUNT(*) AS new_requests FROM food_requests WHERE request_status = 'New'")) {
                        if (resultSet.next()) {
                            newRequests = resultSet.getInt("new_requests");
                        }
                    }
                }
            }
        } catch (ClassNotFoundException e) {
            out.println("JDBC Driver not found: " + e.getMessage());
        } catch (SQLException e) {
            out.println("Database error: " + e.getMessage());
        }
        %>

        <!-- Dashboard Section -->
        <div id="dashboard-section" class="dashboard-section">
            <h1>Donor Dashboard</h1>
            <div class="dashboard-grid">
                <div class="dashboard-card">
                    <h3>Total Listed Food</h3>
                    <div class="value"><%= totalListedFood %></div>
                </div>
                <div class="dashboard-card">
                    <h3>Food Takeaway Completed</h3>
                    <div class="value"><%= foodTakeawayCompleted %></div>
                </div>
                <div class="dashboard-card">
                    <h3>Rejected Requests</h3>
                    <div class="value"><%= rejectedRequests %></div>
                </div>
                <div class="dashboard-card">
                    <h3>All Requests</h3>
                    <div class="value"><%= allRequests %></div>
                </div>
                <div class="dashboard-card">
                    <h3>New Requests</h3>
                    <div class="value"><%= newRequests %></div>
                </div>
            </div>
        </div>

        <!-- Other Sections -->
        <div id="list-food-section" class="hidden">
            <jsp:include page="list-food-detail.jsp" />
        </div>
        <div id="requests-section" class="hidden">
            <jsp:include page="requests.jsp" />
        </div>
        
    </div>

    <script>
    // Select all sidebar buttons
    const buttons = document.querySelectorAll('.sidebar-btn');
    const sections = document.querySelectorAll('.content > div');

    buttons.forEach(button => {
        button.addEventListener('click', () => {
            // Remove the 'active' class from all buttons
            buttons.forEach(btn => btn.classList.remove('active'));
            // Add 'active' to the clicked button
            button.classList.add('active');

            // Hide all sections
            sections.forEach(section => section.classList.add('hidden'));

            // Show the clicked section
            const sectionId = button.getAttribute('data-section') + '-section';
            document.getElementById(sectionId).classList.remove('hidden');
        });
    });
</script>
    
</body>
</html>