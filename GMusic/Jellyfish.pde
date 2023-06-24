final float ORIENTATION_INCREMENT = PI/32 ;

class Jellyfish{

  PVector position = new PVector(0,0);  
  float orientation = 0f;
  PVector velocity = new PVector(0.1f,0.1f);
  PVector aim;
  int roamIncrement ;
  int chaseIncrement ;
  
  //music set
  ArrayList<AudioSample> noteSet = new ArrayList<AudioSample>();
  int noteTime;
  
  //Bioinformatics
  int age = 1; //kid1,young2,adult3,old4
  int grams;
  int growTime;
  boolean isPairable = false;
  
  
  //roam: moving with aim; float: stay, or float with water(to be set); chase: when feed food
  String state = "roam";
  int startTime;
  int stayTime = 3000;
  boolean isStay = false;
  
  
  
  Jellyfish(int roamInc, int chaseInc, int age){
    roamIncrement = roamInc;
    chaseIncrement = chaseInc;
    this.position = randomPosition().copy();
    this.aim = randomPosition().copy();
    
    //bio set
    this.grams = random.nextInt(1,8);
    this.growTime = millis();
    
    this.age = age;
    
    //music set
    //testcode
    if(age == 1)
      noteSet.addAll(lofiMinorF6s);
    else if(age == 2)
      noteSet.addAll(lofiMinorF5s);
    else 
      noteSet.addAll(lofiMinorF5s);
      
    this.noteTime = millis();
    
    
  }
  
  
  void draw(){
    move();
    //updateBioState();
    
    //test color set
    if(isStay){
      fill(#E01705);
    }else{
      if(isPairable)
        fill(#FF8EC6);
      else
        fill(JELLYFISH);
    }


    //note trigger
    if(age == 1 ){
      if (millis() - noteTime >= 1000){
        if(state != "stay"){
          this.noteSet.get(random.nextInt(0, noteSet.size())).trigger();
          noteTime = millis();
        }
      }
    }else if(age == 2){
       if (millis() - noteTime >= 2000){
          if(state != "stay"){
            this.noteSet.get(random.nextInt(0, noteSet.size())).trigger();
            noteTime = millis();
          }
       }
    }else if(age == 3){
      if (millis() - noteTime >= 2000){
          //this.noteSet.get(random.nextInt(0, noteSet.size())).trigger();
        //if(state != "stay"){
          autoChord(lofi1, this.noteSet.get(random.nextInt(0, noteSet.size())));
          noteTime = millis();
        //}
      }
    }else{
      if (millis() - noteTime >= 4000){
          autoChord(lofi1, this.noteSet.get(random.nextInt(0, noteSet.size())));
          noteTime = millis();
      }
    }
    


    //draw the jellyfish
    circle(position.x,position.y, 35);
    int x = (int)(position.x + 10 * cos(orientation));  
    int y = (int)(position.y + 10 * sin(orientation));
    fill(0);
    circle(x,y,10);
    
    fill(0);
    textSize(20);
    text(grams,position.x,position.y);
  
  }
  
  void updateBioState(){
    //naturally gaining weight
    if (millis() - growTime >= 1000 && grams < 30){
        this.grams++;
        growTime = millis();
    }
    
    //age update
    if(grams >= 10 && age == 1){
      age = 2;
      //this.noteSet = (ArrayList<AudioSample>)naturalM5.clone();
    }else if(grams >= 20 && age == 2){
      age = 3;
      //this.noteSet = (ArrayList<AudioSample>)naturalM4.clone();
      isPairable = true; 
    }
  }
  
  
  
  void stateSwitcher(){
    //after roam, float for some time.
    //roam, then high possibility to float;
    //float, then some possibility to roam.
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
        noteTime = millis();
        isStay = false;
      }
    }    
    
    //if a food was fed, and is in detect range, switch to chase
  
  }


  void move(){
    if(state == "roam"){
      roam();
    }else if(state == "chase"){
      chase();
    }else{
      stay();
      
    }
    stateSwitcher();
  }
  
  void stay(){
  }
  
  void roam(){
        PVector toTarget = new PVector(aim.x - position.x, aim.y - position.y);
        this.integrate(toTarget);
  }  
  
  void chase(){
    // if(human.atRoom == this.atRoom){
    //   PVector toTarget = new PVector(human.position.x - position.x, human.position.y - position.y);
    //   this.integrate(toTarget);
    //   if(calculate2PointDis(human.position.x,human.position.y,this.position.x,this.position.y) <= 10f){
    //     human.status = "fight";
    //     nowCombat = new Combat(this);
    //   }
    // }else{
    //   state = "roam";
    // }
  }
  
  void integrate(PVector toTarget){
    float distance = toTarget.mag();
          
    velocity = toTarget.copy();
    
    if(state == "roam"){
      if(distance > roamIncrement){
      //adjust velocity
      velocity = velocity.normalize().mult(roamIncrement);
      }
    }else if(state == "chase"){
      if(distance > chaseIncrement){
      //adjust velocity
      velocity = velocity.normalize().mult(chaseIncrement);
      }
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
  
    PVector randomPosition(){
    PVector p = new PVector();

    p.x = random.nextInt(35, screenWidth-35);
    p.y = random.nextInt(35, screenHeight-35);
    return p;
  }

}
