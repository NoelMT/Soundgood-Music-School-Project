package com.company;
import java.sql.*;
import java.util.Scanner;


public class Main {

    private static PreparedStatement getAvailInsSTM;
    private static PreparedStatement getallSTM;
    private static PreparedStatement nrRentalsSTM; //nr of rentals per student
    private static PreparedStatement addRentalSTM; //nr of rentals per student
    private static PreparedStatement revertSTM; //gör så att instrumentet blir unrented true -> false
    private static PreparedStatement getStudIdSTM; //hömtar student id för terminate och lägger till history
    private static PreparedStatement addHistorySTM;    //private PreparedStatement ;

    public Connection accesDB(String s, String s1) throws SQLException, ClassNotFoundException {
            Class.forName("org.postgresql.Driver");
           return DriverManager.getConnection("jdbc:postgresql://localhost:5432/"+s1,
                    "postgres", s);
    }
    public static void main(String[] args) throws SQLException, ClassNotFoundException {

        System.out.println("Soundgood Music School");
        System.out.println("help to list commands");
        boolean ker = true;
        Scanner db = new Scanner(System.in);
        System.out.println("\nENTER IN PASSWORD AND NAME OF DATABASE");
        System.out.println("[\"PASWORD\" \"DB\"]");
        String[] s =  db.nextLine().split(" ");
        Connection c = new Main().accesDB(s[0],s[1]);
        c.setAutoCommit(false);
        Statement stmt = c.createStatement();
        prepareStatements(c);

        Scanner in = new Scanner(System.in);
        while(ker) {
            String com = in.next().toLowerCase();

            switch (com){
                default:
                    System.out.println(" COMMAND DONT EXIST");
                    break;
                case "help":
                    System.out.println("\n-> quit\n-> list |enter in a instrument and get brand and price of available instrumnets|\n-> show |shows all intruments that are rented and by who| \n" +
                            "-> add |Lets a student rent an instrument by entering student id and then instrument id|\n" +
                            "-> term |Terminate a rental by entering instrument id and adds it to the rental history|\n  ");
                    break;
                case "quit":
                    ker = false;
                    c.close();
                    break;
                case "list":
                    Scanner inst = new Scanner(System.in);
                    System.out.println("choose instrument: ");
                    rentalPrint(inst.next());
                    break;
                case "show":
                    showRented();
                    break;
                case "add":
                    Scanner ine = new Scanner(System.in);
                    System.out.println("Enter in student ID and then Instrument ID");
                    String[] ar = ine.nextLine().toLowerCase().split(" "); //studentID InstrumentID
                    addRent(Integer.parseInt(ar[0]) ,Integer.parseInt(ar[1]), c);
                    break;
                case "term":
                    Scanner inte = new Scanner(System.in);
                    terminate(inte.nextInt(),c);
                    break;
                }
            System.out.println("ENTER NEW COMMAND");
            }
        }



    private static void addRent(int studID, int instID,Connection c) throws SQLException {
        if (nrRental((studID)) == 2 ){
            System.out.println("STUDENT ALREADY RENTED TWO INSTRUMENTS");
        }
        else{
            addrentals( studID,instID,c);
        }

    }
    private static void showRented() throws SQLException {
            ResultSet r = getall();
            while (r.next()){
                System.out.println("StudentID: " + r.getString("student_id") + " IntrumentID: " + r.getString("id") );
            }
    }

    private static void rentalPrint(String inst) throws SQLException {
        ResultSet r = getAvailIns(inst);
            System.out.println("--------------------------------------------------");
        while (r.next()){
            System.out.println("Brand: " + r.getString("brand")
                    + " price: " + r.getString("price"));
            }
            System.out.println("---------------------------------------------------");
        }

    private static boolean checkTable(Connection c, String s) throws SQLException {
        DatabaseMetaData metaData= c.getMetaData();
        ResultSet tablemMetaData=metaData.getTables(null,null,null,null);
        while(tablemMetaData.next()){
            String tableName=tablemMetaData.getString(3);
            if(tableName.equals(s))
                return true;
                }
        return false;
        }

    private static void printTable(Statement s) throws SQLException {
        ResultSet r = s.executeQuery("select * from ensemble");
        while (r.next()){
            System.out.println("ensembleID: " + r.getString(3));
        }
    }
    private static int nrRental(int id) throws SQLException {
        ResultSet r = nrRentals(id);
        r.next();
        return r.getInt(1);
    }

//------------------------------------------------------------------------------------------------------------
    // STATEMENTS
    public static ResultSet getAvailIns(String inst){
        try{
            getAvailInsSTM.setString(1,inst);
            return getAvailInsSTM.executeQuery();
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }
    private static ResultSet getall(){
        try {
            return getallSTM.executeQuery();
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    private static ResultSet nrRentals(int id){
        try {
            nrRentalsSTM.setInt(1,id);
            return nrRentalsSTM.executeQuery();
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    private static void addrentals(int studID, int instID,Connection c) {
        try{
            addRentalSTM.setInt(1,studID);
            addRentalSTM.setInt(2,instID);
            addRentalSTM.executeUpdate();
            c.commit();
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }
    private static int getStudId(int instID) {
        try{
            getStudIdSTM.setInt(1,instID);
            ResultSet r = getStudIdSTM.executeQuery();
            r.next();
            return r.getInt(6);
        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }
    }
    private static void revert(int instId,Connection c)  {
        try {
            revertSTM.setInt(1, instId);
            revertSTM.executeUpdate();
            c.commit();
            } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private static void terminate(int instId,Connection c) {
        int studId = getStudId(instId);
        revert(instId,c);
        try{
            addHistorySTM.setInt(1,instId);
            addHistorySTM.setInt(2,studId);
            addHistorySTM.executeUpdate();
            c.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }

    }


    private static void prepareStatements(Connection c) throws SQLException {

        getAvailInsSTM = c.prepareStatement("select * from instrument_renting where is_rented = FALSE and instrument = ? ");

        getallSTM = c.prepareStatement("select * from instrument_renting where is_rented = TRUE");

        nrRentalsSTM = c.prepareStatement("select count(*) from instrument_renting where student_id = ?");

        addRentalSTM = c.prepareStatement("update instrument_renting set is_rented = TRUE, student_id = ? where id = ?");

        revertSTM = c.prepareStatement("update instrument_renting set is_rented = FALSE, student_id = null where id = ?");

        getStudIdSTM = c.prepareStatement("select *  from instrument_renting where id = ? ");

        addHistorySTM = c.prepareStatement("insert into instrument_renting_history(instrument_renting_id,return_date,student_id) values(?,CURRENT_DATE,?)");
    }

}



/*
        statement.executeUpdate("insert into..."); för att sätta in värden i tabellen
 */

/*
            DatabaseMetaData metaData = connection.getMetaData();
            ResultSet tableMetaData = metaData.getTables(null,null,null,null);
            int i = 0;
            while(tableMetaData.next()){
                if (tableMetaData.getString(i).equals("ensemble"))
                    System.out.println("true");
                else
                    System.out.println("false");
                i++;
            }



//stmt.executeUpdate("create table test (num int)");
        System.out.println(checkTable(c, "ensemble"));
        printTable(stmt);
 */