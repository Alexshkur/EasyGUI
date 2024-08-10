//Library
class UI {
  private int[] intVal, maxVal, minVal, x, y, w, h;
  private String[] StringVal, hint, name, type;
  private boolean[] boolVal;
  private int i = 1, Press = 0, keyPress = 0;
  private boolean hitboxes = false;
  //User's
  UI(int n) {
    n++;
    println("EasyGUI - simple library to your programs and games!");
    boolVal = new boolean[n];
    StringVal = new String[n];
    hint = new String[n];
    name = new String[n];
    type = new String[n];
    intVal = new int[n];
    minVal = new int[n];
    maxVal = new int[n];
    x = new int[n];
    y = new int[n];
    w = new int[n];
    h = new int[n];
  }
  //HitBoxes
  void showHitboxes() {
    hitboxes = true;
  }
  //Button
  void addButton(String Name, int X, int Y, int W, int H) {
    boolVal[i] = false;
    name[i] = Name;
    type[i] = "BUTTON";
    x[i] = X;
    y[i] = Y;
    w[i] = W;
    h[i] = H;
    i++;
  }
  boolean getButton(int ID) {
    return boolVal[ID];
  }
  //CheckBox
  void addCheckBox(String Name, int X, int Y, int S) {
    boolVal[i] = false;
    name[i] = Name;
    type[i] = "CHECKBOX";
    x[i] = X;
    y[i] = Y;
    w[i] = S;
    i++;
  }
  boolean getCheckBox(int ID) {
    return boolVal[ID];
  }
  int getCheckBoxWidth(int ID) {
    textSize(20);
    return int(textWidth(name[ID])) + 5 + w[ID];
  }
  //Toggle
  void addToggle(String Name, int X, int Y, int W, int H) {
    boolVal[i] = false;
    name[i] = Name;
    type[i] = "TOGGLE";
    x[i] = X;
    y[i] = Y;
    w[i] = W;
    h[i] = H;
    i++;
  }
  boolean getToggle(int ID) {
    textSize(20);
    return boolVal[ID];
  }
  //Slider
  void addSlider(String Name, int X, int Y, int W, int H, int MinVal, int MaxVal) {
    intVal[i] = 0;
    name[i] = Name;
    type[i] = "SLIDER";
    x[i] = X;
    y[i] = Y;
    w[i] = W;
    h[i] = H;
    minVal[i] = MinVal;
    maxVal[i] = MaxVal;
    i++;
  }
  int getSlider(int ID) {
    textSize(20);
    return intVal[ID];
  }
  //TextInput
  void addTextInput(String Hint, int X, int Y, int W, int H) {
    StringVal[i] = "";
    boolVal[i] = false;
    hint[i] = Hint;
    type[i] = "TEXTINPUT";
    x[i] = X;
    y[i] = Y;
    w[i] = W;
    h[i] = H;
    i++;
  }
  String getTextInput(int ID) {
    return StringVal[ID];
  }
  //Progress bar
  void addProgressBar(int X, int Y, int W, int H) {
    intVal[i] = 0;
    type[i] = "PROGRESSBAR";
    x[i] = X;
    y[i] = Y;
    w[i] = W;
    h[i] = H;
    i++;
  }
  int getProgressBar(int ID) {
    return intVal[ID];
  }
  void setProgressBar(int ID, int Val) {
    intVal[ID] = Val;
  }
  //Group
  void addGroup(String Name, int X, int Y, int W, int H) {
    name[i] = Name;
    type[i] = "GROUP";
    x[i] = X;
    y[i] = Y;
    w[i] = W;
    h[i] = H;
    i++;
  }
  //Draw
  private void drawUI() {
    for (int j = 0; j < i; j++) {
      if (mousePressed)
        Press++;
      else
        Press = 0;
      if (keyPressed && keyCode != SHIFT)
        keyPress++;
      else
        keyPress = 0;
      if (keyPress > 100)
        keyPress = 0;
      drawElement(j);
    }
  }
  //UnderFunctions
  void drawElement(int I) {
    if (type[I] == "BUTTON") {
      //Prepare
      noFill();
      stroke(130, 175, 255);
      strokeCap(ROUND);
      if (!MouseTochingRect(x[I], y[I], w[I], h[I])) {
        strokeWeight(h[I]);
        textSize(20);
        boolVal[I] = false;
        cursor(ARROW);
      } else if (mousePressed && MouseTochingRect(x[I], y[I], w[I], h[I])) {
        strokeWeight(h[I]);
        textSize(20);
        boolVal[I] = true;
      } else {
        strokeWeight(h[I]+5);
        textSize(25);
        boolVal[I] = false;
      }
      textAlign(CENTER, CENTER);
      //Draw Shape
      line(x[I], y[I] + (h[I] / 2), x[I] + w[I], y[I] + (h[I] / 2));
      //Stamp text
      fill(0);
      text(name[I], x[I] + (w[I] / 2), y[I] + (h[I] / 2));
      //Hitboxes
      noFill();
      strokeWeight(1);
      stroke(#00FF2C);
      if (hitboxes) rect(x[I], y[I], w[I], h[I]);
    }
    if (type[I] == "CHECKBOX") {
      //Prepare
      textSize(20);
      textAlign(LEFT, CENTER);
      fill(0);
      int BoxX = x[I] + int(textWidth(name[I]) + 5);
      //Stamp text
      text(name[I], x[I], y[I] + (w[I] / 2));
      //Draw Box
      noFill();
      strokeWeight(1);
      stroke(0);
      square(BoxX, y[I], w[I]);
      //Draw cross
      if (MouseTochingRect(BoxX, y[I], w[I], w[I]) && Press > 0 && Press < 300) {
        boolVal[I] = !boolVal[I];
        Press = 300;
      }
      if (boolVal[I]) {
        line(BoxX + 5, y[I] + (w[I] / 2), BoxX + (w[I] / 3), y[I] + w[I] - 5);
        line(BoxX + (w[I] / 3), y[I] + w[I] - 5, BoxX + w[I] - 5, y[I] + 5);
      }
      //hitboxes
      noFill();
      strokeWeight(1);
      stroke(#00FF2C);
      if (hitboxes) rect(BoxX, y[I], w[I], w[I]);
    }
    if (type[I] == "TOGGLE") {
      //Prepare
      noFill();
      stroke(130, 175, 255);
      strokeCap(ROUND);
      strokeWeight(h[I]);
      textSize(20);
      if (MouseTochingRect(x[I], y[I], w[I], h[I]) && Press > 0 && Press < 300) {
        boolVal[I] = !boolVal[I];
        Press = 300;
      }
      textAlign(CENTER, CENTER);
      //Draw Shape
      line(x[I], y[I] + (h[I] / 2), x[I] + w[I], y[I] + (h[I] / 2));
      //Draw select circle
      noStroke();
      if (boolVal[I]) {
        fill(#03FF83);
        circle(x[I] + w[I] - 5, y[I] + h[I] / 2, h[I] - 10);
      } else {
        fill(#FF030B);
        circle(x[I] + 5, y[I] + h[I] / 2, h[I] - 10);
      }
      strokeWeight(2);
      noFill();
      stroke(#FF030B);
      circle(x[I] + 5, y[I] + h[I] / 2, h[I] - 10);
      stroke(#03FF83);
      circle(x[I] + w[I] - 5, y[I] + h[I] / 2, h[I] - 10);
      //Stamp text
      fill(0);
      text(name[I], x[I] + (w[I] / 2), y[I] + (h[I] / 2));
      //Hiboxes
      noFill();
      strokeWeight(1);
      stroke(#00FF2C);
      if (hitboxes) rect(x[I], y[I], w[I], h[I]);
    }
    if (type[I] == "SLIDER") {
      //Prepare
      noFill();
      stroke(130, 175, 255);
      textAlign(CENTER, CENTER);
      strokeCap(ROUND);
      strokeWeight(h[I]);
      textSize(20);
      //Draw Shape
      line(x[I], y[I] + (h[I] / 2), x[I] + w[I], y[I] + (h[I] / 2));
      //Draw select circle
      fill(30, 50, 168);
      noStroke();
      int X = int(map(intVal[I], minVal[I], maxVal[I], x[I], x[I] + w[I]));
      if (MouseTochingRect(x[I] - 10, y[I], w[I] + 20, h[I]) && mousePressed) {
        fill(5, 100, 255);
        intVal[I] = int(map(pmouseX, x[I], x[I] + w[I], minVal[I], maxVal[I]));
        intVal[I] = edges(intVal[I], minVal[I], maxVal[I]);
      }
      circle(X, y[I] + h[I] / 2, h[I] - 10);
      //Stamp text
      fill(0);
      text(name[I], x[I] + (w[I] / 2), y[I] + (h[I] / 2));
      //Stamp value
      fill(0);
      text(intVal[I], x[I] + w[I] + 15 + textWidth(intVal[I] + ""), y[I] + h[I] / 2);
      //Hiboxes
      noFill();
      strokeWeight(1);
      stroke(#00FF2C);
      if (hitboxes) rect(x[I] - 10, y[I], w[I] + 20, h[I]);
    }
    if (type[I] == "TEXTINPUT") {
      //Prepare
      noFill();
      stroke(130, 175, 255);
      strokeCap(ROUND);
      strokeWeight(h[I]);
      textSize(20);
      if (MouseTochingRect(x[I], y[I], w[I], h[I]) && Press > 0 && Press < 300)
        boolVal[I] = true;
      else if (!MouseTochingRect(x[I], y[I], w[I], h[I]) && Press > 0 && Press < 300)
        boolVal[I] = false;
      if (boolVal[I])
        strokeWeight(h[I] + 10);
      else
        strokeWeight(h[I]);
      //Draw Shape
      line(x[I], y[I] + (h[I] / 2), x[I] + w[I], y[I] + (h[I] / 2));
      //Stamp hint
      if (StringVal[I] == "" && !boolVal[I]) {
        fill(#838181);
        textAlign(LEFT, CENTER);
        text(hint[I], x[I], y[I] + h[I] / 2);
      }
      //Stamp text
      String val = StringVal[I];

      if (keyPress > 0 && keyPress < 10 && boolVal[I]) {
        if (key != BACKSPACE)
          StringVal[I] += key;
      }
      try {
        if (keyPress > 0 && keyPress < 10 && boolVal[I] && key == BACKSPACE)
          StringVal[I] = val.substring(0, val.length()-1);
        val = StringVal[I].substring(val.length()-17, val.length());
      }
      catch (Exception e) {
      }
      fill(0);
      textAlign(LEFT, CENTER);
      text(val, x[I], y[I] + h[I] / 2);
      //Hiboxes
      noFill();
      strokeWeight(1);
      stroke(#00FF2C);
      if (hitboxes) rect(x[I], y[I], w[I], h[I]);
    }
    if (type[I] == "PROGRESSBAR") {
      //Prepare
      noFill();
      strokeCap(ROUND);
      strokeWeight(h[I]);
      textSize(20);
      //Draw Shape
      stroke(130, 175, 255);
      line(x[I], y[I] + (h[I] / 2), x[I] + w[I], y[I] + (h[I] / 2));
      //Draw Fill
      int X = (int)map(intVal[I], 0, 100, x[I], x[I] + w[I]);
      stroke(5, 100, 255);
      line(x[I], y[I] + h[I] / 2, X, y[I] + h[I] / 2);
      //Stamp %
      textAlign(CENTER, CENTER);
      fill(0);
      text(intVal[I] + "%", x[I] + (w[I] / 2), y[I] + (h[I] / 2));
    }
    if (type[I] == "GROUP") {
      //Prepare
      noFill();
      strokeCap(ROUND);
      strokeWeight(30);
      textAlign(CENTER, CENTER);
      textSize(20);
      //Draw Shape
      stroke(130, 175, 255);
      line(x[I], y[I], x[I], y[I] + h[I]);
      line(x[I] + w[I], y[I], x[I] + w[I], y[I] + h[I]);
      line(x[I], y[I] + h[I], x[I] + w[I], y[I] + h[I]);
      //Draw head
      line(x[I], y[I], x[I] + w[I], y[I]);
      //Stamp text
      fill(0);
      text(name[I], x[I] + (w[I] / 2), y[I]);
    }
    if (type[I] == "COLORPICKER") {
      //Prepare
      fill(130, 175, 255);
      strokeCap(ROUND);
      strokeWeight(10);
      textAlign(CENTER, CENTER);
      textSize(20);
      noStroke();
      //Draw Shape
      rect(x[I], y[I], w[I], h[I]);
    }
  }
  //System's
  private boolean MouseTochingRect(int X, int Y, int W, int H) {
    int X2 = X + W;
    int Y2 = Y + H;
    boolean tmp = false;
    tmp = ((mouseX > X) && (mouseX < X2)) && ((mouseY > Y) && (mouseY < Y2));
    return tmp;
  }
  private int edges(int val, int min, int max) {
    int Val = val;
    if (val > max) Val = max;
    if (val < min) Val = min;
    return Val;
  }
}
