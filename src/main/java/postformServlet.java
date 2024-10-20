import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession; // Import HttpSession
import java.io.PrintWriter;

@WebServlet("/postformServlet")
public class postformServlet extends HttpServlet {

    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/whattodo";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "Sam26102004#"; // Make sure to use a secure password

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter(); // Initialize PrintWriter

        // Retrieve the session
        HttpSession session = request.getSession();
        String profile_name = (String) session.getAttribute("profile_name"); // Get profile_name from session
        String imageUrl = (String) session.getAttribute("image_url"); // Get profile_name from session

        // Retrieve post details from the request
        String postTitle = request.getParameter("post_title");
        String postImageUrl = request.getParameter("post_image_url");
        String postContent = request.getParameter("content");
        String postCommunity = request.getParameter("community");

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
            stmt = conn.prepareStatement(
                "INSERT INTO posts (profile_name, post_time, post_title, post_image_url, upvotes, community_icon_url, content, community) " +
                "VALUES (?, CURRENT_TIMESTAMP, ?, ?, 0, ?, ?, ?)"
            );
            
            stmt.setString(1, profile_name); // Use the profile_name from the session
            stmt.setString(2, postTitle);
            stmt.setString(3, postImageUrl);
            stmt.setString(4, imageUrl);
            stmt.setString(5, postContent);
            stmt.setString(6, postCommunity);
            
            int count = stmt.executeUpdate();
            response.setContentType("text/html");
            if (count > 0) {
                out.print("<h3 style='color:green'>Post updated successfully</h3>");
            } else {
                out.print("<h3 style='color:red'>Post not updated</h3>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("text/html");
            out.print("<h3 style='color:red'>Exception occurred: " + e.getMessage() + "</h3>");
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

