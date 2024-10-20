
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
@WebServlet("/PostServlet")
public class PostServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/whattodo";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "Sam26102004#";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            // Load MySQL driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);

            // Query to fetch all posts
            String sql = "SELECT * FROM posts";
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();

            // Create a list of posts
            List<Post> postList = new ArrayList<>();

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

            // Forward to home.jsp
            request.getRequestDispatcher("/home.jsp").forward(request, response);

            

        } catch (Exception e) {
            e.printStackTrace();
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


