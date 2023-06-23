package testdb;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author Adel
 */
public class TestDB {

    public static void main(String[] args) {
        Connection c;
        Statement s;
        PreparedStatement p;
        ResultSet rsA, rsS;
        String db, schema, utente, psw, select;
        String ambiente, idS, iconArt, nomeS;        

        c = null;
        db = "127.0.0.1:3306";
        schema = "airific";
        utente = "lis";
        psw = "password1234";

        try {
            Class.forName("com.mysql.jdbc.Driver"); 
            c = DriverManager.getConnection("jdbc:mysql://"+db+"/"+schema, utente, psw);
            s = c.createStatement();

            select = "SELECT nome FROM ambienti;";
            p = c.prepareStatement(select);
            p.execute();
            rsA = p.getResultSet();

            while (rsA.next()) {
                ambiente = rsA.getString("nome");
                //System.out.println("\n" + ambiente);
                //System.out.println("-----------------------------------------");
                
                select = "SELECT id, iconArt, nome FROM stanze WHERE id_ambiente='" + ambiente + "';";
                p = c.prepareStatement(select);
                p.execute();
                rsS = p.getResultSet();
                while (rsS.next()) {
                    idS = rsS.getString("id");
                    iconArt = rsS.getString("iconArt");
                    nomeS = rsS.getString("nome");
                    //System.out.println(idS + " | " + iconArt + " | " + nomeS);
                }
            }

            c.close();
        } catch (SQLException ex) {
            System.out.println("Errore : " + ex.getMessage());
        } catch (Exception ex) {
            System.out.println("Errore : " + ex.getMessage());
        }
        
    }
    
}
