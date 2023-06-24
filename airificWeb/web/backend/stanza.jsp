<%-- 
    Document   : stanza
    Created on : 31 May 2023, 20:41:00
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <%
        String user = (String) session.getAttribute("userC");
        String pswd = (String) session.getAttribute("pswdC");

        // Database connection details
        Connection c;
        Statement s;
        PreparedStatement p;
        ResultSet rs;
        String db, schema, utente, psw, select;
        String stato = "loding...";

        c = null;
        db = "127.0.0.1:3306";
        schema = "airific";
        utente = "lis";
        psw = "password1234";

        try {
            Class.forName("com.mysql.jdbc.Driver"); 
            c = DriverManager.getConnection("jdbc:mysql://"+db+"/"+schema, utente, psw);
            s = c.createStatement();

            select = "SELECT * FROM autentificazioni WHERE email='" + usr + "' AND pswd='" + pswd + "';";
            p = c.prepareStatement(select);
            p.execute();

            rs = p.getResultSet();

            if (rs.next()) {
                String userC = usr;
                session.setAttribute("userC", userC);
                String pswdC = pswd;
                session.setAttribute("pswdC", pswdC);

                response.sendRedirect("lista.jsp");
            } else {
                response.sendRedirect("error.html");
            }

            c.close();
        } catch (SQLException ex) {
            stato = "Errore : " + ex.getMessage();
        } catch (Exception ex) {
            stato = "Errore : " + ex.getMessage();
        }

        
        
        %>
    </body>
</html>
