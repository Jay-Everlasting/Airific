<%-- 
    Document   : lista
    Created on : 31 May 2023, 20:40:42
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" href="../styles/lista.css" />
        <link rel="stylesheet" href="../styles/style.css" />
        <link rel="stylesheet" href="../styles/general.css" />
        <title>Airific🌬️ - Stanze</title>
        <script
            type="module"
            src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"
        ></script>
        <script
            nomodule
            src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"
        ></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    </head>
    <body class="c">
        <%
        String user = (String) session.getAttribute("userC");
        String pswd = (String) session.getAttribute("pswdC");
            
        Connection c;
        Statement s;
        PreparedStatement p;
        ResultSet rsA, rsS;
        String db, schema, utente, psw, select;
        String ambiente, idS, iconArt, nomeS, nomeU;        

        c = null;
        db = "127.0.0.1:3306";
        schema = "airific";
        utente = "lis";
        psw = "password1234";
        nomeU = "";

        try {
            Class.forName("com.mysql.jdbc.Driver"); 
            c = DriverManager.getConnection("jdbc:mysql://"+db+"/"+schema, utente, psw);
            s = c.createStatement();
            
        %>
          <div>
            <header class="header">
              <div class="menu-titolo">
                <a href="index.html"><h1 class="titolo">AIRIFC</h1></a>
              </div>
              <div class="icone">
                <a href="index.html">
                  <ion-icon
                    class="menu-icon settings"
                    name="return-down-back-outline"
                  ></ion-icon>
                </a>
                <a href="#">
                  <ion-icon
                    class="menu-icon settings"
                    name="settings-outline"
                  ></ion-icon>
                </a>
              </div>
            </header>
            <div class="rett1"></div>
          </div>
          <main class="contenitore">
        <%
            select = "SELECT utenti.nome FROM (autentificazioni, utenti) "
                    + "WHERE autentificazioni.email='" + user + "' AND autentificazioni.pswd='" + pswd + "' "
                    + "AND autentificazioni.id_utente=utenti.id;";
            p = c.prepareStatement(select);
            p.execute();
            rsA = p.getResultSet();
            while(rsA.next()) {
                nomeU = rsA.getString("nome");
            }
        %>
            <h2 class="list-title">Seleziona la stanza che vuoi osservare <%= nomeU %> 👇🏼</h2>
            <form action="stanza.jsp">
                <div class="ambienti">
        <%

            select = "SELECT ambienti.nome FROM (ambienti, autentificazioni) "
            + "WHERE autentificazioni.email='" + user + "' AND autentificazioni.pswd='" + pswd + "' "
            + "AND autentificazioni.id_utente=ambienti.id_utenti;";
            p = c.prepareStatement(select);
            p.execute();
            rsA = p.getResultSet();

            while (rsA.next()) {
                ambiente = rsA.getString("nome");
            %>
                <div class="ambiente">        
                    <div class="amb">
                        <p class="tit-amb"><%= ambiente %></p>
                        <div class="linea-amb"></div>
                    </div>
                    <div class="stanze">
            <%
                select = "SELECT stanze.id, stanze.iconArt, stanze.nome FROM (stanze, autentificazioni) "
                        + "WHERE autentificazioni.email='" + user + "' AND autentificazioni.pswd='" + pswd + "' "
                        + "AND autentificazioni.id_utente=stanze.id_utente AND stanze.id_ambiente='" + ambiente + "';";
                p = c.prepareStatement(select);
                p.execute();
                rsS = p.getResultSet();
                while (rsS.next()) {
                    idS = rsS.getString("id");
                    iconArt = rsS.getString("iconArt");
                    nomeS = rsS.getString("nome");
                    %>
                    <div class="stanza">
                      <%
                      out.print("<img class='st-icon' src='" + iconArt + "' alt='" + nomeS + "'>");
                      out.print("<input type='number' name='stanza13' value='" + idS + "' style='display:none;' > ");
                      out.print("<input type='submit' class='btn-st' value='" + nomeS + "' name='stanza11'/>");
                      %>
                    </div>
                    <%
                }
                %>
                    </div>
                </div>    
                <%
            }
            
            session.setAttribute("userC", user);
            session.setAttribute("pswdC", pswd);

            c.close();
        } catch (SQLException ex) {
            System.out.println("Errore : " + ex.getMessage());
        } catch (Exception ex) {
            System.out.println("Errore : " + ex.getMessage());
        }
        %>
                </div>
            </form>
        </main>
    </body>
</html>
