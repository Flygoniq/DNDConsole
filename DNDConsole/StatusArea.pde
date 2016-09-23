void initializeStatusArea () {
  //Status Effect Business
  cp5.addTextlabel("Statuslabel")
     .setText("Status:")
     .setPosition(20, 180)
     .setFont(font)
     ;
  cp5.addBang("AddStatus")
     .setLabel(" +")
     .setPosition(5, 185)
     .setSize(15, 15)
     .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
     ;
  cp5.addTextarea("InfoWindow")
     .setText("Ipsem Lorem")
     .setPosition(500, 230)
     .setSize(200,180)
     .setColorBackground(ControlP5.GRAY)
     .hide()
     ;
  cp5.addBang("InfoX")
     .hide()
     .setPosition(700, 230)
     .setSize(20, 20)
     .setLabel(" X")
     .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
     ;
  cp5.addBang("StatusRemoval")
     .setPosition(570, 400)
     .hide()
     .setSize(60, 25)
     .setLabel("Remove")
     .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
     ;
}

public void AddStatus () {
  inputField.show();
  inputField.setLabel("New Status Name");
  requestedChange = "statusName";
}
public void InfoX () {
  cp5.get(Textarea.class, "InfoWindow").hide();
  cp5.getController("InfoX").hide();
  cp5.getController("StatusRemoval").hide();
}
public void StatusRemoval () {
  statusHolder.destroy();
  cp5.get(Textarea.class, "InfoWindow").hide();
  cp5.getController("InfoX").hide();
  cp5.getController("StatusRemoval").hide();
}