<%-- 
    Document   : stanza
    Created on : 31 May 2023, 20:41:00
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" href="../styles/general.css" />
        <link rel="stylesheet" href="../styles/camera.css" />
        <title>Airific🌬️ - Homepage</title>
        <script
          type="module"
          src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"
        ></script>
        <script
          nomodule
          src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"
        ></script>
    </head>
    <body>
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
        <main class="content">       
        <%
        //String user = (String) session.getAttribute("userC");
        //String pswd = (String) session.getAttribute("pswdC");
        String nomeStanza = request.getParameter("stanza13");
        Integer nomeSint = null;
        nomeSint = Integer.valueOf(nomeStanza);

        // Database connection details
        Connection c;
        Statement s;
        PreparedStatement p;
        ResultSet rs;
        ResultSetMetaData col;
        String db, schema, utente, psw, select;
        String nomeS, datiCol, temp, hu, co, co2, tol, amm, acet, dataDa, dataFino, oreDa, oreFino, img;
        String stato = "";

        c = null;
        db = "127.0.0.1:3306";
        schema = "airific";
        utente = "lis";
        psw = "password1234";
        nomeS = "";
        img = "";
        dataDa = "";
        dataFino = "";
        oreDa = "";
        oreFino = "";

        try {
            Class.forName("com.mysql.jdbc.Driver"); 
            c = DriverManager.getConnection("jdbc:mysql://"+db+"/"+schema, utente, psw);
            s = c.createStatement();

            // REQUEST DEL NOME DELLA CAMERA
            select = "SELECT nome,immagine FROM stanze WHERE id=" + nomeSint + ";";
            p = c.prepareStatement(select);
            p.execute();

            rs = p.getResultSet(); 
            while (rs.next()) {
                nomeS = rs.getString("nome");
                img = rs.getString("immagine");
            }           
        %>
                    <div class="tit-camera">
                        <h1 class="titoli"><%= nomeS %></h1>
                        <ion-icon class="settings" name="eye-outline"></ion-icon>
                    </div>
                    <form action="stanza.jsp">
                        <div class="dettagli">
                          <div class="field-elements elementi">
        <%
            out.print("<input type='number' name='stanza13' value='" + nomeStanza + "' style='display:none;' > ");
        %>
                            <label class="input-title">Quali dati vuoi visualizzare</label>
                            <select id="sel-gas" name="parm-grafico" class="camera-inputs">
                                <option value="">--seleziona--</option>
        <%           
            // REQUEST DI DATI PER LA LISTA DI COLONNE
            select = "SELECT temperatura,umidita,co,co2,toluen,ammonio,acetone FROM analisi WHERE id_stanza=" + nomeSint + ";";
            p = c.prepareStatement(select);
            p.execute();

            rs = p.getResultSet();
            col = p.getMetaData();
            
            for (int i = 1; i<= col.getColumnCount(); i++) {
                datiCol = col.getColumnName(i);
                out.print("<option value='" + datiCol + "'>" + datiCol + "</option>");
            } 

            // REQUEST PER DATA E ORA
            select = "SELECT MAX(dataA), MAX(timeA), MIN(dataA), MIN(timeA) FROM analisi WHERE id_stanza=" + nomeSint + ";";
            p = c.prepareStatement(select);
            p.execute();

            rs = p.getResultSet();
          
            while (rs.next()) {
                dataFino = rs.getString("MAX(dataA)");
                oreFino = rs.getString("MAX(timeA)");
                dataDa = rs.getString("MIN(dataA)");
                oreDa = rs.getString("MIN(timeA)");
            }
            
            c.close();
            } catch (SQLException ex) {
                stato = "Errore : " + ex.getMessage();
            } catch (Exception ex) {
                stato = "Errore : " + ex.getMessage();
            }
        %>
                    </select>
                </div>
                <div class="field-elements grafico">
                    <label class="input-title">Tipo di grafico</label>
                    <select id="sel-grafico" name="grafico" class="camera-inputs">
                        <option value="">--seleziona--</option>
                        <option value="bar">Barre</option>
                        <option value="line">Linea</option>
                    </select>
                </div>
                <div class="field-elements time">
                    <label class="input-title">Da:</label>
        <%
        out.print("<input type='datetime-local' value='" + dataDa + "T" + oreDa + "' max='" + dataFino + "T" + oreFino + "' min='" + dataDa + "T" + oreDa + "' id='meeting-time' name='locDa' class='camera-inputs date-input' id='sel-data-inizio' />");            
        %>                    
                </div>
                <div class="field-elements time">
                    <label class="input-title">Fino:</label>
        <%
        out.print("<input type='datetime-local' value='" + dataFino + "T" + oreFino + "' max='" + dataFino + "T" + oreFino + "' min='" + dataDa + "T" + oreDa + "' id='meeting-time' name='locFino' class='camera-inputs date-input' id='sel-data-inizio' />");            
        %> 
                </div>
                <div class="field-elements"></div>
                <div class="field-elements genera">
                    <input
                        type="submit"
                        name="nome"
                        class="camera-inputs btn-input"
                        id="genera"
                        value="GENERA"
                        onclick="generaGrafico()"
                    />
                </div>
              </div>
                <!-- -------------------------------------------------------- -->
        <%
        String prSelect = request.getParameter("parm-grafico"); 
        String localBrDa = request.getParameter("locDa");
        String localBrFino = request.getParameter("locFino"); 
        String tipoGrafico = request.getParameter("grafico"); 

        String datoStudio, leDate, leOre;
        String dateDa, timeDa, dateFino, timeFino;
        ArrayList<String> graphLabels;
        ArrayList<Double> graphData;
        double nr;
        String filePath = "datiStanza.txt";
        
        c = null;
        db = "127.0.0.1:3306";
        schema = "airific";
        utente = "lis";
        psw = "password1234";

        dateDa = null;
        timeDa = null;
        dateFino = null;
        timeFino = null;
        
        graphLabels = new ArrayList<>();
        graphData = new ArrayList<>();
        
        if (localBrDa != null && localBrDa.length() >= 11 && localBrFino != null && localBrFino.length() >= 11) {
            //SEPARAZIONE PARAMETRI DATE E ORE
            dateDa = localBrDa.substring(0, 10);
            timeDa = localBrDa.substring(11);

            dateFino = localBrFino.substring(0, 10);
            timeFino = localBrFino.substring(11);
        }

        //System.out.println("Da: " + dateDa + " " + timeDa + " | Fino: " + dateFino + " " + timeFino);

            try {
                Class.forName("com.mysql.jdbc.Driver"); 
                c = DriverManager.getConnection("jdbc:mysql://" + db + "/" + schema, utente, psw);

                // REQUEST DI DATI PER LA LISTA DI COLONNE
                select = "SELECT " + prSelect + ", dataA, timeA FROM analisi "
                        + "WHERE id_stanza=1 AND dataA between '" + dateDa + "' AND '" + dateFino + "' AND "
                        + "timeA BETWEEN '" + timeDa + "' AND '" + timeFino + "' ORDER BY dataA ASC;";
                p = c.prepareStatement(select);
                p.execute();

                rs = p.getResultSet();
                int i = 0;
                while (rs.next()) {
                    i++;
                    datoStudio = rs.getString(prSelect);
                    nr = Double.parseDouble(datoStudio);
                    leDate = rs.getString("dataA");
                    leOre = rs.getString("timeA");
                    //System.out.println(datoStudio + " " + leDate + " " + leOre);
                    graphLabels.add("'" + i + "'");
                    graphData.add(nr);
                }

                //System.out.println(graphLabels + "\n" + graphData);

                c.close();
            } catch (SQLException ex) {
                stato = "Errore SQL: " + ex.getMessage();
            } catch (Exception ex) {
                stato = "Errore : " + ex.getMessage();
            }
        %>
            </form>

            <div class="zona-grafico">
              <canvas id="myChart"></canvas>
              <div class="chart-btns">
                <button class="dwnlPdf" onclick="generatePDF()">Download PDF</button>
              </div>
            </div>

            <div class="end-img">
              <div class="camera-rett"></div>
        <%
        out.print("<img class='camera-img' src='" + img + "' alt='Imagine del Bagno'/>");
        %>            
            </div>
        </main>        
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script> 
        <script>
        Chart.defaults.borderColor = "rgba(223, 240, 248, 0.2)";
        Chart.defaults.color = "#dff0f8";

        document.addEventListener("DOMContentLoaded", function () {
          var ctx = document.getElementById("myChart").getContext("2d");

          var data = {
            labels: "<%= graphLabels %>",
            datasets: [
              {
                label: "<%= prSelect %>",
                data: "<%= graphData %>",
                backgroundColor: ["rgba(255, 206, 86, 0.2)"],
                borderColor: ["rgba(255, 206, 86, 1)"],
                borderWidth: 1,
              },
            ],
          };

          var options = {
            responsive: false,
            maintainAspectRatio: false,
            scales: {
              y: {
                beginAtZero: true,
              },
            },
          };

          var myChart = new Chart(ctx, {
            type: "<%= tipoGrafico %>",
            data: data,
            options: options,
          });
        });
    </script> 
    </body>
</html>
