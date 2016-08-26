class StatusEffect {
  String description, name, ID; //name is the summary, effect is a list of specific status changes
  int size, duration;
  int[] magnitude, followupCalls;
  String[] effects;
  StatusEffect[] followups;
  Bang statusBang;
  
  public StatusEffect (String name) {
     this.name = name;
     int x = (effectCount - 1) % 3;
     int y = (effectCount - 1) / 3;
   /*search:
     for (; x < 3; x++) {
        for (; y < 3; y++) {
          if (EffectsArray[x][y] == null) {
            break search;
          }
        }
     }*/
     ID = name + x + y;
     statusBang = cp5.addBang(name)
                     .setPosition(100 + (80 * x),100 + (20 * y))
                     ;
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
    if (effectType == "str") {
       effects[size] = "STR";
       this.magnitude[size] = magnitude;
    }
  }
  
  void tick() {//decrease duration, kill if 0.  Cause effects.
    
  }
  
  void destroy() {
    
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