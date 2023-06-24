<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
  <title>Login Result</title>
</head>
<body>
  <%  
    String usr = request.getParameter("username");
    String pswd = request.getParameter("password");

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
  <h3><%= stato %></h3>
</body>
</html>
