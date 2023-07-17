final float ORIENTATION_INCREMENT = PI/32 ;

class Jellyfish{
//test
float dis = Float.MAX_VALUE;
  
  
  PVector position = new PVector(0,0);  
  float orientation = (float)random.nextDouble(-Math.PI, Math.PI);
  PVector velocity = new PVector(0.1f,0.1f);
  PVector aim;
  float floatIncrement = 0.2f;
  float roamIncrement = 0.4f;
  float chaseIncrement = 0.6f;
  
  //music set
  ArrayList<AudioSample> noteSet = new ArrayList<AudioSample>();
  int noteTime;
  
  //Bioinformatics
  int age = 1; //kid1,young2,adult3,old4
  int grams;
  int growTime;
  boolean isPairable = false;
  
  
  //roam: moving with aim; float: float, or float with water(to be set); chase: when feed food
  String state = "float";
  int floatStartTime;
  int floatTime;
  int roamStartTime;
  int roamTime;
  boolean isfloat = false;
  boolean isHit = false;
  int lastAngleTime;

  //food and chase
  boolean foundFood = false;
  Food myFood;

  //visual effect
  ArrayList<Particle> particleList = new ArrayList<Particle>();
  int particleTime;
  
  //interaction
  boolean overJelly = false;
  boolean isdrag = false;
  
