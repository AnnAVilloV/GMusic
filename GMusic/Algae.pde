class Algae extends Food{
  Algae(float x, float y){
    super(x,y);
  }
  void draw(){
      integrate();    
      image(algae, position.x, position.y);
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
}
