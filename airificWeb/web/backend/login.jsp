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
        
    c = null;
    db = "127.0.0.1:3306";
    schema = "airific";
    utente = "lis";
    psw = "password1234";
       
    try {
        c = DriverManager.getConnection("jdbc:mysql://"+db+"/"+schema, utente, psw);
        s = c.createStatement();
         
        select = "SELECT * FROM autentificazioni WHERE email='" + usr + "' AND pswd='" + pswd + "';";
        p = c.prepareStatement(select);
        p.execute();
            
        rs = p.getResultSet();
            
        if (rs.next()) {
            response.sendRedirect("success.html");
        } else {
            response.sendRedirect("error.html");
        }
            
        c.close();
    } catch (SQLException ex) {
        System.out.println("Errore : " + ex.getMessage());
    }
  %> 
</body>
</html>
