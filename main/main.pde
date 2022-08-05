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

  text("Jan",105,20);
  text("Feb",205,20);
  text("Mar",305,20);
  text("Apr",405,20);
  text("Mai",505,20);
  text("Jun",605,20);
  text("Jul",705,20);
  text("Aug",805,20);
  text("Sep",905,20);
  text("Okt",1005,20);
  text("Nov",1105,20);
  text("Dez",1205,20);
  
  draw_temperaturebar();
  draw_temperaturebar_skala();
  
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
        text(firstYear+i,10,20);
        return;
      }
    }
  }
  
}

float getScaledTemp(int y, int m) {
  return screenHeight-50-(temprature[y][m]-minTemp)*scale;
}

void draw_temperaturebar(){
  fill(#f10101);
  stroke(#fb0000);
  rect(1350,220,30,20);
  
  fill(#fe8e2a);
  stroke(#fc9b10);
  rect(1350,240,30,20);
  
  fill(#fef610);
  stroke(#fef610);
  rect(1350,260,30,20);
  
  fill(#df31f9);
    stroke(#df31f9);
  rect(1350,280,30,20);
  
   fill(#0076ee);
     stroke(#0076ee);
  rect(1350,300,30,20);
  
   fill(#46c0ff);
     stroke(#0076ee);
  rect(1350,320,30,20);
  
   fill(#a0f5ff);
     stroke(#0076ee);
  rect(1350,340,30,20);
  
   fill(#add7fe);
     stroke(#0076ee);
  rect(1350,360,30,20);
}

void draw_temperaturebar_skala(){
  textSize(18);
  fill(#000000);
  text("C°",1390,216);
  text("< 15",1390,236);
  text("11 bis 15",1390,256);
  text("6 bis 10",1390,276);
  text("1 bis 5",1390,296);
  text("-6 bis 0",1390,316);
  text("-9 bis -5",1390,336);
  text("-15 bis -10",1390,356);
  text("> -15",1390,376);
}
