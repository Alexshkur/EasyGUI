//Libraries
import controlP5.*;
ControlP5 cp5;
BufferedReader reader;
String line;
//Variables
int X, Y, W, H, CanvasWidth, CanvasHeight, PanelHeight, PenSizeW, PenSizeH, Shape, Mode;
color BackgroundColor, PenColor, oldPenColor;
String name;
PrintWriter output;
void setup() {
  size(900, 700);
  //Reset - the setup
  ResetTheSetup();
}
void ResetTheSetup() {
  cp5 = new ControlP5(this);
  surface.setResizable(true);
  surface.setTitle("Paint");
  frameRate(10000);
  X = Y = 0; //Position mouse cursor
  PanelHeight = 200;
  CanvasWidth = width;
  CanvasHeight = height - PanelHeight;
  BackgroundColor = 200;
  PenColor = 0;
  oldPenColor = 0;
  PenSizeW = 20;
  PenSizeH = 20;
  background(BackgroundColor);
  AddUI();
}
void draw() {
  //ClearCanvas();
  //windowResize(width, height);
  TickCanvas();
  TickPaintPallet();
  SavePainted();
}


//Functions
void ClearCanvas() {
  fill(BackgroundColor);
  noStroke();
  rect(0, PanelHeight, CanvasWidth, CanvasHeight);
}
void SavePainted() {
  if (mousePressed && mouseY > PanelHeight && output != null)
    output.println(mouseX + " " +  mouseY + " " + PenColor + " " + PenSizeW);
}
void DrawPaintPallet() {
  noStroke();
  fill(0);
  rect(0, 0, width, PanelHeight);
  fill(PenColor);
  stroke(255);
  strokeWeight(5);
  circle(300, 120, PenSizeW);
  noStroke();
}
void TickPaintPallet() {
  DrawPaintPallet();
  if (Mode == 0) {
    cp5.get(Toggle.class, "Mode")
      .setLabel("Mode: Pen")
      ;
  } else {
    cp5.get(Toggle.class, "Mode")
      .setLabel("Mode: Eraser")
      ;
  }
}
void TickCanvas() {
  CanvasWidth = width;
  CanvasHeight = height - PanelHeight;
  if (Mode == 0) {
    oldPenColor = cp5.get(ColorWheel.class, "oldPenColor").getRGB();
    PenColor = oldPenColor;
  } else {
    PenColor = BackgroundColor;
  }
  if (mousePressed) DrawShape(mouseX, mouseY, PenSizeW, 10, 1);
}
void DrawShape(int x, int y, int w, int h, int Shape) {
  fill(PenColor);
  noStroke();
  if (mouseY > 200) {
    if (Shape == 1) { //Circle
      circle(x, y, w);
    }
  }
}

void AddUI() {
  cp5.setFont(createFont("Ubuntu", 12));
  cp5.addButton("ClearCanvas")
    .setPosition(10, 10)
    .setSize(100, 30)
    .setLabel("Erase All")
    ;
  cp5.addButton("Open")
    .setPosition(340, 10)
    .setSize(70, 30)
    .setLabel("Open")
    ;
  cp5.addButton("Save")
    .setPosition(420, 10)
    .setSize(100, 30)
    .setLabel("Start Saving")
    ;
  cp5.addTextfield("name")
    .setPosition(420, 50)
    .setSize(100, 30)
    .setLabel("File name")
    ;
  cp5.addColorWheel("oldPenColor", 10, 70, 100)
    .setLabel("Pen Color")
    ;
  cp5.addSlider("PenSizeW")
    .setPosition(120, 10)
    .setSize(100, 30)
    .setLabel("Pen Size:")
    .setRange(1, 130)
    .getCaptionLabel()//Label
    .align(ControlP5.LEFT, ControlP5.CENTER)
    .setPaddingX(10)
    ;
  cp5.addColorWheel("BackgroundColor", 120, 70, 100)
    .setLabel("Stage Color")
    ;
  cp5.addToggle("Mode")
    .setPosition(230, 10)
    .setSize(95, 30)
    .setLabel("Mode: Pen")
    .setMode(ControlP5.SWITCH)
    .getCaptionLabel()//Label
    .align(ControlP5.LEFT, ControlP5.CENTER)
    .setPaddingX(5)
    ;
  cp5.getController("PenSizeW")
    .getValueLabel()
    .align(ControlP5.RIGHT, ControlP5.CENTER)
    .setPaddingX(10);
}

void BackgroundColor(color i) {
  BackgroundColor = i;
  ClearCanvas();
}
void Open() {
  selectInput("Select file", "opened");
}
void Save() {
  name = cp5.get(Textfield.class, "name").getText();
  output = createWriter(name + ".epi");
}
void opened(File file) {
  reader = createReader(file.getAbsolutePath());
  output.println("new");
  try {
    line = reader.readLine();
  }
  catch (IOException e) {
    e.printStackTrace();
  }
  for (int i = 0; line != null; i++) {
    try {
      line = reader.readLine();
    }
    catch (IOException e) {
      e.printStackTrace();
    }
    String[] pieces = split(line, " ");
    int x = int(pieces[0]);
    int y = int(pieces[1]);
    int w = int(pieces[3]);
    color col = int(pieces[2]);
    fill(col);
    circle(x, y, w);
  }
}
