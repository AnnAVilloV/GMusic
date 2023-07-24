class Panel{

  Panel(){
  }
  
  void draw(){
    image(panelPic,500,400);
    btn.draw();
    fill(#2b1945);
    rect(300,650,100,60);rect(300,720,100,60);
    image(stillF50,350,680);image(stillM50,350,750);
  } 


}
