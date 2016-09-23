import controlP5.*;

ControlP5 cp5;
String requestedChange, inputHolder;
Boolean decision;
int effectCount;
int currentHP, baseHP, currentMP, baseMP, effectiveMP,  STR, DEX, CON, INT, CHA, WIS, maxStam, currentStam, overStam, lockedStam; //these should be read from a character class later
float lockedMP;
StatusEffect[][] EffectsArray;
StatusEffect statusHolder;
PFont font;
Controller inputField;
Controller[] decisionParts = new Controller[3];

//create controllers in setup
void setup() {
  decision = false;
  maxStam = 5;
  currentStam = 3;
  overStam = 2;
  currentHP = 7;
  baseHP = 10; //remove later********
  currentMP = 10;
  baseMP = 20;
  lockedMP = .3;
  effectiveMP = baseMP;
  effectCount = 0;
  size(1200,600);
  font = createFont("arial",20);
  cp5 = new ControlP5(this);
  EffectsArray = new StatusEffect[3][3];
  
  //Following block is the Name bar
  cp5.addBang("nameField") //a bang is a button that does not pass a value
     .setPosition(20,20)
     .setSize(80,30)
     .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
     ;
  inputField = cp5.addTextfield("inputField")
     .setPosition(550, 280)
     .setSize(80,40)
     .setFont(font)
     .hide()
     ;
  cp5.addBang("Yes")
     .setPosition(540, 350)
     .setSize(50, 30)
     .setFont(font)
     .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
     ;
  decisionParts[0] = cp5.getController("Yes");
  cp5.addBang("No")
     .setPosition(600, 350)
     .setSize(50, 30)
     .setFont(font)
     .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
     ;
  decisionParts[1] = cp5.getController("No");
  cp5.addTextlabel("DecisionLabel")
     .setPosition(510, 300)
     .setFont(font)
     .setText("Add More Effects?")
     .hide()
     ;
  decisionParts[2] = cp5.getController("DecisionLabel");
  for (Controller c : decisionParts) {
    c.hide();
  }
     
  initializeHP();
  initializeMP();
  cp5.addTextlabel("StamLabel")
     .setText("Stam")
     .setPosition(20, 120)
     .setFont(font)
     ;
  initializeStatusArea();
  
  
  
  
  textFont(font);
}

//draw occurs once per frame.
void draw() {
   background(0);
   int gridDimension = 20;
   for (int i = 0; i < width; i+= gridDimension) {
     line(i, 0, i, height);
   }
   for (int i = 0; i < height; i+= gridDimension) {
     line(0, i, width, i);
   }
   fill(255);
   ellipse(100, 180, 10, 10);
   ellipse(180, 205, 10, 10);
   stroke(255);
   drawStaminaBalls();
}

//create controller functions here by giving them the same name.
public void nameField() {
  inputField.show();
  inputField.setLabel("Name");
  requestedChange = "name";
}

public void inputField(String input) {
  int w;
  switch (requestedChange) {
    case "name":    cp5.getController("nameField").setLabel(input);
                    break;
    case "baseHP":  baseHP = Integer.parseInt(input); //this is dangerous.  Have to catch error.
                    //wat do when baseHP shrinks past current?
                    w = (int)((float)currentHP/(float)baseHP * (float)100);
                    cp5.getController("HPBarUpper").setSize(w,25);
                    cp5.get(Textlabel.class,"HPIndicator").setText(currentHP + "/" + baseHP);
                    break;
    case "baseMP":  baseMP = Integer.parseInt(input); //this is dangerous.  Have to catch error.
                    //wat do when baseHP shrinks past current?
                    //w = (int)((float)currentMP/(float)baseMP * (float)100);
                    //cp5.getController("MPBarUpper").setSize(w,25);
                    //cp5.get(Textlabel.class,"MPIndicator").setText(currentMP + "/" + baseMP);
                    updateLockedMP();
                    break;
    case "statusName": statusHolder = new StatusEffect(input);
                       requestedChange = "statusDescription";
                       inputField.setLabel("Status Description");
                       return;
    case "statusDescription": statusHolder.setDescription(input);
                              requestedChange = "duration";
                              inputField.setLabel("Duration");
                              return;
    case "duration": statusHolder.setDuration(Integer.parseInt(input));
                     requestedChange = "effectType";
                     inputField.setLabel("Effect Type");
                     return;
    case "effectType": inputHolder = input;
                       requestedChange = "effectMagnitude";
                       inputField.setLabel("Effect Magnitude");
                       return;
    case "effectMagnitude": statusHolder.addEffect(inputHolder, Integer.parseInt(input));
                            requestedChange = "moreEffects";
                            for (Controller c : decisionParts) {
                              c.show();
                            }
                            break;
                       
  }
  inputField.hide();
}




void keyPressed() {
  if (key=='r') {
    cp5.getController("nameField").hide();
  }
  if (key=='q') {
    cp5.getController("nameField").show();
  }
  if (key=='u') {
    updateStaminaBalls ();
  }
}
  
public void Yes () {
  makeDecision(true);
}
public void No () {
  makeDecision(false);
}
public void makeDecision(boolean d) {
  decision = d;
  switch (requestedChange) {
    case "moreEffects": if (d) {
                          requestedChange = "effectType";
                          inputField.setLabel("Effect Type");
                          inputField.show();
                        }
  }
  for (Controller c : decisionParts) {
    c.hide();
  }
}