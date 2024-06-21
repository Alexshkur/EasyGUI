UI ui;
void setup() {
  size(400, 200);
  ui = new UI(7); //elements
  //ui.showHitboxes();
  ui.addButton("Button", 20, 10, 100, 30); //Name, x, y, width, height
  ui.addCheckBox("CheckBox", 20, 50, 25); //Name, x, y, BoxSize
  ui.addToggle("Toggle", 20, 85, 100, 30); //Name, x, y, width, height
  ui.addSlider("Slider", 20, 125, 100, 30, 0, 100); //Name, x, y, width, height, minVal, maxVal
  ui.addTextInput("Enter Text", 180, 10, 170, 30); //Hint, x, y, width, height
  ui.addProgressBar(180, 50, 170, 30); //x, y, width, height
  ui.addGroup("Group", 190, 105, 170, 70); //Name, x, y, w, h
}
void draw() {
  background(200);
  ui.drawUI();
  ui.setProgressBar(6, ui.getSlider(4));
  textAlign(LEFT, CENTER);
  text(ui.getTextInput(5), 20, 170);
}
