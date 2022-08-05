Table table;

Float[][] temprature;
int firstYear;

void setup() {
  size(1300, 800);
  
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
  background(#FFFFFF);
  fill(255,0,0);
  stroke(#000000);
  line(100,0,100,800);
  line(200,0,200,800);
  line(300,0,300,800);
  line(400,0,400,800);
  line(500,0,500,800);
  line(600,0,600,800);
  line(700,0,700,800);
  line(800,0,800,800);
  line(900,0,900,800);
  line(1000,0,1000,800);
  line(1100,0,1100,800);
  line(1200,0,1200,800);
  text("Jan",105,10);
  text("Feb",205,10);
  text("Mar",305,10);
  text("Apr",405,10);
  text("Mai",505,10);
  text("Jun",605,10);
  text("Jul",705,10);
  text("Aug",805,10);
  text("Sep",905,10);
  text("Okt",1005,10);
  text("Nov",1105,10);
  text("Dez",1205,10);
}
