class Button {
    float x, y;
    float w, h;
    int buttonColor;
    int defaultColor;
    int hoverColor;
    String text;
    
    boolean tik = true;
    
    Button(float x, float y, float w, float h, int defaultColor, int hoverColor, String text) {
        this.x = x;
        this.y = y;
        this.w = w;
        this.h = h; 
        this.defaultColor = defaultColor;
        this.buttonColor = defaultColor;
        this.hoverColor = hoverColor;
        this.text = text;
    }
    
    void draw() {
        updateButton();
        fill(buttonColor, 200);
        noStroke();
        rectMode(CENTER);
        rect(x, y, w, h, 5, 5, 5, 5);

        fill(255);
        textAlign(CENTER, CENTER);
        textSize(18);
        text(text, x, y);
    }
    
    void updateButton() {
        
        if (isMouseHovering()) {
            buttonColor = lerpColor(buttonColor, hoverColor, 0.1);
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
          fill(255);
          circle(300,300,100);
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
          fill(0);
          circle(300,300,100);
        mood = "calm";
        tik = true;
      }

        return;
    }
}
