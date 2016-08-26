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
  void addEffect (String effectType, int magnitude) {
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
  
  void tick() {//decrease duration, kill if 0.  Cause effects.
    for (int i = 0; i < size; i++) {
      if (effects[i] == "HP") {
        currentHP += magnitude[i];
      }
    }
  }
  
  void destroy() {
    effectCount--;
    EffectsArray[x][y] = null;
    statusBang.remove();
    //also clear out array
  }
  
  String makeString() {
    String answer = "";
    answer += "Name: " + name + "\n";
    answer += "Description: " + description + "\n";
    for (int i = 0; i < size; i++) {
      answer+= "Effect: " + effects[i] + ", Magnitude: " + magnitude[i] + "\n";
    }
    return answer;
  }
  
  void setName (String name) {
    this.name = name;
  }
  String getName () {
    return name;
  }
  void setDescription (String desc) {
    description = desc;
  }
  String getDescription () {
    return description;
  }
  void setDuration (int dur) {
    duration = dur;
  }
  int getDuration () {
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