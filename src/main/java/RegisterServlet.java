import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

/**
 *
 * @author sahan
 */
@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/whattodo";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "Sam26102004#"; // Replace with your password

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String profile_name = request.getParameter("profile_name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String imageUrl = request.getParameter("image_url"); // Corrected line

        PrintWriter out = response.getWriter();

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);

            // Insert the user details into the 'users' table
            String sql = "INSERT INTO users (profile_name, email, password, image_url) VALUES (?, ?, ?, ?)"; // Corrected SQL line
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, profile_name);
            stmt.setString(2, email);
            stmt.setString(3, password);
            stmt.setString(4, imageUrl);

            // Ideally, you should hash the password before storing it
            // int count = stmt.executeUpdate(); // Uncomment this line
            int count = stmt.executeUpdate();
            response.setContentType("text/html");
            if (count > 0) {
                response.sendRedirect("PostServlet");
            } else {
                out.print("<h3 style='color:red'>Registration failed</h3>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.print("<h3 style='color:red'>An error occurred during registration. Please try again later.</h3>"); // More user-friendly message
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
