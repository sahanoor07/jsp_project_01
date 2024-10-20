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
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/UserProfileServlet")
public class UserProfileServlet extends HttpServlet {

    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/whattodo";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "Sam26102004#"; // Use your MySQL password here

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        response.setContentType("text/html");

        // Get the user's session
        HttpSession session = request.getSession();
        String profile_name = (String) session.getAttribute("profile_name");

        // If session does not have profile_name, return to login page
        if (profile_name == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);

            // Query to retrieve user details
            String sqlUser = "SELECT profile_name, email FROM users WHERE profile_name = ?";
            stmt = conn.prepareStatement(sqlUser);
            stmt.setString(1, profile_name);
            rs = stmt.executeQuery();

            String profileName = null;
            String email = null;

            if (rs.next()) {
                profile_name = rs.getString("profile_name");
                email = rs.getString("email");
            } else {
                out.print("<h3 style='color:red'>User not found</h3>");
                return; // Exit if user is not found
            }

            // Pass the user details as attributes to the JSP page
            request.setAttribute("profile_name", profileName);
            request.setAttribute("email", email);

            // Now, retrieve the user's posts from the posts table
            List<Post> postList = new ArrayList<>();
            String sql = "SELECT * FROM posts";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, profile_name);
            rs = stmt.executeQuery();

            // Iterate over the result set and create Post objects
            while (rs.next()) {
                Post post = new Post();
                post.setProfileName(rs.getString("profile_name"));
                post.setPostTime(rs.getTimestamp("post_time"));
                post.setPostTitle(rs.getString("post_title"));
                post.setPostImageUrl(rs.getString("post_image_url"));
                post.setUpvotes(rs.getInt("upvotes"));
                post.setCommunityIconUrl(rs.getString("community_icon_url"));
                postList.add(post);
            }

            // Set the post list as a request attribute
            request.setAttribute("postList", postList);

            // Forward the request to the user profile JSP page
            request.getRequestDispatcher("userprofile.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            out.print("<h3 style='color:red'>Exception occurred: " + e.getMessage() + "</h3>");
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
