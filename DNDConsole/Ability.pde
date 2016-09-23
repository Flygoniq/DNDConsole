/*class Ability {
  int cooldown, currCooldown;
  int timer, currTimer;
  int manaCost, healthCost, stamCost, espCost;
  int currCharge, maxCharge;
  boolean onCooldown, onRecharge;
  String tooltip;
  
  Ability(int cd, int timer, int mCost, int hCost, int sCost, int pCost, int charges, String t) {
    cooldown = cd;
    this.timer = timer;
    manaCost = mCost;
    healthCost = hCost;
    stamCost = sCost;
    espCost = pCost;
    maxCharge = charges;
    currCharge = maxCharge;
    onCooldown = false;
    onRecharge = false;
    tooltip = t;
  }
  
  //Return 
  int[] useAbility(int mana, int health) {
    //Check if player has enough mana
    if (mana - manaCost < 0) {
      return new int[] {-1};
    }
    //Check if player has enough health
    if (health - healthCost < 0) {
      return new int[] {-2};
    }
    //Check if Ability has enough charges
    if (maxCharge > 0) {
      if (currCharge > 0) {
        useCharge();
      }
      onCooldown = true;
      return new int[] {manaCost, healthCost, stamCost, espCost};
    } else if (maxCharge == 0) {
      onCooldown = true;
      return new int[] {manaCost, healthCost, stamCost, espCost};
    } else {
      return new int[] {-3};
    }
  }
  
  
  void updateAbility() {
    if (onCooldown) {
      stepCooldown();
      if (currCooldown == 0) {
        resetCooldown();
      }
    }
    if (maxCharge > 0) {
      if (onRecharge) {
        stepTimer();
        if (currTimer == 0) {
          addCharge();
        }
        if (currCharge == maxCharge) {
          resetTimer();
        } else {
          setTimer();
        }
      }
    }
  }
  
  void setCooldown(int num) {
    cooldown = num;
  }
  
  int getCooldown() {
    return currCooldown;
  }
  
  void resetCooldown() {
    onCooldown = false;
    currCooldown = cooldown;
  }
  
  void stepCooldown() {
    currCooldown = currCooldown - 1;
  }
  
  void setTimer(int num) {
    onRecharge = true;
    timer = num;
  }
  
  void startTimer() {
    currTimer = timer;
  }
  
  int getTimer() {
    return timer;
  }
  
  int getCurrTimer() {
    return currTimer;
  }
  
  void resetTimer() {
    currTimer = timer;
  }
  
  void stepTimer() {
    currTimer = currTimer - 1;
  }

  int getCurrCharge() {
    return currCharge;
  }
  
  void addCharge() {
    currCharge = currCharge + 1;
  }
  
  void useCharge() {
    currCharge = currCharge - 1;
    setTimer();
  }
  
  void setTooltip(String s) {
    tooltip = s;
  }
  
  String getTooltip() {
    return tooltip;
  }
  
}*/