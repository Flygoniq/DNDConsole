void initializeHP () {
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
     .setSize(100, 25)
     .setLabel("")
     ;
  cp5.addBang("HPBarUpper")
     .setPosition(60, 60)
     .setSize(70, 25)
     .setLabel("")
     .setColorActive(ControlP5.RED)
     .setColorForeground(ControlP5.RED)
     ;
  cp5.addTextlabel("HPIndicator")
     .setText("7/10")
     .setPosition(90, 60)
     .setFont(font)
     ;
}

public void HPBarLower() {
  inputField.show();
  inputField.setLabel("New Base HP");
  requestedChange = "baseHP";
}
public void HPBarUpper() {
  HPBarLower();
}