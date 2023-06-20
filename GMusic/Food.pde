class Food{
  
  //movement relys on water flow and gravity
  PVector position = new PVector(0,0);  
  PVector velocity = new PVector(0.1f,0.1f);
  private final PVector gravity = new PVector(0f,0.001f) ;
  PVector wind = new PVector(0,0);
  private static final float DAMPING = 0.999f ;
    
  Food(int x, int y){
    position.x = x;
    position.y = y;
  }
  
  void draw(){
    integrate();
    fill(255);
    noStroke();
    circle(position.x,position.y,15);
    
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
    if(position.x < 10)
      position.x = 10;
    if(position.x > width - 10)
      position.x = width - 10;
    if(position.y < 10)
      position.y = 10;
    if(position.y > height - 10)
      position.y = height - 10;
  }

}
