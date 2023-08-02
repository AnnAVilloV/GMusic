class DragButton {
    float x=150;
    float y=720;
    float w=190;
    float h=120;
    int buttonColor;
    int defaultColor;
    int hoverColor;
    String type;
    PImage img;
    
    boolean pressed = false;
    boolean released = false;
    
    
    DragButton(float x, float y, float w, float h,int defaultColor, int hoverColor, String type,PImage p) {
        this.x = x; 
        this.y = y; 
        this.w = w; 
        this.h = h;
        this.defaultColor = defaultColor;
        this.buttonColor = defaultColor;
        this.hoverColor = hoverColor;
        this.type = type;
        this.img = p.copy();
    }
    
    void draw() {
        updateButton();
        fill(buttonColor, 200);
        noStroke();
        rectMode(CENTER);
        rect(x, y, w, h, 5, 5, 5, 5);
        
        //fill(255);
        //textAlign(CENTER, CENTER);
        //textSize(18);
        //text(text, x, y);
        
        image(img,x,y);
        
        if(pressed){
          if(!released)
            image(img,mouseX,mouseY);
        }
        if(released){
          //test code need alter
          if(pressed == true){
            switch(type){
                case "female":
                   jellys.add(new Jellyfish(1,new PVector(mouseX,mouseY),0));
                   break; 
                case "male":
                   jellys.add(new Jellyfish(1,new PVector(mouseX,mouseY),1));
                   break; 
                case "shrimp":
                   foods.add(new Shrimp(mouseX,mouseY));
                   break; 
                case "fish":
                   foods.add(new Fish(mouseX,mouseY));
                   break; 
                case "algae":
                   foods.add(new Algae(mouseX,mouseY));
                   break; 
            }
            
          }
          pressed = false;
          released = false;
        }
    }
    
    void updateButton() {
        if (isMouseHovering()) {
            //buttonColor = lerpColor(buttonColor, hoverColor, 0.1);
                if (mousePressed) {
                    pressed = true;
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
        return;
    }
}
