class Attribute {
  int level;
  int maxLife;
  int currentLife;
  int maxMana;
  int currentMana;
  int maxStamina;
  int currentStamina;
  int lockedStamina;
  int overchargeStamina;
  float[] armourClass; /* 0.Phys 1.Slash 2.Pierce 3.Crush
                          4.Mahou 5.Fire 6.Water 7.Light 8.Wind 9.Earth
                          10.Fort 11.Elec 12.Burn 13.Mental
                          14.Divine
                          15.Other
                          */
  int[][] primary,  // 4*6 [0.STR, DEX, CHA, INT, WIS, CON; 1.base mod; 2.temp mod; 3.total mod]
          secondary;  /* STR: 0.Swim 1.Climb 2.ResistPhys
                       DEX: 3.Initiative 4.Acrobatics 5.Stealth 6.SleightOfHand
                       CHA: 7.GatherInfo 8.Intimidate 9.Diplo 10.Bluff
                       INT: 11.Search 12.KnMachine 13.KnMagic 14.KnHistory 15.KnReligion 16.KnGeography 17.KnBeastiary 18.KnOther
                       WIS: 19.Perception 20.ResistMagic
                       CON: 21.Focus 22.ResistAilment
                       */
  
  Attribute() {
    level = 1;
    maxLife = 5;
    currentLife = maxLife;
    maxMana = 0;
    currentMana = maxMana;
    maxStamina = 5;
    currentStamina = 0;
    lockedStamina = 0;
    overchargeStamina = 0;
    armourClass = new float[16];
    primary = new int[6][4];
    secondary = new int[6][];
  }
  
  void updateMod() {
    for (int[] stat : primary) {
      stat[3] = stat[1] + stat[2]
    }
  }
  
  void calcMod() {
    for (int[] stat : primary) {
      if (stat[0] <= 20) {
        stat[1] = -5 + stat[0]/2;
      } else if (stat[0] <= 35) {
        stat[1] = 5 + (stat[0]-20)/3;
      } else if (stat[0] <= 55) {
        stat[1] = 5 + (stat[0]-35)/4;
      } else if (stat[0] <= 80) {
        stat[1] = 5 + (stat[0]-55)/5;
      } else if (stat[0] <= 110) {
        stat[1] = 5 + (stat[0]-80)/6;
      } else if (stat[0] <= 140) {
        stat[1] = 5 + (stat[0]-110)/7;
      } else if (stat[0] <= 175) {
        stat[1] = 5 + (stat[0]-140)/8;
      } else if (stat[0] <= 215) {
        stat[1] = 5 + (stat[0]-20)/9;
      } else {
        stat[1] = 40;
      }
    }
    updateMod();
  }
  
  void changeTempMod(int stat, int val) {
    primary[stat][2] = val;
  }
  
}