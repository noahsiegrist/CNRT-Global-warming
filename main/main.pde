Table table;

void setup() {
  size(1200, 800);
  
  table = loadTable("data/zuerich.csv");

  println(table.getRowCount() + " total rows in table");

  for (TableRow row : table.rows()) {

    int year = row.getInt(0);
    int month = row.getInt(1);
    float temp = row.getFloat(2);
    float temp2 = row.getFloat(3);

    println(year + " : " + month + " with temp " + temp);
  }

}

void draw() {

}
