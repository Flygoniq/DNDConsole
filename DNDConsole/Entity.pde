//This class defines any interactable entity in the world
class Entity {
  Entity previous;
  String name;
  double weight;
  Attribute attributes;
  ArrayList<StatusEffect> status;
  ArrayList<Ability> abilities;
  
  void addStatus(StatusEffect s) {
    status.add(s);
  }
  
  void removeStatus(int num) {
    status.remove(num);
  }
  
  void addAbility(Ability a) {
    abilities.add(a);
  }
  
  void removeAbility(Ability a) {
    abilities.remove(a);
  }
  
  void nextTurn() {
    //fix Janet
  }
  
  void undo() {
    this.previous = previous.previous;
    this.name = previous.name;
    this.weight = previous.weight;
    this.attributes = previous.attributes;
    this.status = previous.status;
    this.abilities = previous.abilities;
  }
  
  void exportFile() {
    //fix Janet
  }
  
  void importFile(String fn) {
    //do stuff, fix Janet
  }
  
}