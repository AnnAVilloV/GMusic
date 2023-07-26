class Panel{
  Button btn = new Button(DARK_BLUE, BLUE_PURPLE, "test");
  DragButton femaleAdd = new DragButton(350,680,100,60,#2b1945, BLUE_PURPLE, "female",stillF50);
  DragButton maleAdd = new DragButton(350,750,100,60,#2b1945, BLUE_PURPLE, "male",stillM50);
  DragButton shrimpAdd = new DragButton(500,700,100,60,#2b1945, BLUE_PURPLE, "shrimp",shrimp);
  
  Panel(){
  }
  
  void draw(){
    image(panelPic,500,400);
    btn.draw();
    
    femaleAdd.draw();
    maleAdd.draw();
    shrimpAdd.draw();
    
    //fill(#2b1945);
    //rect(300,650,100,60);
    //rect(300,720,100,60);
    //image(stillF50,350,680);image(stillM50,350,750);
  } 

}
