import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get profile_name and password from the form
        String profile_name = request.getParameter("profile_name");
        String password = request.getParameter("password");

        // Database connection parameters
        String jdbcUrl = "jdbc:mysql://localhost:3306/whattodo"; // Replace with your database details
        String dbUser = "root"; // Replace with your DB user
        String dbPassword = "Sam26102004#"; // Replace with your DB password

        // Query to check if user exists and get their image URL
        String query = "SELECT image_url FROM users WHERE profile_name = ? AND password = ?";

        try {
            // Load MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            // Create connection to the database
            Connection connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

            // Create a prepared statement
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, profile_name);
            statement.setString(2, password);
            
            // Execute query
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                // Login successful, create a session
                HttpSession session = request.getSession();
                session.setAttribute("profile_name", resultSet.getString("profile_name")); // Get image URL from result set
                session.setAttribute("image_url", resultSet.getString("image_url")); // Get image URL from result set
                
                // Redirect to welcome page or dashboard
                response.sendRedirect("PostServlet");
            } else {
                // Login failed, return to login page with error message
                request.setAttribute("errorMessage", "Invalid profile_name or password.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }

            // Close connection
            connection.close();

        } catch (Exception e) {
            e.printStackTrace();
            // Handle exceptions or errors
            request.setAttribute("errorMessage", "Database connection error.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
