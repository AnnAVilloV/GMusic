class Button {
    float x=150;
    float y=720;
    float w=190;
    float h=120;
    int buttonColor;
    int defaultColor;
    int hoverColor;
    String text;
    
    boolean tik = true;
    
    Button(int defaultColor, int hoverColor, String text) {
        this.defaultColor = defaultColor;
        this.buttonColor = defaultColor;
        this.hoverColor = hoverColor;
        this.text = text;
    }
    
    void draw() {
        updateButton();
        //fill(buttonColor, 200);
        //noStroke();
        //rectMode(CENTER);
        //rect(x, y, w, h, 5, 5, 5, 5);
        //fill(255);
        //textAlign(CENTER, CENTER);
        //textSize(18);
        //text(text, x, y);
        
        if(tik){
          image(btnOn,150,720);
        }else{
          image(btnOff,150,720);
        }
    }
    
    void updateButton() {
        
        if (isMouseHovering()) {
            //buttonColor = lerpColor(buttonColor, hoverColor, 0.1);
                if (prevMousePressed) {
                    onPressAction();
                    prevMousePressed = false;
                }
        } else{
            buttonColor = lerpColor(buttonColor, defaultColor, 0.1);
        }
        
    }
    
    boolean isMouseHovering() {
        if (mouseX > x - w / 2 && mouseX < x + w / 2 && mouseY > y - h / 2 && mouseY < y + h / 2) {
            return true;
        }
        return false;
    }
    
    void onPressAction() {
      if(tik){
        for(Jellyfish j : jellys){
          j.noteSet.clear();
          if(j.age<=2){
            j.noteSet.addAll(lofiC6s);
          }else{
            j.noteSet.addAll(lofiC5s);
          }
        }
        mood = "happy";
        tik = false;
      }else{
        for(Jellyfish j : jellys){
          j.noteSet.clear();
          if(j.age<=2){
            j.noteSet.addAll(lofiMinorF6s);
          }else{
            j.noteSet.addAll(lofiMinorF5s);
          }
        }
        mood = "calm";
        tik = true; 
      }
        return;
    }
    void onPressAction2(){
      deathProgress();
    }
}