  Jellyfish( int age){
    
    //chaseIncrement = chaseInc;
    
    this.position = randomPosition().copy();
    this.aim = randomPosition().copy();
    
    //bio set
    this.grams = random.nextInt(1,8);
    this.growTime = millis();
    this.age = age;
    
    //music set
    if(age == 1 || age == 2)
      noteSet.addAll(lofiMinorF6s);
    else 
      noteSet.addAll(lofiMinorF5s);
    this.noteTime = millis();
    
    this.lastAngleTime = millis();
    
    //particles set
    for(int i = 0; i < 5; i++){
      particleList.add(new Particle(this));
    }
    this.particleTime = millis();
  }
  
  
  void draw(){
    move();
    
    if(age < 4) //old jelly don't eat
      foodDetect();
    
    updateBioState();
    
    //test color set
    if(state == "chase")
      fill(#FFCE29);
    else if(isPairable)
        fill(#FF8EC6);
    else if(isfloat)
      fill(#E01705);
    else
      fill(JELLYFISH);
    
    updateMusic();
    
    
    //draw the jellyfish
    // Test if the cursor is over the jelly 
      if (mouseX > position.x -50 && mouseX < position.x + 50 && 
          mouseY > position.y -50 && mouseY < position.y + 50) {
        overJelly = true;  
      } else {
        overJelly = false;
      }
      
      if(isdrag) {
        position.x = mouseX;
        position.y = mouseY;
        //velocity.x = 0;
        //velocity.y = 0;
      }
      
        //image(jelly, position.x,position.y);
    circle(position.x,position.y, 35);
    int x = (int)(position.x + 10 * cos(orientation));  
    int y = (int)(position.y + 10 * sin(orientation));
    fill(0);
    circle(x,y,10);
    
    
    updateParticles();
    for(Particle p : particleList){
      p.draw();
    }
    
    
    fill(0);
    textSize(20);
    text(grams,position.x,position.y);
   
  }
  
  void updateParticles(){
    if(age == 1){
       if(millis() - particleTime >= 1000){
         resetParticles();
         particleTime = millis();
       }
    }else{
       if(millis() - particleTime >= 2000){
         resetParticles();
         particleTime = millis();
       }
    }
  }
  
  void resetParticles(){
    for(Particle p : particleList){
      p.particleReset();
    }
  }
  
  void updateMusic(){    
      //note trigger
      if(age == 1 ){
        if (millis() - noteTime >= 1000){
          //if(state != "float"){
            this.noteSet.get(random.nextInt(0, noteSet.size())).trigger();
            noteTime = millis();
          //}
        }
      }else if(age == 2){
         if (millis() - noteTime >= 2000){
            //if(state != "float"){
              this.noteSet.get(random.nextInt(0, noteSet.size())).trigger();
              noteTime = millis();
            //}
         }
      }else if(age == 3){
        if (millis() - noteTime >= 2000){
            this.noteSet.get(random.nextInt(0, noteSet.size())).trigger();
            noteTime = millis();
        }
      }else{
        if (millis() - noteTime >= 2000){
          if(mood == "calm")
            autoChord(lofi1, this.noteSet.get(random.nextInt(0, noteSet.size())));
          else
            autoChord(lofi2, this.noteSet.get(random.nextInt(0, noteSet.size())));
            noteTime = millis();
        }
      }
  }
  
  void updateBioState(){
    //naturally gaining weight
    if (millis() - growTime >= 1000 && grams < 30){
        this.grams++;
        growTime = millis();
    }
    //age update
    //if(grams >= 10 && age == 1){
    //  age = 2;
    //  //this.noteSet = (ArrayList<AudioSample>)naturalM5.clone();
    //}else if(grams >= 20 && age == 2){
    //  age = 3;
    //  //this.noteSet = (ArrayList<AudioSample>)naturalM4.clone();
    //  isPairable = true; 
    //}
  }
  

  
  
  
  void stateSwitcher(){
    //after roam, float for some time.
    //roam, then high possibility to float;
    //float, then some possibility to roam.
    if(state == "roam"){
      if(millis() - roamStartTime >= roamTime){
        state = "float";
        floatStartTime = millis();
        floatTime = random.nextInt(10,15) * 1000;
      }
    }else if(state == "float"){
      isfloat = true;
      if (millis() - floatStartTime >= floatTime){
        state = "roam";
        roamStartTime = millis();
        roamTime = random.nextInt(8,11) * 1000;
        angleSelect();
        //noteTime = millis();
        isfloat = false;
      }
    }
    //if a food was fed, and is in detect range, switch to chase
    if(state != "chase" && foundFood){
      state = "chase";
    }
    if(state == "chase" && !foundFood){
      state = "roam";
    }
  }
  
  void angleSelect(){
      int angle = random.nextInt(-60,61);
      float arc = (float)Math.toRadians(angle);
      float oldArc = atan2(velocity.y, velocity.x);
      arc = arc + oldArc;
      velocity.x = cos(arc);
      velocity.y = sin(arc);
  }

  void move(){
    integrate();
    stateSwitcher();
  }
  
  void foodDetect(){
    if(!foundFood){
      for(Food f : foods){  
        if(f.stillExist){
          dis = PVector.dist(this.position, f.position);        
          if(dis < 150){
            foundFood = true;
            noteSet.clear();
            noteSet.addAll(syMinorF5s);
            myFood = f;
            break;
          }
        }
      }
    }else{
      if(myFood != null && myFood.stillExist){
        //out of distance, quit
        dis = PVector.dist(this.position, myFood.position);
        if(dis >= 150)
          foundFood = false;
        else if(dis <= 30){
          this.grams += 5;
          myFood.stillExist = false;
          foundFood = false;
        }
      }else{
        foundFood = false;
      }
     
      if(!foundFood){      //reset noteset
        noteSet.clear();
        if(age == 1)
          noteSet.addAll(lofiMinorF6s);
        else if(age == 2)
          noteSet.addAll(lofiMinorF6s);
        else 
          noteSet.addAll(lofiMinorF5s);
      }
    }
  }

  
  void integrate(){
      hitHandling();
      if(state == "roam")
        velocity = velocity.normalize().mult(roamIncrement);
      else if(state == "float")
        velocity = velocity.normalize().mult(floatIncrement);        
      else if(state == "chase"){
        PVector toTarget = new PVector(myFood.position.x - position.x, myFood.position.y - position.y);
        velocity = toTarget.normalize().mult(chaseIncrement);
      }
      PVector realVel = velocity.copy();
      realVel.add(current);
      position.add(realVel);
      

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

  void hitHandling(){
    if(position.x < 35){
      position.x = 35;
      velocity.x = 0;
      isHit = true;
    }else if(position.x > width - 35){
      position.x = width - 35;
      velocity.x = 0;
      isHit = true;
    }else if(position.y < 35){
      position.y = 35;
      velocity.y = 0;
      isHit = true;
    }else if(position.y > height - 35){
      position.y = height - 35;
      velocity.y = 0;
      isHit = true;
    }
   
    if(isHit && millis() - lastAngleTime > 2000){
      angleSelect();
      lastAngleTime = millis();
      isHit = false;
    }
  }

}
