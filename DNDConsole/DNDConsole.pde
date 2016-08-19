import controlP5.*;

ControlP5 cp5;
String requestedChange;
int currentHP, baseHP; //these should be read from a character class later

//create controllers in setup
void setup() {
  currentHP = 7;
  baseHP = 10; //remove later********
  size(1200,600);
  PFont font = createFont("arial",20);
  cp5 = new ControlP5(this);
  
  //Following block is the Name bar
  cp5.addBang("nameField") //a bang is a button that does not pass a value
     .setPosition(20,20)
     .setSize(80,30)
     .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
     ;
  cp5.addTextfield("inputField")
     .setPosition(550, 280)
     .setSize(80,40)
     .setFont(font)
     .hide()
     ;
     
  //Following block is the HP bar
  cp5.addTextlabel("HPLabel")
     .setText("HP")
     .setPosition(20, 60)
     .setFont(font)
     //.setColorValue(0xffffff00)
     /*.addCallback(new CallbackListener() {
       public void controlEvent(CallbackEvent theEvent) {
         if (theEvent.getAction()==ControlP5.ACTION_CLICK) {
           //nameField();
           //cp5.getController("inputField").show();
         }
       }
     })*/
     ;
  cp5.addBang("HPBarLower")
     .setPosition(60, 60)
     .setSize(100, 30)
     .setLabel("")
     ;
  cp5.addBang("HPBarUpper")
     .setPosition(60, 60)
     .setSize(70, 30)
     .setLabel("")
     .setColorActive(ControlP5.RED)
     .setColorForeground(ControlP5.RED)
     ;
  cp5.addTextlabel("HPIndicator")
     .setText("7/10")
     .setPosition(90, 60)
     .setFont(font)
     ;
  
  
  textFont(font);
}

//draw occurs once per frame.
void draw() {
   background(0);
}

//create controller functions here by giving them the same name.
public void nameField() {
  cp5.getController("inputField").show();
  requestedChange = "name";
}

public void inputField(String input) {
  switch (requestedChange) {
    case "name":    cp5.getController("nameField").setLabel(input);
                    break;
    case "baseHP":  baseHP = Integer.parseInt(input); //this is dangerous.  Have to catch error.
                    int width = (int)((float)currentHP/(float)baseHP * (float)100);
                    cp5.getController("HPBarUpper").setSize(width,30);
                    cp5.get(Textlabel.class,"HPIndicator").setText(currentHP + "/" + baseHP);
                    break;
  }
  cp5.getController("inputField").hide();
}

public void HPBarLower() {
  cp5.getController("inputField").show();
  requestedChange = "baseHP";
}
public void HPBarUpper() {
  HPBarLower();
}

void keyPressed() {
  if (key=='r') {
    cp5.getController("nameField").hide();
  }
  if (key=='q') {
    cp5.getController("nameField").show();
  }
  
  
}