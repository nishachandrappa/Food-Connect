<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, jakarta.servlet.http.*, jakarta.servlet.*" %>
<%
    // Get form data from the request
    String firstName = request.getParameter("firstName");
    String lastName = request.getParameter("lastName");
    String phone = request.getParameter("phone");
    String email = request.getParameter("email");
    String message = request.getParameter("message");

    // Database connection details
     Class.forName("com.mysql.cj.jdbc.Driver");
    String url = "jdbc:mysql://localhost:3306/food"; // Your database URL
    String user = "root"; // Your database username
    String password = "nischi@123"; // Your database password

    // JDBC variables
    Connection con = null;
    PreparedStatement ps = null;

    try {
        // Establish database connection
        con = DriverManager.getConnection(url, user, password);

        // SQL query to insert data into the contact_form table
        String insertQuery = "INSERT INTO contact_form (first_name, last_name, phone, email, message) VALUES (?, ?, ?, ?, ?)";

        // Prepare statement
        ps = con.prepareStatement(insertQuery);

        // Set the parameters for the query
        ps.setString(1, firstName);
        ps.setString(2, lastName);
        ps.setString(3, phone);
        ps.setString(4, email);
        ps.setString(5, message);

        // Execute the insert query
        int result = ps.executeUpdate();

        // Check if the data was inserted successfully
        if (result > 0) {
            out.println("<h3>Your message has been submitted successfully!</h3>");
        } else {
            out.println("<h3>There was an error submitting your message. Please try again.</h3>");
        }
    } catch (SQLException e) {
        // Handle SQL exceptions
        e.printStackTrace();
        out.println("<h3>Error: " + e.getMessage() + "</h3>");
    } finally {
        // Close the database resources
        try {
            if (ps != null) ps.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
