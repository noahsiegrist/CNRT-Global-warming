Table table;

float[] aveYearly;
float[][] temprature;
int firstYear = 0;
int step = 0;

int screenWidth = 1300, screenHeight=800;
float scale;
float scaleY;
float maxTemp = -999;
float minTemp = 999;

float maxTempY = -999;
float minTempY = 999;

color c1 = color(200, 21, 30);
color c2 = color(0, 150, 255);

void setup() {
  size(1500, 800);
  frameRate(60);
  
  table = loadTable("data/jungfrau.csv", "header");
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
  aveYearly = new float[table.getRowCount()/12+1];
  
  for(int i = 0; temprature.length > i; i++) {
    aveYearly[i] = getAverage(temprature[i]);
    if(maxTempY < aveYearly[i]) {
      maxTempY = aveYearly[i];
    }
    if(minTempY > aveYearly[i]) {
      minTempY = aveYearly[i];
    }
  }
  
  float tempRangeY = maxTempY-minTempY;
  scaleY = (screenHeight-100)/tempRangeY;
  
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
    stroke(getColorPerTemp(aveYearly[i]));
    for(int j = 0; 11 > j; j++){
      if(temprature[i][j] == temprature[i][j+1] && temprature[i][j] == 0){
        return;
      }
      
      line(j*100+100, getScaledTemp(i, j), j*100+200, getScaledTemp(i, j+1));
      y++;
      if(step < y){
        step++;
        textSize(24);
        fill(#0f26d2);
        text(firstYear+i,10,20);
        return;
      }
      
    }
  }
  
}

float getAverage(float[] a) {
  float sum = 0;
  for(float i : a) {
    sum += i; 
  }
  return sum/ a.length;
}

float getScaledTemp(int y, int m) {
  return getTempToScreen(temprature[y][m]);
}

float getTempToScreen(float temp){
  return screenHeight-50-(temp-minTemp)*scale;
}

float getTempYToScreen(float temp){
  return screenHeight-50-(temp-minTempY)*scaleY;
}

void draw_temperaturebar(){  
  int x = 1350;
  int y = 50;
  int h = screenHeight-100;
  int w = 30;
  
 
  for (int i = y; i <= y+h; i++) {
      float inter = map(i, y, y+h, 0, 1);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      line(x, i, x+w, i);
    }
}

color getColorPerTemp(float temp){
  float inter = map(temp, maxTempY, minTempY, 0, 1);
  return lerpColor(c1, c2, inter);
}

void draw_temperaturebar_skala(){
  textSize(18);
  fill(#000000);
  text("Jahresdurchschnitt in C??",1300,30);
  text(maxTemp,1390,getTempYToScreen(maxTempY));
  text("0",1390,getTempYToScreen(0));
  text(minTemp,1390,getTempYToScreen(minTempY));
}
