Table table;

float[][] temprature;
int firstYear = 0;
int step = 0;

int screenWidth = 1300, screenHeight=800;
float scale;
float maxTemp = -999;
float minTemp = 999;

void setup() {
  size(1500, 800);
  frameRate(20);
  
  table = loadTable("data/zuerich.csv", "header");
  println(table.getRowCount() + " total rows in table");
  
  temprature = new float[table.getRowCount()/12+1][12];
  

  for (TableRow row : table.rows()) {
    
    int year = row.getInt("Year");
    int month = row.getInt("Month");
    float temp = row.getFloat("Temperature");
    
    if(firstYear == 0){
      firstYear = year;
    }
    
    println(year + " : " + month + " with temp " + temp);
    temprature[year-firstYear][month-1] = temp;
    
    if(maxTemp < temp) {
      maxTemp = temp;
    }
    if(minTemp > temp) {
      minTemp = temp;
    }
  }
  
  float tempRange = maxTemp-minTemp;
  scale = (screenHeight-100)/tempRange;
  

}

void draw() {
  background(#FFFFFF);
  fill(#000000);
  textSize(24);
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
  
  draw_temperaturebar();
  
  drawChart();
  
}

void drawChart(){
  int y = 0;
  for(int i = 0; temprature.length > i; i++) {
    for(int j = 0; 11 > j; j++){
      
      line(j*100+100, getScaledTemp(i, j), j*100+200, getScaledTemp(i, j+1));
      y++;
      if(step < y){
        step++;
        text(firstYear+i,10,10);
        return;
      }
    }
  }
  
}

float getScaledTemp(int y, int m) {
  return screenHeight-50-(temprature[y][m]-minTemp)*scale;
}

void draw_temperaturebar(){
  fill(#b43b3b);
  stroke(#b43b3b);
  rect(1350,220,30,20);
  fill(#ce8e2a);
  stroke(#ce8e2a);
  rect(1350,240,30,20);
}
