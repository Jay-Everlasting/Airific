package testdb;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Adel
 */
public class TestDB {

    public static void main(String[] args) {
        // Database connection details
        Connection c;
        PreparedStatement p;
        ResultSet rs;
        String db, schema, utente, psw, select;
        String datoStudio, leDate, leOre;
        String stato = "", prSelect="co";
        String dateDa, timeDa, dateFino, timeFino;
        String localBrDa, localBrFino;
        
        localBrDa = "2023-03-21T11:12:25";
        localBrFino = "2023-03-30T18:44:30";
        

        c = null;
        db = "127.0.0.1:3306";
        schema = "airific";
        utente = "lis";
        psw = "password1234";

        //SEPARAZIONE PARAMETRI DATE E ORE
        dateDa = localBrDa.substring(0, 10);
        timeDa = localBrDa.substring(11);
        
        dateFino = localBrFino.substring(0, 10);
        timeFino = localBrFino.substring(11);
        
        System.out.println("Da: " + dateDa + " " + timeDa + " | Fino: " + dateFino + " " + timeFino);
        
        try {
            //Class.forName("com.mysql.jdbc.Driver"); 
            c = DriverManager.getConnection("jdbc:mysql://"+db+"/"+schema, utente, psw);
            System.out.println("Connessione fatta");
          
            // REQUEST DI DATI PER LA LISTA DI COLONNE
            select = "SELECT " + prSelect + ", dataA, timeA FROM analisi "
            + "WHERE id_stanza=1 AND dataA between '" + dateDa + "' AND '" + dateFino + "' "
            + "AND timeA BETWEEN '" + timeDa + "' AND '" + timeFino + "' "
            + "ORDER BY dataA ASC;";
            p = c.prepareStatement(select);
            p.execute();
            System.out.println("Query mandata");
            
            rs = p.getResultSet();
            System.out.println("Result Set presa " + rs);
            while (rs.next()) {
                datoStudio = rs.getString(prSelect);
                leDate = rs.getString("dataA");
                leOre = rs.getString("timeA");
                System.out.println(datoStudio + " " + leDate + " " + leOre);
            }
            
            c.close();
            } catch (SQLException ex) {
                System.out.println("Errore SQL: " + ex.getMessage()); 
            } catch (Exception ex) {
                System.out.println("Errore : " + ex.getMessage()); 
            }        
    }
    
}
