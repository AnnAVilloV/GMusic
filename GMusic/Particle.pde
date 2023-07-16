final class Particle{
  PVector position = new PVector(0,0);
  PVector velocity = new PVector(0.1f,0.1f);
  float orientation = (float)random.nextDouble(-Math.PI, Math.PI);
  
  PVector wind = new PVector(0,0);
  private static final float DAMPING = 0.999f ;
  
  float radius = 10;
  
  int rTime;
  
  int alpha = 255;


  
  
  Jellyfish myJelly;
  
  Particle(Jellyfish j){
  
    this.myJelly = j;
    particleReset();
    rTime = millis();
  }
  
  void draw(){
    noStroke();
    integrate();
    fill(255,alpha);
    if(millis() - rTime >= 100){
      if(radius > 0){
        radius = radius - 0.1;
        alpha = alpha - 15;
        rTime = millis();
      }
    }

    circle(position.x,position.y,radius);
  }
  void particleReset(){
      radius = 10;
      alpha = 255;
      position = myJelly.position.copy();
      velocity = myJelly.velocity.copy();
      randomAngle();
  }
  
  void randomAngle(){
      PVector addVector = new PVector();
      int angle = random.nextInt(-180,181);
      float arc = (float)Math.toRadians(angle);
      float oldArc = atan2(velocity.y, velocity.x);
      arc = arc + oldArc;
      addVector.x = cos(arc) * 0.7;
      addVector.y = sin(arc) * 0.7;
      
      velocity = velocity.add(addVector);
  }
  
  void integrate(){
      velocity.mult(DAMPING);
      position.add(velocity);
  }

}