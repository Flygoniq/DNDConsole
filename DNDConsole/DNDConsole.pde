import controlP5.*;

ControlP5 cp5;
String requestedChange, inputHolder;
Boolean decision;
int effectCount;
int currentHP, baseHP, STR, DEX, CON, INT, CHA, WIS; //these should be read from a character class later
StatusEffect[][] EffectsArray;
StatusEffect statusHolder;
PFont font;
Controller inputField;
Controller[] decisionParts = new Controller[3];

//create controllers in setup
void setup() {
  decision = false;
  currentHP = 7;
  baseHP = 10; //remove later********
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
  
  //Status Effect Business
  cp5.addTextlabel("Statuslabel")
     .setText("Status:")
     .setPosition(20, 170)
     .setFont(font)
     ;
  cp5.addBang("AddStatus")
     .setLabel(" +")
     .setPosition(5, 175)
     .setSize(15, 15)
     .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
     ;
  cp5.addTextarea("StatusInfoWindow")
     .setText("Ipsem Lorem")
     .setPosition(500, 230)
     .setSize(200,180)
     .setColorBackground(ControlP5.GRAY)
     //.hide()
     ;
  cp5.addBang("StatusInfoX")
     .setPosition(700, 230)
     .setSize(20, 20)
     .setLabel(" X")
     .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
     ;
  cp5.addBang("StatusRemoval")
     .setPosition(570, 400)
     .setSize(60, 25)
     .setLabel("Remove")
     .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
     ;
  
  
  
  
  textFont(font);
}

//draw occurs once per frame.
void draw() {
   background(0);
   ellipse(100, 170, 10, 10);
   ellipse(180, 195, 10, 10);
}

//create controller functions here by giving them the same name.
public void nameField() {
  inputField.show();
  inputField.setLabel("Name");
  requestedChange = "name";
}

public void inputField(String input) {
  switch (requestedChange) {
    case "name":    cp5.getController("nameField").setLabel(input);
                    break;
    case "baseHP":  baseHP = Integer.parseInt(input); //this is dangerous.  Have to catch error.
                    //wat do when baseHP shrinks past current?
                    int width = (int)((float)currentHP/(float)baseHP * (float)100);
                    cp5.getController("HPBarUpper").setSize(width,30);
                    cp5.get(Textlabel.class,"HPIndicator").setText(currentHP + "/" + baseHP);
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

public void HPBarLower() {
  inputField.show();
  inputField.setLabel("New Base HP");
  requestedChange = "baseHP";
}
public void HPBarUpper() {
  HPBarLower();
}

public void AddStatus () {
  inputField.show();
  inputField.setLabel("New Status Name");
  requestedChange = "statusName";
}

void keyPressed() {
  if (key=='r') {
    cp5.getController("nameField").hide();
  }
  if (key=='q') {
    cp5.getController("nameField").show();
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
public void StatusInfoX () {
  cp5.get(Textarea.class, "StatusInfoWindow").hide();
  cp5.getController("StatusInfoX").hide();
  cp5.getController("StatusRemoval").hide();
}
public void StatusRemoval () {
  statusHolder.destroy();
  cp5.get(Textarea.class, "StatusInfoWindow").hide();
  cp5.getController("StatusInfoX").hide();
  cp5.getController("StatusRemoval").hide();
}