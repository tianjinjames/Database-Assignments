import java.sql.*;

public class Assignment2 {
    
 // A connection to the database  
 Connection connection = null;

 // Statement to run queries
 Statement sql;

 // Prepared Statement
 PreparedStatement ps;

 // Resultset for the query
 ResultSet rs;

 //CONSTRUCTOR
 Assignment2(){
  try {
   // Load JDBC driver
   Class.forName("org.postgresql.Driver");
  } catch (ClassNotFoundException e) {
   return;
  }
 }
  
 //Using the input parameters, establish a connection to be used for this session. Returns true if connection is sucessful
 public boolean connectDB(String URL, String username, String password){
  try {
   connection = DriverManager.getConnection(URL, username, password);
  } catch (SQLException e) {
   return false;
  }
  if (connection != null) {
   return true;
  } else {
   return false;
  }
 }
  
 //Closes the connection. Returns true if closure was sucessful
 public boolean disconnectDB(){
  try {
   if(connection != null) {
    connection.close();
    return true;
   } else {
    return false;
   }
  } catch (SQLException e) {
   return false;
  }
 }
    
 //Inserts row into the country table
 public boolean insertCountry (int cid, String name, String coach) {
  try {
   sql = connection.createStatement(); 
   String sqlText;
   sqlText = "INSERT INTO country VALUES (" + cid + ", '" + name + "', '" + coach + "')";
   sql.executeUpdate(sqlText);
   return true;
  } catch (SQLException e) {
   return false;
  }  
 }

 public int getPlayersCount(int cid){
  String sqlText;
  try{
   sql = connection.createStatement();
   sqlText = "SELECT * FROM player WHERE cid = " + cid;
   rs = sql.executeQuery(sqlText);
   int count = 0;
   if (rs.next()){
    count++;
    while (rs.next()){
     count++;
    } 
   }
   return count;
  } catch (SQLException e){
   return -1;
  }
 }
   
 public String getPlayerInfo(int pid){
  String sqlText;  
  try{ 
   sql = connection.createStatement();
   sqlText = "SELECT * FROM player WHERE pid = " + pid;
   rs = sql.executeQuery(sqlText);
   String fname, lname, position, output;
   int goals;
   if (!rs.next()) {
    return "";
   } else {
    fname = rs.getString("fname");
    lname = rs.getString("lname");
    position = rs.getString("position");
    goals = rs.getInt("goals");
    output = fname + ":" + lname + ":" + position + ":" +  goals;
    return output;
   }
  } catch (SQLException e) {
   return "";
  }
 }

 public boolean chgStadiumLocation(int sid, String newCity){
  try{ 
   String sqlText;        
   sql = connection.createStatement();      
   sqlText = "UPDATE stadium SET city = '" + newCity + "' WHERE sid ="  + sid; 
   sql.executeUpdate(sqlText);
   if (sql.getUpdateCount()>0){
    return true;
   } else {
    return false;
   }
  } catch (SQLException e) {
   return false;
  }
 }

 public boolean deleteCountry(int cid){
  String sqlText;        
  try{ 
   sql = connection.createStatement(); 
   sqlText = "DELETE FROM country WHERE cid = " + cid; 
   sql.executeUpdate(sqlText);
   if (sql.getUpdateCount()>0){
    return true;
   } else {
    return false;
   }
  } catch (SQLException e) {
   return false;
  }
 }
  
 public String listPlayers(String fcname){
  String sqlText;
  try{ 
   sql = connection.createStatement(); 
   sqlText = "SELECT DISTINCT fcid FROM club WHERE name = '" + fcname +"'";
   rs = sql.executeQuery(sqlText);

   String fname, lname, position, cname, output;
   int goals;

   if (!rs.isBeforeFirst()){
    return "";
   } else {
    rs.next();
    sqlText = "SELECT * FROM player JOIN country ON player.cid = country.cid WHERE fcid = " + rs.getInt("fcid");
    rs = sql.executeQuery(sqlText);

    rs.next();
    fname = rs.getString("fname");
    lname = rs.getString("lname");
    position = rs.getString("position");
    goals = rs.getInt("goals");
    cname = rs.getString("name");
    output = fname + ":" + lname + ":" + position + ":" +  goals + ":" +  cname;

    while (rs.next()){
     fname = rs.getString("fname");
     lname = rs.getString("lname");
     position = rs.getString("position");
     goals = rs.getInt("goals");
     cname = rs.getString("name");
     output += "#" + fname + ":" + lname + ":" + position + ":" +  goals + ":" +  cname;
    }
    return output;
   }
  } catch (SQLException e) {
   return "";
  }
 }
  
