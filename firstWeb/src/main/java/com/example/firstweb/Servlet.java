package com.example.firstweb;

import java.io.*;
import java.rmi.server.ExportException;
import java.util.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.lang.reflect.Method;
import java.sql.*;
import com.example.firstweb.*;

public class Servlet extends HttpServlet {

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String url = request.getRequestURI();
        String methodName = url.substring(url.lastIndexOf("/") + 1, url.lastIndexOf(".")); // Get method from url.
        Method method = null;
        try {
            method = getClass().getDeclaredMethod(methodName, HttpServletRequest.class, HttpServletResponse.class);
            // 执行方法
            method.invoke(this, request, response);
        } catch (Exception e) {
            throw new RuntimeException("调用方法出错!");
        }
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        doPost(request, response);
    }

    public void SignUp(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");

        String password = request.getParameter("password_1");
        String password_c = request.getParameter("password_2");
        if(!password.equals(password_c)) {
            response.sendRedirect("signUp.jsp?incorrect=yes");
            return;
        }

        User usr = new User();
        usr.setUsername(request.getParameter("username"));
        usr.setPassword(password);
        response.setHeader("Content-Type", "text/html; charset=UTF-8");
        Database_Servlet db = new Database_Servlet();
        try{
            try {
                db.startConnection(); // Set up
            } catch (Exception e) {
                e.printStackTrace();
            }
            try {
                ResultSet resultSet = db.doCheck("select * from LOGTABLE where username='" + usr.getUsername() + "';", null);
                if(resultSet.next()) { // If this username exists.
                    response.sendRedirect("signUp.jsp?exist=yes");
                    return;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            // Put new message to database here.
            // If the username is already in database, then fail
            try {
                int affectRows = db.doApplication("insert into LOGTABLE (id, password, username) " +
                        "values " +
                        "(0 ,'" + usr.getPassword() + "','"
                        + usr.getUsername() + "');", null); // Add new user to the database.
                if(affectRows == 0) throw new Exception();
            } catch (Exception e) {
                e.printStackTrace();
            }
            // Else if success
            response.sendRedirect("main.jsp?usr=" + usr.getUsername());
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                db.closeConnection(); // Close
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    public void Login(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");

        User usr = new User();
        usr.setUsername(request.getParameter("username"));
        usr.setPassword(request.getParameter("password"));
        Database_Servlet db = new Database_Servlet();
        response.setHeader("Content-Type", "text/html; charset=UTF-8");
        try {
            try {
                db.startConnection();
            } catch (Exception e) {
                e.printStackTrace();
            }
            try {
                String statement = "select * from LOGTABLE where username='" + usr.getUsername() + "';";
                ResultSet resultSet = db.doCheck(statement, null);
                if(!resultSet.next() || !(usr.getPassword()).equals(resultSet.getString("password"))) {
                    response.sendRedirect("index.jsp?error=yes");
                    return;
                }
                // ID has normal -> user(0), super -> manager(1)
                if(resultSet.getInt("id") == 0) {
                    // User.
                    response.sendRedirect("app/main.jsp?usr=" + usr.getUsername());
                }
                else {
                    // Manager.
                    response.sendRedirect("app/manager.jsp");
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try{
                db.closeConnection();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}