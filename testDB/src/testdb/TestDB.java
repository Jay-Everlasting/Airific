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
        ResultSet rs;
        String db, schema, utente, psw, select;
        String usr, pswd;
        
        c = null;
        db = "127.0.0.1:3306";
        schema = "airific";
        utente = "lis";
        psw = "password1234";
        
        usr = "adel.lis@itismattei.net";
        pswd = "theGOAT33";
        
        try {
            c = DriverManager.getConnection("jdbc:mysql://"+db+"/"+schema, utente, psw);
            s = c.createStatement();
            
            select = "SELECT * FROM autentificazioni WHERE email='" + usr + "' AND pswd='" + pswd + "';";
            p = c.prepareStatement(select);
            p.execute();
            
            rs = p.getResultSet();
            
            if (rs.next()) {
                System.out.println("Utente esiste!");
            } else {
                System.out.println("Utente inesistente!");
            }
            
            c.close();
        } catch (SQLException ex) {
            System.out.println("Errore : " + ex.getMessage());
        }
        
    }
    
}