 public boolean updateValues(String cname, int incrV){
  String sqlText;
  try{ 
   sql = connection.createStatement();    
   sqlText = "SELECT DISTINCT cid FROM country WHERE name = '" + cname + "'";
   rs = sql.executeQuery(sqlText);
   if (!rs.isBeforeFirst()){
    return false;
   }
   rs.next();
   sqlText = "UPDATE player SET value = value + " + incrV + " WHERE  cid = " + rs.getInt("cid");
   sql.executeUpdate(sqlText);
   if (sql.getUpdateCount()>0){
    return true;
   } else {
    return false;
   }
  } catch (SQLException e) {
   return false;
  }
 }

 public String query7(){
  String name, coach, output;
  int budget;
  String sqlText;
  try{ 
   sql = connection.createStatement();  

   sqlText = "CREATE VIEW topScorer AS SELECT cid, MAX(goals) AS scores FROM player GROUP BY cid";
   sql.executeUpdate(sqlText);

   sqlText = "CREATE VIEW maxScore AS SELECT MAX(scores) AS maxscore FROM topScorer";
   sql.executeUpdate(sqlText);

   sqlText = "CREATE VIEW topScorerTeam AS SELECT cid FROM topScorer JOIN maxScore ON (topScorer.scores = maxScore.maxscore)";
   sql.executeUpdate(sqlText);

   sqlText = "CREATE VIEW budgetTeam AS SELECT cid, SUM(value) AS budget FROM player GROUP BY cid";
   sql.executeUpdate(sqlText);

   sqlText = "CREATE VIEW lowestBudget AS SELECT MIN(budget) AS minbudget FROM budgetTeam";
   sql.executeUpdate(sqlText);

   sqlText = "CREATE VIEW lowestBudgetTeam AS SELECT cid, minbudget AS budget FROM lowestBudget JOIN budgetTeam ON (lowestBudget.minbudget = budgetTeam.budget)";
   sql.executeUpdate(sqlText);

   sqlText = "CREATE VIEW countryLowestBudgetTopScorer AS SELECT topScorerTeam.cid AS cid, budget FROM topScorerTeam JOIN lowestBudgetTeam ON topScorerTeam.cid = lowestBudgetTeam.cid";
   sql.executeUpdate(sqlText);

   //We project Query7 over here.
   sqlText = "SELECT name, coach, budget FROM countryLowestBudgetTopScorer JOIN country ON (countryLowestBudgetTopScorer.cid = country.cid)";
   rs = sql.executeQuery(sqlText);

   if (!rs.isBeforeFirst()){
    return "";
   } else {
   rs.next();
   //Query7 (String name, String coach, integer budget)
   name = rs.getString("name");
   coach = rs.getString("coach");
   budget = rs.getInt("budget");
   output = name + ":" + coach + ":" + budget;

   while (rs.next()){
    name = rs.getString("name");
    coach = rs.getString("coach");
    budget = rs.getInt("budget");
    output += "#" + name + ":" + coach + ":" + budget;
   }
   return output;
   }
  } catch (SQLException e) {
   return "";
  }
 }

 public boolean updateDB(){
  String sqlText;
  try{ 
   sql = connection.createStatement();    
   sqlText = "DROP TABLE valuablePlayers CASCADE";
   sql.executeUpdate(sqlText);

   sqlText = "CREATE TABLE valuablePlayers(pid INTEGER, lname VARCHAR(20))";
   sql.executeUpdate(sqlText);

   sqlText = "INSERT INTO valuablePlayers( SELECT DISTINCT player.pid, lname FROM player JOIN appearance ON (player.pid = appearance.pid) WHERE minutes = '90' ORDER BY player.pid ASC)";
   sql.executeUpdate(sqlText);

   return true;
  } catch (SQLException e) {
   return false;
  }
 }
}
