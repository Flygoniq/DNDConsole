import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import controlP5.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class DNDConsole extends PApplet {



ControlP5 cp5;
String requestedChange, input;
Boolean decision;
int effectCount;
int currentHP, baseHP, STR, DEX, CON, INT, CHA, WIS; //these should be read from a character class later
StatusEffect[][] EffectsArray;
StatusEffect newStatus;
PFont font;
Controller inputField;

//create controllers in setup
public void setup() {
  decision = false;
  currentHP = 7;
  baseHP = 10; //remove later********
  effectCount = 0;
  
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
     //.hide()
     ;
  cp5.addBang("Yes")
     .setPosition(540, 350)
     .setSize(50, 30)
     .setFont(font)
     .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
     //.hide()
     ;
  cp5.addBang("No")
     .setPosition(600, 350)
     .setSize(50, 30)
     .setFont(font)
     .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
     //.hide()
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
     .setPosition(550, 280)
     .setSize(200,200)
     .hide()
     ;
  
  
  
  
  textFont(font);
}

//draw occurs once per frame.
public void draw() {
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
    case "statusName": newStatus = new StatusEffect(input);
                       requestedChange = "statusDescription";
                       inputField.setLabel("Status Description");
                       return;
    case "statusDescription": newStatus.setDescription(input);
                              requestedChange = "duration";
                              return;
    case "duration": newStatus.setDuration(Integer.parseInt(input));
                     requestedChange = "Effect Type";
  }
  cp5.getController("inputField").hide();
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

public void keyPressed() {
  if (key=='r') {
    cp5.getController("nameField").hide();
  }
  if (key=='q') {
    cp5.getController("nameField").show();
  }
  
  
}
class StatusEffect {
  String description, name, ID; //name is the summary, effect is a list of specific status changes
  int size, duration;
  int[] magnitude, followupCalls; //followup calls contains numbers.  Whenever a number hits zero, its corresponding followup should be created.
  String[] effects;
  StatusEffect[] followups;
  Bang statusBang;
  CallbackListener StatusCallback;
  int x, y;;
  
  public StatusEffect (String name) {
     effectCount++;
     this.name = name;
     x = (effectCount - 1) % 3;
     y = (effectCount - 1) / 3;
   /*search:
     for (; x < 3; x++) {
        for (; y < 3; y++) {
          if (EffectsArray[x][y] == null) {
            break search;
          }
        }
     }*/
     ID = name + x + y;
     String labeltext;
     if (name.length() > 10) {
       labeltext = name.substring(0, 7) + "...";
     } else {
       labeltext = name;
     }
     
     StatusCallback = new CallbackListener() {
       public void controlEvent(CallbackEvent theEvent) {
         switch(theEvent.getAction()) {
           case(ControlP5.ACTION_ENTER):
             cp5.get(Textarea.class, "StatusInfoWindow").setText(makeString()).show();
             break;
           case(ControlP5.ACTION_LEAVE):
             cp5.get(Textarea.class, "StatusInfoWindow").hide();
             break;
         }
       }
     };
     
     
     statusBang = cp5.addBang(name)
                     .setSize(130, 25)
                     .setPosition(100 + (140 * x), 170 + (35 * y))//would probably be best to base this off location of status label
                     .setLabel(labeltext)
                     .setFont(font)
                     .setColorActive(ControlP5.BLUE)
                     .setColorForeground(ControlP5.BLUE)
                     .addCallback(StatusCallback)
                     ;
     println(x); println(y);
     EffectsArray[x][y] = this;
  }
  
  public StatusEffect (String name, String description) {
    this(name);
    this.description = description;
    duration = 0;
    magnitude = new int[10];
    effects = new String[10];
    size = 0;
  }
  public StatusEffect (String name, String description, StatusEffect[] followups, int[] followupCalls) {
    this(name, description);
    duration = 0;
    magnitude = new int[10];
    effects = new String[10];
    size = 0;
    this.followups = followups;
    this.followupCalls = followupCalls;
  }
  public void addEffect (String effectType, int magnitude) {
    if (effectType == "STR") {
      STR += magnitude;
    } else if (effectType == "DEX") {
      DEX += magnitude;
    } else if (effectType == "CON") {
      CON += magnitude;
    } else if (effectType == "INT") {
      INT += magnitude;
    } else if (effectType == "CHA") {
      CHA += magnitude;
    } else if (effectType == "WIS") {
      WIS += magnitude;
    }
    effects[size] = effectType;
    this.magnitude[size++] = magnitude;
  }
  
  public void tick() {//decrease duration, kill if 0.  Cause effects.
    for (int i = 0; i < size; i++) {
      if (effects[i] == "HP") {
        currentHP += magnitude[i];
      }
    }
  }
  
  public void destroy() {
    effectCount--;
    EffectsArray[x][y] = null;
    statusBang.remove();
    //also clear out array
  }
  
  public String makeString() {
    String answer = "";
    answer += "Name: " + name + "\n";
    answer += "Description: " + description + "\n";
    for (int i = 0; i < size; i++) {
      answer+= "Effect: " + effects[i] + ", Magnitude: " + magnitude[i] + "\n";
    }
    return answer;
  }
  
  public void setName (String name) {
    this.name = name;
  }
  public String getName () {
    return name;
  }
  public void setDescription (String desc) {
    description = desc;
  }
  public String getDescription () {
    return description;
  }
  public void setDuration (int dur) {
    duration = dur;
  }
  public int getDuration () {
    return duration;
  }
}




/* List of effect codes:
     MaxHP
     HP
     MaxMana
     Mana
     MaxStamina
     Stamina
     STR
     DEX
     CON
     INT
     CHA
     WIS


*/
  public void settings() {  size(1200,600); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "DNDConsole" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
