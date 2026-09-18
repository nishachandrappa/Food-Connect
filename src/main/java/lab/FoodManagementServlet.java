package lab;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
@WebServlet("/FoodManagementServlet")
public class FoodManagementServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/food";
    private static final String DB_USERNAME = "root";
    private static final String DB_PASSWORD = "nischi@123";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html");
        String action = request.getParameter("action");

        if (action == null) {
            response.getWriter().write("No action specified for GET method.");
            return;
        }
        if ("completeRequest".equals(action)) {
            completeFoodRequest(request);
            response.sendRedirect("donor.jsp");
        }
        else if ("rejectRequest".equals(action)) {
            rejectFoodRequest(request);
            response.sendRedirect("donor.jsp");
        }

        switch (action) {
             case "addFood":
                addFoodItem(request,response);
            break;
            case "viewFoodItems":
                viewFoodItems(request, response);
                break;
            case "searchRequests":
                searchFoodRequests(request, response);
                break;
            case "deleteFood":
                deleteFoodItem(request);
                response.sendRedirect(request.getContextPath() + "/donor.jsp");
                break;
            case "updateFood":
                int id = Integer.parseInt(request.getParameter("id"));
                response.sendRedirect(request.getContextPath() + "/update.jsp?id=" + id);
                break;
            case "completeRequest":
                completeFoodRequest(request);
                break;
            case "rejectRequest":
                rejectFoodRequest(request);
                break;
            default:
                response.getWriter().write("Action '" + action + "' is not supported via GET method.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html");

        String action = request.getParameter("action");
        if (action != null) {
            switch (action) {
                case "addFood":
                    addFoodItem(request,response);
                    break;
                case "updateFood":
                    updateFoodItem(request);
                    break;
                
                case "addRequest":
                    addFoodRequest(request);
                    break;
                case "completeRequest":
                    completeFoodRequest(request);
                    break;
               case "rejectRequest":
                    rejectFoodRequest(request);
                    break;
                case "searchRequests":
                    searchFoodRequests(request, response);
                    break;
            }
        }

        response.sendRedirect(request.getContextPath() + "/donor.jsp");
    }

    private void addFoodItem(HttpServletRequest request, HttpServletResponse response) {
    	    String foodItem = request.getParameter("foodItem");
    	    String description = request.getParameter("description");
    	    String pickDate = request.getParameter("pickDate");
    	    String address = request.getParameter("address");
    	    String city = request.getParameter("city");
    	    String contactPerson = request.getParameter("contactPerson");
    	    String phoneNumber = request.getParameter("phoneNumber");

    	    try (Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/food", "root", "nischi@123")) {
    	        PreparedStatement statement = connection.prepareStatement(
    	            "INSERT INTO food_items (food_item, description, pick_date, address, city, contact_person, phone_number) VALUES (?, ?, ?, ?, ?, ?, ?)");
    	        statement.setString(1, foodItem);
    	        statement.setString(2, description);
    	        statement.setDate(3, Date.valueOf(pickDate));
    	        statement.setString(4, address);
    	        statement.setString(5, city);
    	        statement.setString(6, contactPerson);
    	        statement.setString(7, phoneNumber);
    	        int rowsInserted = statement.executeUpdate();

    	        if (rowsInserted > 0) {
    	            request.setAttribute("message", "Food item added successfully!");
    	            request.getRequestDispatcher("list-food-detail.jsp").forward(request, response);
    	        }
    	    } catch (SQLException e){
    	        e.printStackTrace();
    	    }
    	    catch (ServletException e){
    	        e.printStackTrace();
    	    }
    	    catch (IOException e){
    	        e.printStackTrace();
    	    }
    	    
    	}

    private void updateFoodItem(HttpServletRequest request) {
        int id = Integer.parseInt(request.getParameter("id"));
        String foodItem = request.getParameter("foodItem");
        String description = request.getParameter("description");
        String pickDate = request.getParameter("pickDate");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String contactPerson = request.getParameter("contactPerson");
        String phoneNumber = request.getParameter("phoneNumber");

        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD)) {
            PreparedStatement statement = connection.prepareStatement(
                "UPDATE food_items SET food_item = ?, description = ?, pick_date = ?, address = ?, city = ?, contact_person = ?, phone_number = ? WHERE id = ?");
            statement.setString(1, foodItem);
            statement.setString(2, description);
            statement.setDate(3, Date.valueOf(pickDate));
            statement.setString(4, address);
            statement.setString(5, city);
            statement.setString(6, contactPerson);
            statement.setString(7, phoneNumber);
            statement.setInt(8, id);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void deleteFoodItem(HttpServletRequest request) {
        int id = Integer.parseInt(request.getParameter("id"));

        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD)) {
            PreparedStatement statement = connection.prepareStatement("DELETE FROM food_items WHERE id = ?");
            statement.setInt(1, id);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void addFoodRequest(HttpServletRequest request) {
        String foodName = request.getParameter("foodName");
        String requesterName = request.getParameter("requesterName");
        String requesterEmail = request.getParameter("requesterEmail");
        String requesterPhone = request.getParameter("requesterPhone");

        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD)) {
            PreparedStatement statement = connection.prepareStatement(
                "INSERT INTO food_requests (food_name, requester_name, requester_email, requester_phone) VALUES (?, ?, ?, ?)");
            statement.setString(1, foodName);
            statement.setString(2, requesterName);
            statement.setString(3, requesterEmail);
            statement.setString(4, requesterPhone);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void completeFoodRequest(HttpServletRequest request) {
        int id = Integer.parseInt(request.getParameter("id"));
        boolean isUpdated = false;

        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD)) {
            PreparedStatement statement = connection.prepareStatement(
                "UPDATE food_requests SET request_status = 'Completed' WHERE food_id = ?");
            statement.setInt(1, id);
            int rowsAffected = statement.executeUpdate();
            if (rowsAffected > 0) {
                isUpdated = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        if (isUpdated) {
            request.getSession().setAttribute("message", "Request has been marked as Completed successfully.");
        } else {
            request.getSession().setAttribute("message", "Failed to mark the request as Completed.");
        }
        
    }

    private void rejectFoodRequest(HttpServletRequest request) {
        int id = Integer.parseInt(request.getParameter("id"));
        boolean isUpdated = false;

        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD)) {
            PreparedStatement statement = connection.prepareStatement(
                "UPDATE food_requests SET request_status = 'Rejected' WHERE food_id = ?");
            statement.setInt(1, id);
            int rowsAffected = statement.executeUpdate();
            if (rowsAffected > 0) {
                isUpdated = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        if (isUpdated) {
            request.getSession().setAttribute("message", "Request has been marked as Rejected successfully.");
        } else {
            request.getSession().setAttribute("message", "Failed to mark the request as Rejected.");
        }
    }


    private void searchFoodRequests(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String requesterName = request.getParameter("requesterName");

        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD)) {
            PreparedStatement statement = connection.prepareStatement(
                "SELECT * FROM food_requests WHERE requester_name LIKE ?");
            statement.setString(1, "%" + requesterName + "%");
            ResultSet resultSet = statement.executeQuery();

            response.getWriter().write("<html><body>");
            response.getWriter().write("<h1>Food Requests</h1>");
            response.getWriter().write("<table border='1'>");
            response.getWriter().write("<tr><th>ID</th><th>Requester Name</th><th>Requester Address</th><th>Email</th><th>Status</th></tr>");

            if (!resultSet.isBeforeFirst()) { // Check for empty results
                response.getWriter().write("<tr><td colspan='5'>No requests found for the given name.</td></tr>");
            } else {
                while (resultSet.next()) {
                    response.getWriter().write("<tr>");
                    response.getWriter().write("<td>" + resultSet.getInt("food_id") + "</td>");
                    response.getWriter().write("<td>" + resultSet.getString("requester_name") + "</td>");
                    response.getWriter().write("<td>" + resultSet.getString("requester_address") + "</td>");
                    response.getWriter().write("<td>" + resultSet.getString("email") + "</td>");
                    response.getWriter().write("<td>" + resultSet.getString("request_status") + "</td>");
                    response.getWriter().write("</tr>");
                }
            }
            response.getWriter().write("</table>");
            response.getWriter().write("</body></html>");
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().write("Error retrieving food requests: " + e.getMessage());
        }
    }

    private void viewFoodItems(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD)) {
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery("SELECT * FROM food_items");

            response.getWriter().write("<html><body>");
            response.getWriter().write("<h1>Food Items</h1>");
            response.getWriter().write("<table border='1'>");
            response.getWriter().write("<tr><th>ID</th><th>Food Item</th><th>Description</th><th>Pick Date</th><th>Address</th><th>City</th><th>Contact Person</th><th>Phone Number</th></tr>");

            while (resultSet.next()) {
                response.getWriter().write("<tr>");
                response.getWriter().write("<td>" + resultSet.getInt("id") + "</td>");
                response.getWriter().write("<td>" + resultSet.getString("food_item") + "</td>");
                response.getWriter().write("<td>" + resultSet.getString("description") + "</td>");
                response.getWriter().write("<td>" + resultSet.getDate("pick_date") + "</td>");
                response.getWriter().write("<td>" + resultSet.getString("address") + "</td>");
                response.getWriter().write("<td>" + resultSet.getString("city") + "</td>");
                response.getWriter().write("<td>" + resultSet.getString("contact_person") + "</td>");
                response.getWriter().write("<td>" + resultSet.getString("phone_number") + "</td>");
                response.getWriter().write("</tr>");
            }
            response.getWriter().write("</table>");
            response.getWriter().write("</body></html>");
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().write("Error retrieving food items: " + e.getMessage());
        }
    }
}

