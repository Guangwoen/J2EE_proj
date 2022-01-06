package com.example.firstweb;

import com.sun.javafx.tools.packager.HtmlParam;
import java.io.*;
import java.lang.reflect.Method;
import javax.print.attribute.standard.PresentationDirection;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import javax.xml.crypto.Data;
import javax.xml.transform.Result;

import com.example.firstweb.*;
import com.sun.xml.internal.bind.v2.runtime.reflect.Lister;

import java.rmi.server.ExportException;
import java.sql.*;
import java.math.*;
import java.util.Random;
import java.util.*;
import java.util.concurrent.ExecutionException;

public class Application_Servlet extends HttpServlet {

    private static String host = null; // Only one host can be online.

    public static void setHost(String s) { host = s; }

    public static String getHost() {
        return host;
    }

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

    /* Send to the manager and get a Car. */
    public void Sending(HttpServletRequest request, HttpServletResponse response) throws  IOException {
        response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");

        String sender = request.getParameter("sender");
        String receiver = request.getParameter("receiver");
        String o_number = request.getParameter("o_number"); // Sender.
        String i_number = request.getParameter("i_number"); // Receiver.
        String obj_name = request.getParameter("obj_name");
        String weight = request.getParameter("weight");
        String volume = request.getParameter("volume");

        Packet packet = new Packet("0", obj_name, sender, receiver, i_number, o_number, null, weight, volume);

        // Packet status: 0 -> 未发货, 1 -> 已发货, 2 -> 已收货
        String statement = "insert into PKTTABLE (pkt_id, status, car_number, driver, volume, weight, rp_number, sp_number, " +
                "receiver, sender, pkt_name, host) values ('" +
                getRandomID(10) + "', '0', '0', '0', '" + packet.getVolume() +
                "', '" + packet.getWeight() + "', '" + packet.getI_Phone_Number() +
                "', '" + packet.getO_phone_number() + "', '" + packet.getReceiver() +
                "', '" + packet.getSender() + "', '" + packet.getPacket_Name() +
                "','" + host + "');";
        Database_Servlet db = new Database_Servlet();
        try {
            try {
                db.startConnection();
            } catch (Exception e) {
                e.printStackTrace();
            }
            try {
                int affectRows = db.doApplication(statement, null);
                if(affectRows == 0) response.sendRedirect("main.jsp?success=0&usr=" + host); // If inserting failed.
            } catch (Exception e) {
                e.printStackTrace();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                db.closeConnection();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        response.sendRedirect("main.jsp?success=1&usr=" + getHost());
    }

    /* Just for generating packet ID. */
    private static String getRandomID(int length) {
        String var = "";
        Random rand = new Random();
        for(int i = 0; i < length; i++) {
            var += String.valueOf(rand.nextInt(10));
        }
        return var;
    }

    /* Methods for DataBase. */

    public ArrayList<Packet> getDataFromDB() throws IOException{
        Database_Servlet db = new Database_Servlet();
        //if(host == null) return null;
        try {
            try {
                db.startConnection();
            } catch (Exception e) {
                e.printStackTrace();
            }
            try {
                String statement = null;
                ResultSet resultSet = null;

                /* Do searching here. */
                if(host.equals("root")) {
                     /* 未发货 */
                     statement = "select * from PKTTABLE where status='0'";
                }else {
                    statement = "select * from  PKTTABLE where host='" + host + "';";
                }
                resultSet = db.doCheck(statement, null);

                /* Save data into a list. */
                ArrayList<Packet> data = new ArrayList<Packet>();
                while(resultSet.next()) {
                    Packet tmp = new Packet();
                    tmp.setPacket_Name(resultSet.getString("pkt_name"));
                    tmp.setSender(resultSet.getString("sender"));
                    tmp.setReceiver(resultSet.getString("receiver"));
                    tmp.setPacket_ID(resultSet.getString("pkt_id"));
                    tmp.setStatus(resultSet.getInt("status"));
                    data.add(tmp);
                }
                return data; // Return data.
            } catch (Exception e) {
                e.printStackTrace();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                db.closeConnection();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        // If the host is not root, then list all which status is 0(未发货),
        // Else, list only 'host''s packets(all status).
        return null;
    }

    public ArrayList<Car> getStaffFromDB() throws IOException {
        Database_Servlet db = new Database_Servlet();
        try {
            try {
                db.startConnection();
            } catch (Exception e) {
                e.printStackTrace();
            }
            String statement = "select * from STFTABLE";
            ResultSet rs = db.doCheck(statement, null);
            ArrayList<Car> list = new ArrayList<Car>();
            while(rs.next()) {
                Car tmp = new Car();
                tmp.setDriver(rs.getString("name"));
                tmp.setCar_Number(rs.getString("car_num"));
                tmp.setStatus(rs.getInt("status"));
                list.add(tmp);
            }
            return list;

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                db.closeConnection();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return null;
    }

    public void Setting(HttpServletRequest request, HttpServletResponse response) throws Exception {
        response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");
        Database_Servlet db = new Database_Servlet();
        String pkt_id = request.getParameter("packet_id");
        String car_number = request.getParameter("to_car_number");
        String statement_1 = "select * from PKTTABLE where pkt_id='" + pkt_id + "';";
        String statement_2 = "select * from STFTABLE where car_num='" + car_number + "';";
        try {
            try {
                db.startConnection();
            } catch (Exception e) {
                e.printStackTrace();
            }
            ResultSet rs_1 = db.doCheck(statement_1, null);
            ResultSet rs_2 = db.doCheck(statement_2, null);
            if(!rs_1.next() || !rs_2.next()) {
                request.getRequestDispatcher("manager.jsp?setting=fail").forward(request, response);
                return;
            }
            String setting_statement = "update PKTTABLE set status='1', driver='" + rs_2.getString("name")
                    + "', car_number='" + rs_2.getString("car_num") + "' where pkt_id='" + rs_1.getString("pkt_id")
                    + "';";
            String staff_statement = "update STFTABLE set status='1' where car_num='" + car_number + "';";
            int row_1 = db.doApplication(setting_statement, null);
            int row_2 = db.doApplication(staff_statement, null);

            if(row_1 == 0 || row_2 == 0) {
                request.getRequestDispatcher("manager.jsp?setting=fail").forward(request, response);
                return;
            }
            request.getRequestDispatcher("manager.jsp?setting=success").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                db.closeConnection();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    public void Receiving(HttpServletRequest request, HttpServletResponse response) throws Exception {
        response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");
        Database_Servlet db = new Database_Servlet();
        try {
            try {
                db.startConnection();
            } catch (Exception e) {
                e.printStackTrace();
            }
            String pkt_id = request.getParameter("pkt_id");
            String statement = "update PKTTABLE set status='2' where pkt_id='" + pkt_id + "';";
            int row = db.doApplication(statement, null);
            if(row == 0) {
                request.getRequestDispatcher("main.jsp?receive_set=fail").forward(request, response);
                return;
            }
            String search = "select * from PKTTABLE where pkt_id='" + pkt_id + "';";
            ResultSet rs = db.doCheck(search, null);
            if(!rs.next()) {
                request.getRequestDispatcher("main.jsp?receive_set=fail").forward(request, response);
                return;
            }
            String car_num = rs.getString("car_number");
            String statement_stf = "update STFTABLE set status='0' where car_num='" + car_num + "';";
            db.doApplication(statement_stf, null);
            request.getRequestDispatcher("main.jsp?receive_set=success").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                db.closeConnection();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    /* Methods for Staff. */
    public ResultSet staff_search(HttpServletRequest request, HttpServletResponse response) throws Exception {
        request.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");
        String info = request.getParameter("info");
        String target = null;
        if(info.length() > 5) target = "car_num";
        else target = "name";
        Database_Servlet db = new Database_Servlet();
        try {
            try {
                db.startConnection();
            } catch (Exception e) {
                e.printStackTrace();
            }
            HttpSession session = request.getSession();
            String statement = "select * from STFTABLE where " + target + "='" + info + "';";
            ResultSet rs = db.doCheck(statement, null);

            if(!rs.next()) {
                request.setAttribute("staff_data", null);
                request.getRequestDispatcher("manager.jsp?wayback=1").forward(request, response);
                return null;
            }

            Car result = new Car();
            result.setCar_Number(rs.getString("car_num"));
            result.setDriver(rs.getString("name"));
            result.setStatus(0);
            request.setAttribute("staff_data", result);
            request.getRequestDispatcher("manager.jsp?wayback=1").forward(request, response);
            return rs;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                db.closeConnection();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return null;
    }

    public int staff_add(HttpServletRequest request, HttpServletResponse response) throws Exception{
        response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");
        String name = request.getParameter("name");
        String car_num = request.getParameter("car_num");
        String statement = "insert into STFTABLE (name, car_num, status) values" +
                " ('" + name + "','" + car_num + "', 0);";
        Database_Servlet db = new Database_Servlet();
        try {
            try {
                db.startConnection();
            } catch (Exception e) {
                e.printStackTrace();
            }
            int row = db.doApplication(statement, null);
            if(row == 0) {
                request.getRequestDispatcher("manager.jsp?success=0").forward(request, response);
            }
            else {
                request.getRequestDispatcher("manager.jsp?success=1").forward(request, response);
            }
            return row;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                db.closeConnection();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return 0;
    }

    public int staff_delete(HttpServletRequest request, HttpServletResponse response) throws Exception {
        response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");
        String info = request.getParameter("info");
        String target = null;
        if(info.length() > 5) target = "car_num";
        else target = "name";
        Database_Servlet db = new Database_Servlet();
        try {
            try {
                db.startConnection();
            } catch (Exception e) {
                e.printStackTrace();
            }
            ResultSet rs = db.doCheck("select * from STFTABLE where " + target + "='" + info + "';", null);
            if(!rs.next()) {
                request.getRequestDispatcher("manager.jsp?success=2").forward(request, response);
                return 0;
            }
            String statement = "delete from STFTABLE where name='" + rs.getString("name") + "';";
            int row = db.doApplication(statement, null);
            if(row == 0) {
                request.getRequestDispatcher("manager.jsp?success=0").forward(request, response);
            }
            else {
                request.getRequestDispatcher("manager.jsp?success=1").forward(request, response);
            }
            return row;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                db.closeConnection();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return 0;
    }

    public int staff_revise(HttpServletRequest request, HttpServletResponse response) throws Exception {
        response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");
        String info = request.getParameter("info");
        String target = null;
        if(info.length() > 5) target = "car_num";
        else target = "name";
        Database_Servlet db = new Database_Servlet();
        try {
            try {
                db.startConnection();
            } catch (Exception e) {
                e.printStackTrace();
            }
            ResultSet rs = db.doCheck("select * from STFTABLE where " + target + "='" + info + "';", null);
            if(!rs.next()) {
                request.getRequestDispatcher("manager.jsp?success=2").forward(request, response);
                return 0;
            }
            String name = request.getParameter("name");
            String car_num = request.getParameter("car_num");
            String statement = "update STFTABLE set name='" + name
                    + "', car_num='" + car_num + "' where " + target + "='" + info + "';";
            int row = db.doApplication(statement, null);
            if(row == 0) {
                request.getRequestDispatcher("manager.jsp?success=0").forward(request, response);
            }
            else {
                request.getRequestDispatcher("manager.jsp?success=1").forward(request, response);
            }
            return row;
        }catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                db.closeConnection();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return 0;
    }

    /* Methods for packet. */
    public ResultSet pkt_search(HttpServletRequest request, HttpServletResponse response) throws Exception {
        response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");
        String info = request.getParameter("info");
        String target = null;
        if(info.length() == 10) target = "pkt_id";
        else target = "pkt_name";
        Database_Servlet db = new Database_Servlet();
        try {
            try {
                db.startConnection();
            } catch (Exception e) {
                e.printStackTrace();
            }
            String statement = "select * from PKTTABLE where " + target + "='" + info + "';";
            ResultSet rs = db.doCheck(statement, null);
            if(!rs.next()) {
                request.setAttribute("pkt_data", null);
                request.getRequestDispatcher("manager.jsp?wayback_=1").forward(request, response);
                return null;
            }
            Car stf = new Car();
            stf.setDriver(rs.getString("driver"));
            stf.setCar_Number(rs.getString("car_number"));
            Packet data = new Packet(rs.getString("pkt_id"), rs.getString("pkt_name"),
                    rs.getString("sender"), rs.getString("receiver"), rs.getString("rp_number"),
                    rs.getString("sp_number"), stf, rs.getString("weight"), rs.getString("volume"));
            request.setAttribute("pkt_data", data);
            request.getRequestDispatcher("manager.jsp?wayback_=1").forward(request, response);
            return rs;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                db.closeConnection();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return null;
    }

    public int pkt_add(HttpServletRequest request, HttpServletResponse response) throws Exception {
        response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");
        String sender = request.getParameter("sender");
        String receiver = request.getParameter("receiver");
        String o_number = request.getParameter("o_number"); // Sender.
        String i_number = request.getParameter("i_number"); // Receiver.
        String obj_name = request.getParameter("obj_name");
        String weight = request.getParameter("weight");
        String volume = request.getParameter("volume");

        Packet packet = new Packet("0", obj_name, sender, receiver, i_number, o_number, null, weight, volume);

        // Packet status: 0 -> 未发货, 1 -> 已发货, 2 -> 已收货
        String statement = "insert into PKTTABLE (pkt_id, status, car_number, driver, volume, weight, rp_number, sp_number, " +
                "receiver, sender, pkt_name) values ('" +
                getRandomID(10) + "', '0', '0', '0', '" + packet.getVolume() +
                "', '" + packet.getWeight() + "', '" + packet.getI_Phone_Number() +
                "', '" + packet.getO_phone_number() + "', '" + packet.getReceiver() +
                "', '" + packet.getSender() + "', '" + packet.getPacket_Name() +
                "');";
        Database_Servlet db = new Database_Servlet();
        try {
            try {
                db.startConnection();
            } catch (Exception e) {
                e.printStackTrace();
            }
            int row = db.doApplication(statement, null);
            if(row == 0) {
                request.getRequestDispatcher("manager.jsp?success=0").forward(request, response);
            }
            else {
                request.getRequestDispatcher("manager.jsp?success=1").forward(request, response);
            }
            return row;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                db.closeConnection();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return 0;
    }

    public int pkt_delete(HttpServletRequest request, HttpServletResponse response) throws Exception {
        response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");
        String info = request.getParameter("info");
        String target = null;
        if(info.length() == 10) target = "pkt_id";
        else target = "pkt_name";
        Database_Servlet db = new Database_Servlet();
        try {
            try {
                db.startConnection();
            } catch (Exception e) {
                e.printStackTrace();
            }
            String statement_check = "select * from PKTTABLE where " + target + "='" + info + "';";
            ResultSet rs = db.doCheck(statement_check, null);
            if(!rs.next()) {
                request.getRequestDispatcher("manager.jsp?success=2");
                return 0;
            }
            String statement_del = "delete from PKTTABLE where " + target + "='" + info + "';";
            int row = db.doApplication(statement_del, null);
            if(row == 0) {
                request.getRequestDispatcher("manager.jsp?success=0").forward(request, response);
            }
            else {
                request.getRequestDispatcher("manager.jsp?success=1").forward(request, response);
            }
            return row;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                db.closeConnection();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return 0;
    }

    public int pkt_revise(HttpServletRequest request, HttpServletResponse response) throws Exception {
        response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");
        String info = request.getParameter("info");
        String target = null;
        if(info.length() == 10) target = "pkt_id";
        else target = "pkt_name";
        Database_Servlet db = new Database_Servlet();
        try {
            try {
                db.startConnection();
            } catch (Exception e) {
                e.printStackTrace();
            }
            String statement_check = "select * from PKTTABLE where " + target + "='" + info + "';";
            ResultSet rs = db.doCheck(statement_check, null);
            if(!rs.next()) {
                request.getRequestDispatcher("manager.jsp?success=2").forward(request, response);
                return 0;
            }
            String sender = request.getParameter("sender");
            String receiver = request.getParameter("receiver");
            String o_number = request.getParameter("o_number"); // Sender.
            String i_number = request.getParameter("i_number"); // Receiver.
            String obj_name = request.getParameter("obj_name");
            String weight = request.getParameter("weight");
            String volume = request.getParameter("volume");
            String statement = "update PKTTABLE set sender='" + sender + "', receiver='" + receiver + "', sp_number='" + o_number
                    + "', rp_number='" + i_number + "', pkt_name='" + obj_name + "', weight='" + weight + "', volume='" + volume + "' where "
                    + target + "='" + info + "';";
            int row = db.doApplication(statement, null);
            if(row == 0) {
                request.getRequestDispatcher("manager.jsp?success=0").forward(request, response);
            }
            else {
                request.getRequestDispatcher("manager.jsp?success=1").forward(request, response);
            }
            return row;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                db.closeConnection();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return 0;
    }
}
