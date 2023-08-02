class Panel{
  Button btn = new Button(DARK_BLUE, BLUE_PURPLE, "test");
  DragButton femaleAdd = new DragButton(350,680,100,60,#2b1945, BLUE_PURPLE, "female",stillF50);
  DragButton maleAdd = new DragButton(350,750,100,60,#2b1945, BLUE_PURPLE, "male",stillM50);
  DragButton algaeAdd = new DragButton(500,700,100,60,#2b1945, BLUE_PURPLE, "algae",algaeStatic);
  DragButton shrimpAdd = new DragButton(610,700,100,60,#2b1945, BLUE_PURPLE, "shrimp",shrimp);
  DragButton fishAdd = new DragButton(720,700,100,60,#2b1945, BLUE_PURPLE, "fish",fish);
  
  Panel(){
  }
  
  void draw(){
    image(panelPic,500,400);
    btn.draw();
    
    femaleAdd.draw();
    image(femaleIcon,380,680);
    maleAdd.draw();
    image(maleIcon,380,750);
    algaeAdd.draw();
    shrimpAdd.draw();
    fishAdd.draw();
    
    if(mouseX>width*0.9 && mouseX < width*0.95 && mouseY > height*0.7 && mouseY < height*0.8){
      image(bin2,width*0.92,height*0.75);
    }else{
      image(bin1,width*0.92,height*0.75);
    }

    //fill(#2b1945);
    //rect(300,650,100,60);
    //rect(300,720,100,60);
    //image(stillF50,350,680);image(stillM50,350,750);
  } 

}
