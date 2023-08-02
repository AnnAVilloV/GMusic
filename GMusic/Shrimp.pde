
class Shrimp extends Food{
  PVector aim;
  String state = "roam";
  int startTime;
  int stayTime = 3000;
  boolean isStay = false;
  float orientation = 0f;
  float foodIncrement = 0.5f;
  
  Shrimp(float x, float y){
    this.position.x = x;
    this.position.y = y;
    this.aim = randomPosition().copy();
  }

  void draw(){
    if(state == "roam"){
      integrate();
    }
    stateSwitcher();
    
    if(state == "roam"){
      if(orientation > -PI/2 && orientation < PI/2 )
        image(shrimpMoveR, position.x,position.y);
      else
        image(shrimpMoveL, position.x,position.y);
    }else{
      if(orientation > -PI/2 && orientation < PI/2 )
        image(shrimpStillR, position.x,position.y);
      else
        image(shrimpStillL, position.x,position.y);
    }
    dragFunction();
    removeFood();
  }
  
  void stateSwitcher(){
    if(state == "roam"){
      if(position.x == aim.x && position.y == aim.y){
        state = "stay";
        startTime = millis();
        aim = randomPosition().copy();
      }
    }else if(state == "stay"){
      isStay = true;
      if (millis() - startTime >= stayTime){
        state = "roam";
        isStay = false;
      }
    }    
  }
  
  void integrate(){
    resetWhenHit();
    PVector toTarget = new PVector(aim.x - position.x, aim.y - position.y);
    float distance = toTarget.mag();
    velocity = toTarget.copy();
    if(distance > foodIncrement){
      velocity = velocity.normalize().mult(foodIncrement);
    }
    position.add(velocity);
    
    //get orientation
    float targetOri = atan2(velocity.y, velocity.x);
    if(abs(targetOri - orientation) <= ORIENTATION_INCREMENT){
      orientation = targetOri;
      return;
    }
    
    //adjust orientation
    if(targetOri < orientation){
      if(orientation - targetOri < PI){
        orientation -= ORIENTATION_INCREMENT ;
      }else{
        orientation += ORIENTATION_INCREMENT ;
      }
    }else{
      if(orientation - targetOri < PI){
        orientation += ORIENTATION_INCREMENT ;
      }else{
        orientation -= ORIENTATION_INCREMENT ;
      }
    }
    
    //make it no spining
     if (orientation > PI) 
       orientation -= 2*PI ;
     else if (orientation < -PI) 
       orientation += 2*PI ;  
  }
  
  void eat(Jellyfish j){
    j.grams = 30;
    j.isPink = true;
  }

}
