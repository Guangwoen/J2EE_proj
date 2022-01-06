package com.example.firstweb;

import java.io.*;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;

public class Database_Servlet extends HttpServlet {

    private final String driver = "com.mysql.cj.jdbc.Driver";
    private final String username = "root";
    private final String password = "ecnu451_";
    private final String url = "jdbc:mysql://localhost:3306/web";

    private Connection connection = null;
    private ResultSet resultSet = null;
    private PreparedStatement preparedStatement = null;
    private Statement statement = null;

    public void startConnection() throws IOException, SQLException, Exception {
        try {
            Class.forName(driver);
            connection = DriverManager.getConnection(url, username, password);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void closeConnection() throws IOException, SQLException, Exception {
        if(resultSet != null) {
            try {
                resultSet.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if(preparedStatement != null) {
            try {
                preparedStatement.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if(statement != null) {
            try {
                statement.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        if(connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    /* Just for searching. */
    public ResultSet doCheck(String sqlStatement, String attr) throws IOException, SQLException, Exception{
        try {
            statement = connection.createStatement();
            return statement.executeQuery(sqlStatement); // Different.
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    /* For adding, deleting and revising data. */
    public int doApplication(String sqlStatement, String attr) throws IOException, SQLException, Exception {
        try {
            statement = connection.createStatement();
            return statement.executeUpdate(sqlStatement); // Different.
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
}
