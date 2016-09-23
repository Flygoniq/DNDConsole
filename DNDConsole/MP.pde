int coveredMP = 0;
Controller MPCover;
void initializeMP () {
  cp5.addTextlabel("MPLabel")
     .setText("MP")
     .setPosition(20, 90)
     .setFont(font)
     ;
  cp5.addBang("MPBarLower")
     .setPosition(60, 90)
     .setSize(100, 25)
     .setLabel("")
     ;
  cp5.addBang("MPBarUpper")
     .setPosition(60, 90)
     .setSize(50, 25)
     .setLabel("")
     .setColorActive(ControlP5.RED)
     .setColorForeground(ControlP5.RED)
     ;
  MPCover = cp5.addBang("MPBarCover")
     .setPosition(60, 90)
     .setSize(0, 0)
     .setLabel("")
     .setColorActive(ControlP5.GRAY)
     .setColorForeground(ControlP5.GRAY)
     ;
  cp5.addTextlabel("MPIndicator")
     .setText("10/20")
     .setPosition(90, 90)
     .setFont(font)
     ;
  cp5.addTextlabel("LockedMPIndicator")
     .setText("30%")
     .setPosition(160, 90)
     .setFont(font)
     ;
}

public void MPBarLower() {
  inputField.show();
  inputField.setLabel("New Base MP");
  requestedChange = "baseMP";
}
public void MPBarUpper() {
  MPBarLower();
}
public void MPBarCover() {
  MPBarLower();
}
public void updateLockedMP() {
  int w = (int)((float)currentMP/(float)baseMP * (float)100);
  cp5.getController("MPBarUpper").setSize(w,25);
  cp5.get(Textlabel.class,"MPIndicator").setText(currentMP + "/" + baseMP);
  if (lockedMP == 0) return;
  effectiveMP = ((int)((1 - lockedMP) * (float) baseMP));
  coveredMP = baseMP - effectiveMP;
  if (currentMP > effectiveMP) {
    currentMP = effectiveMP; 
    w = (int)((float)currentMP/(float)baseMP * (float)100);
    cp5.getController("MPBarUpper").setSize(w,25);
    cp5.get(Textlabel.class,"MPIndicator").setText(currentMP + "/" + baseMP);
  }
  w = (int)((float)coveredMP/(float)baseMP * (float)100);
  MPCover.setPosition(60 + (100 - w), 90);
  MPCover.setSize(w, 25);
}