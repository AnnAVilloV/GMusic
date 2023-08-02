class MateModule{
float dis = Float.MAX_VALUE;
  Jellyfish myJelly;

  boolean foundMate = false;
  Jellyfish myMate;

  int mateCount = 0;

  
  MateModule(Jellyfish j){
    this.myJelly = j;
  }

  void detectMate(){
    if(!foundMate){
      for(Jellyfish j : jellys){  
        if(j.isPairable && myJelly.gender != j.gender && j.isPairable){
          dis = PVector.dist(myJelly.position, j.position); 
          if(dis < 200 && dis != 0){
            foundMate = true;
            myMate = j;
            break;
          }
        }
      }
    }else{ //foundMate
      //if mate still pairable, chase
      if(myMate.isPairable){
        dis = PVector.dist(myJelly.position, myMate.position);
        if(dis <= 30 && myJelly.gender == 0){
          giveBirth();
        }
      }else{
        foundMate = false;
      }
    }

  }

  void giveBirth(){
    Jellyfish baby = new Jellyfish(1,myJelly.position,random.nextInt(0,2));
    jellys.add(baby);
    
    if(myJelly.isPink || myMate.isPink){
      int chance = random.nextInt(0,2);
      if(chance == 1)
        baby.isPink = true;
    }
    
    myJelly.grams -= 5;
    mateCount++;
    foundMate = false;
    myJelly.mateTime = millis();
    myJelly.isPairable = false;

    myMate.grams -= 5;
    myMate.mModule.mateCount++;
    myMate.mModule.foundMate = false;
    myMate.mateTime = millis();
    myMate.isPairable = false;
  }
  
  


}
