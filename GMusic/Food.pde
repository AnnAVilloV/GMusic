class Food{
  
  //movement relys on water flow and gravity
  PVector position = new PVector(0,0);  
  PVector velocity = new PVector(0.1f,0.1f);
  private final PVector gravity = new PVector(0f,0.001f) ;
  PVector wind = new PVector(0,0);
  private static final float DAMPING = 0.999f ;
    
  //state
  boolean stillExist = true;
    
  //music set
  ArrayList<AudioSample> noteSet = new ArrayList<AudioSample>();
  int noteTime;
  int count = 0;
  
  //drag function
  boolean overFood = false;
  boolean isdrag = false;
  
  Food(){}
  
  Food(float x, float y){
    position.x = x;
    position.y = y;
    
    noteSet.addAll(syMinorF5s);
    count = noteSet.size()-1;
  }
  
  void draw(){    
    integrate();
    fill(255);
    noStroke();
    circle(position.x,position.y,15);
    
      if (mouseX > position.x -50 && mouseX < position.x + 50 && 
          mouseY > position.y -50 && mouseY < position.y + 50) {
        overFood = true;  
      } else {
        overFood = false;
      }
      if(isdrag){
        position.x = mouseX;
        position.y = mouseY;
      }
    
    //note trigger
      if (millis() - noteTime >= 3000){
          if(count >= 0){
            this.noteSet.get(count).trigger();
            count--;
            noteTime = millis();
        }
      }
      removeFood();
  }
  
  void removeFood(){
      if (mouseX > position.x -50 && mouseX < position.x + 50 && 
        mouseY > position.y -50 && mouseY < position.y + 50) {
        if(mousePressed && mouseButton == RIGHT)
           foods.remove(this);
      } 
  }

  
  void integrate(){
    velocity.add(gravity);
    velocity.add(wind);
    velocity.mult(DAMPING);
    position.add(velocity);
    if ((position.x < 10) || (position.x > width-10)) velocity.x = -0.30*velocity.x ;
    if ((position.y < 10) || (position.y > height-10)) velocity.y = -0.50*velocity.y ;   
    resetWhenHit();
  }

  void resetWhenHit(){
    if(position.x < 80)
      position.x = 80;
    if(position.x > width - 80)
      position.x = width - 80;
    if(position.y < 80)
      position.y = 80;
    if(position.y > height - 190)
      position.y = height - 190;
  }
  
  void eat(Jellyfish j){
    j.grams += 5;
  }
  
  void dragFunction(){
      if (mouseX > position.x -50 && mouseX < position.x + 50 && 
          mouseY > position.y -50 && mouseY < position.y + 50) {
        overFood = true;  
      } else {
        overFood = false;
      }
      if(isdrag){
        position.x = mouseX;
        position.y = mouseY;
      }
  }

}
