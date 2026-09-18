<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="java.sql.*" %>

<%
    // Check if the user is logged in (check session)
    HttpSession session1 = request.getSession(false);
    String username = (session1 != null) ? (String) session1.getAttribute("username") : null;

    // If no session or user is not an admin, redirect to login page
    if (username == null || !username.equals("admin")) {
        response.sendRedirect("login.jsp");
        return; // Stop further processing of the page
    } 

   // Initialize database connection
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    int totalCities = 0;
    int totalFoodDonors = 0;
    int totalListedFood=0;
    int totalRequests = 0;
    int newRequests = 0;

    try {
        // Database connection setup (assuming JDBC connection)
        String url = "jdbc:mysql://localhost:3306/food";
        String user = "root";
        String password = "nischi@123";
        
        con = DriverManager.getConnection(url, user, password);

        // Query for total cities (distinct cities)
        String cityQuery = "SELECT COUNT(DISTINCT city) FROM food_items";
        ps = con.prepareStatement(cityQuery);
        rs = ps.executeQuery();
        if (rs.next()) {
            totalCities = rs.getInt(1);
        }

        // Query for total food donors (distinct contact persons)
        String foodDonorQuery = "SELECT COUNT(DISTINCT `contact_person`) FROM food_items";
        ps = con.prepareStatement(foodDonorQuery);
        rs = ps.executeQuery();
        if (rs.next()) {
            totalFoodDonors = rs.getInt(1);
        }
        
     // Total Listed Food
        String totalFood = "SELECT COUNT(*) AS total_listed_food FROM food_items";
        ps = con.prepareStatement(totalFood);
        rs = ps.executeQuery();
        if (rs.next()) {
        	totalListedFood = rs.getInt(1);
        }

        // Query for total requests
        String requestQuery = "SELECT COUNT(*) FROM food_requests";
        ps = con.prepareStatement(requestQuery);
        rs = ps.executeQuery();
        if (rs.next()) {
            totalRequests = rs.getInt(1);
        }

        // Query for new requests (requests with status = 'new')
        String newRequestQuery = "SELECT COUNT(*) FROM food_requests WHERE request_status = 'new'";
        ps = con.prepareStatement(newRequestQuery);
        rs = ps.executeQuery();
        if (rs.next()) {
            newRequests = rs.getInt(1);
        }

    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            //if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - Waste Management System</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            background-color: #f4f4f4;
        }
        .sidebar {
            width: 250px;
            background-color: #2c3e50;
            height: 100vh;
            color: white;
            padding-top: 20px;
        }
        .sidebar-menu {
            list-style-type: none;
            padding: 0;
        }
        .sidebar-menu li {
            padding: 15px 20px;
            border-bottom: 1px solid #34495e;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .sidebar-menu li:hover {
            background-color: #34495e;
        }
        .sidebar-submenu {
            display: none;
            background-color: #34495e;
        }
        .sidebar-submenu li {
            padding: 10px 20px 10px 40px;
            border-bottom: 1px solid #2c3e50;
        }
        .main-content {
            flex-grow: 1;
            padding: 20px;
            background-color: #ecf0f1;
        }
        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }
        .dashboard-box {
            background-color: white;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        .dashboard-box h3 {
            margin-bottom: 15px;
            color: #2c3e50;
        }
        .dashboard-box .number {
            font-size: 2em;
            font-weight: bold;
            color: #3498db;
        }
        .active {
            background-color: #34495e;
        }
        .hidden {
            display: none;
        }
        .color{
        background-color: lightblue;
         }
        
        
    </style>
</head>
<body>
    <%-- Sidebar Navigation --%>
    <div class="sidebar">
        <ul class="sidebar-menu">
            <li class="active" onclick="showDashboard()">Dashboard</li>
            <li onclick="showListedFood()">Listed Food</li>
            <li onclick="showFoodRequests()">Food Requests</li>
            <li onclick="showEnquiries()">Enquiries</li>
            <li onclick="showReports()">Reports</li>
            <li onclick="showSearchListedFood()">Search Listed Food</li>
        </ul>
    </div>

    <%-- Main Content Area --%>
    <div class="main-content">
        <h1 id="pageTitle">Admin Dashboard</h1>
        
        <div id="dashboardContent" class="dashboard-grid">
            <div class="dashboard-box">
                <h3>Total Cities</h3>
                <div class="number"><%= totalCities %></div>
            </div>
            <div class="dashboard-box">
                <h3>Total Food Donors</h3>
                <div class="number"><%= totalFoodDonors %></div>
            </div>
            <div class="dashboard-box">
                <h3>Total Listed Food</h3>
                <div class="number"><%= totalListedFood %></div>
            </div>
            <div class="dashboard-box">
                <h3>All Requests</h3>
                <div class="number"><%= totalRequests %></div>
            </div>
            <div class="dashboard-box">
                <h3>New Requests</h3>
                <div class="number"><%= newRequests %></div>
            </div>
        </div>
        
        
        <%-- Listed Food Section --%>
        <div id="listedFoodContent" class="color hidden">
    <table border="1" style="width: 100%; border-collapse: collapse; text-align: left;">
        <thead>
            <tr>
                <th>ID</th>
                <th>Food Name</th>
                <th>Pick Date</th>
                <th>Address</th>
                <th>City</th>
                <th>Contact Person</th>
                <th>Phone Number</th>
            </tr>
        </thead>
        <tbody>
            <% 
                // Fetch data from the `food_items` table
                try {
                    String query = "SELECT id, food_item, pick_date, address, city, contact_person, phone_number FROM food_items";
                    ps = con.prepareStatement(query);
                    rs = ps.executeQuery();
                    
                    // Iterate through the result set and display rows
                    while (rs.next()) {
            %>
                <tr>
                    <td><%= rs.getInt("id") %></td>
                    <td><%= rs.getString("food_item") %></td>
                    <td><%= rs.getString("pick_date") %></td>
                    <td><%= rs.getString("address") %></td>
                    <td><%= rs.getString("city") %></td>
                    <td><%= rs.getString("contact_person") %></td>
                    <td><%= rs.getString("phone_number") %></td>
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

<%-- Food Requests Section --%>
        <div id="foodRequestsContent" class="color hidden">
            <table border="1" style="width: 100%; border-collapse: collapse; text-align: left;">
                <thead>
                    <tr>
                        <th>Food ID</th>
                        <th>Requester Name</th>
                        <th>Requester Address</th>
                        <th>Email</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try {
                            String query = "SELECT food_id, requester_name, requester_address, email, request_status FROM food_requests";
                            ps = con.prepareStatement(query);
                            rs = ps.executeQuery();

                            while (rs.next()) {
                    %>
                        <tr>
                            <td><%= rs.getInt("food_id") %></td>
                            <td><%= rs.getString("requester_name") %></td>
                            <td><%= rs.getString("requester_address") %></td>
                            <td><%= rs.getString("email") %></td>
                            <td><%= rs.getString("request_status") %></td>
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
        
        <%-- Enquiries Section --%>
        <div id="enquiriesContent" class="color hidden">
        <table border="1" style="width: 100%; border-collapse: collapse; text-align: left;">
        <thead>
            <tr>
                <th>ID</th>
                <th>First Name</th>
                <th>Last Name</th>
                <th>Phone</th>
                <th>Email</th>
                <th>Message</th>
            </tr>
        </thead>
        <tbody>
            <%
                // Fetch data from the `contact_form` table
                try {
                    String query = "SELECT id, first_name, last_name, phone, email, message FROM contact_form";
                    ps = con.prepareStatement(query);
                    rs = ps.executeQuery();

                    // Iterate through the result set and display rows
                    while (rs.next()) {
            %>
                <tr>
                    <td><%= rs.getInt("id") %></td>
                    <td><%= rs.getString("first_name") %></td>
                    <td><%= rs.getString("last_name") %></td>
                    <td><%= rs.getString("phone") %></td>
                    <td><%= rs.getString("email") %></td>
                    <td><%= rs.getString("message") %></td>
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

<!-- Reports Section -->
<div id="reportsContent" class="color hidden">
    <h3>Select Date Range</h3>
    <form method="POST" action="admin.jsp">
        <label for="startDate">Start Date: </label>
        <input type="date" id="startDate" name="startDate" required>
        
        <label for="endDate">End Date: </label>
        <input type="date" id="endDate" name="endDate" required>
        
        <button type="submit">Generate Report</button>
    </form>
    
    <%-- Display report table here --%>
    <div id="reportResult">
        <table border="1" style="width: 100%; border-collapse: collapse; text-align: left;">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Food Name</th>
                    <th>Pick Date</th>
                    <th>Address</th>
                    <th>Contact Person</th>
                    <th>Phone Number</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    String startDate = request.getParameter("startDate");
                    String endDate = request.getParameter("endDate");
                    if (startDate != null && endDate != null) {
                        // Query to fetch food donations between startDate and endDate
                        try {
                            String query = "SELECT id, food_item, pick_date, address, city, contact_person, phone_number FROM food_items WHERE pick_date BETWEEN ? AND ?";
                            ps = con.prepareStatement(query);
                            ps.setString(1, startDate);
                            ps.setString(2, endDate);
                            rs = ps.executeQuery();
                            
                            // Display results if there are any donations
                            while (rs.next()) {
                %>
                            <tr>
                                <td><%= rs.getInt("id") %></td>
                                <td><%= rs.getString("food_item") %></td>
                                <td><%= rs.getString("pick_date") %></td>
                                <td><%= rs.getString("address") %></td>
                                <td><%= rs.getString("city") %></td>
                                <td><%= rs.getString("contact_person") %></td>
                                <td><%= rs.getString("phone_number") %></td>
                            </tr>
                <% 
                            }
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                %>
            </tbody>
        </table>
    </div>
</div>

<%-- Search Listed Food Section --%>
<div id="searchFoodContent" class="color hidden">
    <form method="POST" action="admin.jsp">
        <label for="foodSearch">Food Name: </label>
        <input type="text" id="foodSearch" name="foodSearch" required>
        <button type="submit">Search</button>
    </form>
    
    <%-- Display search results if food is found --%>
    <div id="searchResult">
        <table border="1" style="width: 100%; border-collapse: collapse; text-align: left;">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Food Name</th>
                    <th>Pick Date</th>
                    <th>Address</th>
                    <th>Contact Person</th>
                    <th>Phone Number</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    String foodSearch = request.getParameter("foodSearch");
                    if (foodSearch != null && !foodSearch.isEmpty()) {
                        try {
                            String searchQuery = "SELECT id, food_item, pick_date, address, city, contact_person, phone_number FROM food_items WHERE food_item LIKE ?";
                            ps = con.prepareStatement(searchQuery);
                            ps.setString(1, "%" + foodSearch + "%");
                            rs = ps.executeQuery();
                            
                            if (!rs.next()) {
                                out.println("<tr><td colspan='6'>No results found</td></tr>");
                            } else {
                                do {
                %>
                                    <tr>
                                        <td><%= rs.getInt("id") %></td>
                                        <td><%= rs.getString("food_item") %></td>
                                        <td><%= rs.getString("pick_date") %></td>
                                        <td><%= rs.getString("address") %></td>
                                        <td><%= rs.getString("contact_person") %></td>
                                        <td><%= rs.getString("phone_number") %></td>
                                    </tr>
                <% 
                                } while (rs.next());
                            }
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                %>
            </tbody>
        </table>
    </div>
</div>

    
    </div>

<script>
function showDashboard() {
    document.getElementById('dashboardContent').classList.remove('hidden');
    document.getElementById('listedFoodContent').classList.add('hidden');
    document.getElementById('foodRequestsContent').classList.add('hidden');
    document.getElementById('enquiriesContent').classList.add('hidden');
    document.getElementById('reportsContent').classList.add('hidden');
    document.getElementById('searchFoodContent').classList.add('hidden');
    document.getElementById('pageTitle').innerText = 'Admin Dashboard';
}

function showListedFood() {
    document.getElementById('dashboardContent').classList.add('hidden');
    document.getElementById('listedFoodContent').classList.remove('hidden');
    document.getElementById('foodRequestsContent').classList.add('hidden');
    document.getElementById('enquiriesContent').classList.add('hidden');
    document.getElementById('reportsContent').classList.add('hidden');
    document.getElementById('searchFoodContent').classList.add('hidden');
    document.getElementById('pageTitle').innerText = 'Listed Food';
}

function showFoodRequests() {
    document.getElementById('dashboardContent').classList.add('hidden');
    document.getElementById('listedFoodContent').classList.add('hidden');
    document.getElementById('foodRequestsContent').classList.remove('hidden');
    document.getElementById('enquiriesContent').classList.add('hidden');
    document.getElementById('reportsContent').classList.add('hidden');
    document.getElementById('searchFoodContent').classList.add('hidden');
    document.getElementById('pageTitle').innerText = 'Food Requests';
}

function showEnquiries() {
    document.getElementById('dashboardContent').classList.add('hidden');
    document.getElementById('listedFoodContent').classList.add('hidden');
    document.getElementById('foodRequestsContent').classList.add('hidden');
    document.getElementById('enquiriesContent').classList.remove('hidden'); // Show Enquiries section
    document.getElementById('reportsContent').classList.add('hidden');
    document.getElementById('searchFoodContent').classList.add('hidden');
    document.getElementById('pageTitle').innerText = 'Enquiries';
}

function showReports() {
    document.getElementById('dashboardContent').classList.add('hidden');
    document.getElementById('listedFoodContent').classList.add('hidden');
    document.getElementById('foodRequestsContent').classList.add('hidden');
    document.getElementById('enquiriesContent').classList.add('hidden');
    document.getElementById('reportsContent').classList.remove('hidden');
    document.getElementById('searchFoodContent').classList.add('hidden');
    document.getElementById('pageTitle').innerText = 'Reports';
}

function showSearchListedFood() {
    document.getElementById('dashboardContent').classList.add('hidden');
    document.getElementById('listedFoodContent').classList.add('hidden');
    document.getElementById('foodRequestsContent').classList.add('hidden');
    document.getElementById('enquiriesContent').classList.add('hidden');
    document.getElementById('reportsContent').classList.add('hidden');    
    document.getElementById('searchFoodContent').classList.remove('hidden'); // Show search section
    document.getElementById('pageTitle').innerText = 'Search Listed Food';
}

    </script>
</body>
</html>