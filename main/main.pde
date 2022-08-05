Table table;

Float[][] temprature;
int firstYear;

void setup() {
  size(1200, 800);
  
  table = loadTable("data/zuerich.csv", "header");
  println(table.getRowCount() + " total rows in table");
  
  temprature = new Float[table.getRowCount()/12+1][12];
  

  for (TableRow row : table.rows()) {
    
    int year = row.getInt("Year");
    int month = row.getInt("Month");
    float temp = row.getFloat("Temperature");
    
    if(firstYear == 0){
      firstYear = year;
    }
    
    println(year + " : " + month + " with temp " + temp);
    temprature[year-firstYear][month-1] = temp;

  }

}

void draw() {

}
