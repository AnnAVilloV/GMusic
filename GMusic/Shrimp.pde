class Shrimp extends Food{
  

  Shrimp(float x, float y){
    this.position.x = x;
    this.position.y = y;
  }

  void draw(){
    image(shrimpStillR, position.x,position.y);
  }

}
