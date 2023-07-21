final float ORIENTATION_INCREMENT = PI/32 ;

class Jellyfish{
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
  int grams = 30;
  int growTime;
  int gender;//0 = female, 1 = male 
  
  
  //roam: moving with aim; float: float with water(to be set); chase: when find food; mate: has mate
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
  
  
  //mate
  MateModule mModule = new MateModule(this);
  boolean isPairable = false;
  int mateTime;
  
  
  
  Jellyfish(int age, PVector p, int gender){
    
    //chaseIncrement = chaseInc;
    
    this.position = p.copy();
    this.aim = randomPosition().copy();
    
    //bio set
    // this.grams = random.nextInt(1,8);
    this.growTime = millis();
    this.age = age;
    this.gender = gender;
    this.mateTime = millis();

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
    if(age < 4) //old jelly don't eat
      foodDetect();
    
    updateBioState();   
    updateMateState(); 
    updateMusic();
    updateParticles();
    for(Particle p : particleList){
      p.draw();
    }
    


        
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
    pushMatrix();
    translate(position.x,position.y);
    rotate(orientation );
    image(jelly,0,0);
    popMatrix();

    move();

    //test grams
    fill(255);
    textSize(20);
    text(grams,position.x,position.y);


    //test color
    // if(state == "chase")
    //   fill(#FFCE29);
    // else if(isPairable)
    //     fill(#FF8EC6);
    // else if(isfloat)
    //   fill(#E01705);
    // else
    //   fill(JELLYFISH);
    //fill(255);
    //circle(position.x,position.y, 35);
    //int x = (int)(position.x + 10 * cos(orientation));  
    //int y = (int)(position.y + 10 * sin(orientation));
    //fill(0);
    //circle(x,y,10);    
  }
  
  void updateParticles(){

    if(isdrag){
       float speed = abs(mouseX-pmouseX) + abs(mouseY-pmouseY);
        if(millis() - particleTime >= 2000/speed){
          resetParticles();
          particleTime = millis();
        }
    }else{
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
  }
  
  void resetParticles(){
    for(Particle p : particleList){
      p.particleReset();
    }
  }
  
  void updateMusic(){    
    if(isdrag){
      //quickly split out notes
      dragMusic();
    }else{
      //normally split out notes
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

  }

  void dragMusic(){
     float speed = abs(mouseX-pmouseX) + abs(mouseY-pmouseY);
      if(age < 4){
        if (millis() - noteTime >= 2000/speed){
          //if(state != "float"){
            this.noteSet.get(random.nextInt(0, noteSet.size())).trigger();
            noteTime = millis();
          //}
        }
      }else{
        if (millis() - noteTime >= 2000/speed){
          if(mood == "calm")
            autoChord(lofi1, this.noteSet.get(random.nextInt(0, noteSet.size())));
          else
            autoChord(lofi2, this.noteSet.get(random.nextInt(0, noteSet.size())));
            noteTime = millis();
        }
      }
  }

  void updateMateState(){
    //mate status
    if(millis() - mateTime > 5000){
      if(age == 3 && grams >= 20 && !isPairable){
        isPairable = true;
      }
    }

    if(grams < 20 && isPairable){
      isPairable = false;
    }

    if(isPairable){
      mModule.detectMate();
      text("isPairable", position.x, position.y - 60);
    }

    //test code

    if(gender == 0){
      fill(#FA1E6F);
      text("isP:"+isPairable, position.x-50, position.y-50);
      text("fM:"+mModule.foundMate, position.x-50, position.y+50);
      text(state, position.x, position.y-100);
    }else{
      fill(#FAAD1E);
      text("isP:"+isPairable, position.x+50, position.y-50);
      text("fM:"+mModule.foundMate, position.x+50, position.y+50);
      text(state, position.x, position.y+100);
    }


  }
  
  void updateBioState(){
    //naturally gaining weight
    if (millis() - growTime >= 1000 && grams < 30){
        this.grams++;
        growTime = millis();
    }
    // age update
    if(grams >= 10 && age == 1){
     age = 2;
    }else if(grams >= 20 && age == 2){
     age = 3;
     this.noteSet.clear();
     this.noteSet.addAll(lofiMinorF5s); 
    }

    //after 2 mate become old - age 4
    if(age == 3 && mModule.mateCount >= 2){
      age = 4 ;
    }
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

    //mate prior to food
    if(isPairable){
      //if found a mate, switch to mate chase
      if(state != "mate" && isPairable){
        if(mModule.foundMate && mModule.myMate.isPairable){
          state = "mate";
        }
      }      
    }else{
      //if a food was fed, and is in detect range, switch to chase
      if(state != "chase" && foundFood){
        state = "chase";
      }
      if(state == "chase" && !foundFood){
        state = "roam";
      }
    }
    
    if(state == "mate" && (!isPairable || !mModule.myMate.isPairable)){
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
      else if(state == "mate"){
        PVector toTarget = new PVector(mModule.myMate.position.x - position.x, mModule.myMate.position.y - position.y);
        velocity = toTarget.normalize().mult(chaseIncrement);
      }
      PVector realVel = velocity.copy();
      //realVel.add(current);
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
