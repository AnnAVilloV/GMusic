import gifAnimation.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
import java.util.Random;

//color
static final int BGCOLOR = #3340AF;
static final int JELLYFISH = #D3D8FF;
static final int DARK_BLUE = #2f3948;
static final int BLUE_PURPLE = #7820F5;

//display parameters
public static final int ROAM_INCREMENT_PROPORTION = 1200;
public static final int CHASE_INCREMENT_PROPORTION = 800;

//music
Minim minim;

AudioPlayer bgMusic;

AudioSample mG4;
AudioSample mA4;
AudioSample mA4s;
AudioSample mC5;
AudioSample mD5;
AudioSample mD5s;
AudioSample mF5;
AudioSample mG5;

AudioSample loF5s;
AudioSample loG5s;
AudioSample loA5;
AudioSample loB5;
AudioSample loC6s;
AudioSample loD6;
AudioSample loE6;

AudioSample loF6s;
AudioSample loG6s;
AudioSample loA6;
AudioSample loB6;
AudioSample loC7s;
AudioSample loD7;
AudioSample loE7;

AudioSample loF7s;
AudioSample loG7s;
AudioSample loA7;
AudioSample loB7;
AudioSample loC8s;
AudioSample loD8;
AudioSample loE8;

//lofi major C#
AudioSample loC5s;
AudioSample loD5s;AudioSample loE5s;AudioSample loA5s;AudioSample loB5s;
AudioSample loD6s;AudioSample loE6s;AudioSample loA6s;AudioSample loB6s;
AudioSample loD7s;AudioSample loE7s;AudioSample loA7s;AudioSample loB7s;


AudioSample syF5s;
AudioSample syG5s;
AudioSample syA5;
AudioSample syB5;
AudioSample syC6s;
AudioSample syD6;
AudioSample syE6;

//pictures
PImage bgpic;
PImage bgLight;
PImage panelPic;
PImage btnOn;
PImage btnOff;
PImage stillM50;
PImage stillF50;
PImage shrimp;
PImage fish;
PImage heart;
PImage algaeStatic;
PImage maleIcon;
PImage femaleIcon;
PImage bin1,bin2;

Gif jellyM50;
Gif jellyM80;
Gif jellyM100;
Gif jellyF50;
Gif jellyF80;
Gif jellyF100;
Gif pinkJelly50;
Gif pinkJelly100;
Gif cherryJelly50;
Gif cherryJelly100;

Gif algae;

Gif shrimpStillR;
Gif shrimpStillL;
Gif shrimpMoveR;
Gif shrimpMoveL;

Gif fishStillR;
Gif fishStillL;
Gif fishRunR;
Gif fishRunL;

//booleans
boolean prevMousePressed = false;

//numbers
int screenWidth = 1000;
int screenHeight = 800;

//int floatIncrement;
//int roamIncrement;
//int chaseIncrement;
//int foodIncrement;

//instances
Random random;
Panel panel;

PVector current;
int currentTime;

ArrayList<AudioSample> lofiMinorF5s;
ArrayList<AudioSample> lofiMinorF6s;
ArrayList<AudioSample> lofiMinorF7s;
ArrayList<AudioSample> lofi1 ;

ArrayList<AudioSample> lofiC5s;
ArrayList<AudioSample> lofiC6s;
ArrayList<AudioSample> lofiC7s;
ArrayList<AudioSample> lofi2;

ArrayList<AudioSample> mrbMinorG4;

ArrayList<AudioSample> syMinorF5s;

Jellyfish a;
Jellyfish b;
Jellyfish c;
Jellyfish d;

ArrayList<Jellyfish> jellys;

ArrayList<Food> foods;

//state
String mood;


void setup(){
   //fullScreen();
   size(1000,800);
   frameRate(60);
   background(#4A46CB);
   
   //display setup
   //roamIncrement = displayWidth/ROAM_INCREMENT_PROPORTION ; 
   //chaseIncrement = displayWidth/CHASE_INCREMENT_PROPORTION ; 

   //instances setup
   random = new Random();
   minim = new Minim(this);
   
   current = new PVector(0,0);
   currentTime = millis();
   
   bgMusic = minim.loadFile("environment/bubble.mp3",2048);
   bgMusic.loop();
  
   lofiMinorF5s = new ArrayList<AudioSample>();
   lofiMinorF6s = new ArrayList<AudioSample>();
   lofiMinorF7s = new ArrayList<AudioSample>();
   lofi1 = new ArrayList<AudioSample>();
   
   
   lofiC5s = new ArrayList<AudioSample>();
   lofiC6s = new ArrayList<AudioSample>();
   lofiC7s = new ArrayList<AudioSample>();
   lofi2 = new ArrayList<AudioSample>();
   
   mrbMinorG4 = new ArrayList<AudioSample>();
   syMinorF5s = new ArrayList<AudioSample>();
   
   //notes setup
      //lofi1
    loF5s = minim.loadSample( "lofi1/#F5.mp3",512);lofiMinorF5s.add(loF5s);
    loG5s = minim.loadSample( "lofi1/#G5.mp3",512);lofiMinorF5s.add(loG5s);
    loA5 = minim.loadSample( "lofi1/A5.mp3",512);lofiMinorF5s.add(loA5);
    loB5 = minim.loadSample( "lofi1/B5.mp3",512);lofiMinorF5s.add(loB5);
    loC6s = minim.loadSample( "lofi1/#C6.mp3",512);lofiMinorF5s.add(loC6s);
    loD6 = minim.loadSample( "lofi1/D6.mp3",512);lofiMinorF5s.add(loD6);
    loE6 = minim.loadSample( "lofi1/E6.mp3",512);lofiMinorF5s.add(loE6);
    
    lofi1.addAll(lofiMinorF5s);
    
    loF6s = minim.loadSample( "lofi1/#F6.mp3",512);lofiMinorF6s.add(loF6s);
    loG6s = minim.loadSample( "lofi1/#G6.mp3",512);lofiMinorF6s.add(loG6s);
    loA6 = minim.loadSample( "lofi1/A6.mp3",512);lofiMinorF6s.add(loA6);
    loB6 = minim.loadSample( "lofi1/B6.mp3",512);lofiMinorF6s.add(loB6);
    loC7s = minim.loadSample( "lofi1/#C7.mp3",512);lofiMinorF6s.add(loC7s);
    loD7 = minim.loadSample( "lofi1/D7.mp3",512);lofiMinorF6s.add(loD7);
    loE7 = minim.loadSample( "lofi1/E7.mp3",512);lofiMinorF6s.add(loE7);
    
    lofi1.addAll(lofiMinorF6s);
    
    loF7s = minim.loadSample( "lofi1/#F7.mp3",512);lofiMinorF7s.add(loF7s);
    loG7s = minim.loadSample( "lofi1/#G7.mp3",512);lofiMinorF7s.add(loG7s);
    loA7 = minim.loadSample( "lofi1/A7.mp3",512);lofiMinorF7s.add(loA7);
    loB7 = minim.loadSample( "lofi1/B7.mp3",512);lofiMinorF7s.add(loB7);
    loC8s = minim.loadSample( "lofi1/#C8.mp3",512);lofiMinorF7s.add(loC8s);
    loD8 = minim.loadSample( "lofi1/D8.mp3",512);lofiMinorF7s.add(loD8);
    loE8 = minim.loadSample( "lofi1/E8.mp3",512);lofiMinorF7s.add(loE8);
    
    lofi1.addAll(lofiMinorF7s);
    
    //lofi major C#
    loC5s = minim.loadSample( "lofiC#/#C5.mp3",512);
    loD5s = minim.loadSample( "lofiC#/#D5.mp3",512);
    loE5s = minim.loadSample( "lofiC#/#E5.mp3",512);
    loA5s = minim.loadSample( "lofiC#/#A5.mp3",512);
    loB5s = minim.loadSample( "lofiC#/#B5.mp3",512);
    
    loD6s = minim.loadSample( "lofiC#/#D6.mp3",512);
    loE6s = minim.loadSample( "lofiC#/#E6.mp3",512);
    loA6s = minim.loadSample( "lofiC#/#A6.mp3",512);
    loB6s = minim.loadSample( "lofiC#/#B6.mp3",512);
    
    loD7s = minim.loadSample( "lofiC#/#D7.mp3",512);
    loE7s = minim.loadSample( "lofiC#/#E7.mp3",512);
    loA7s = minim.loadSample( "lofiC#/#A7.mp3",512);
    loB7s = minim.loadSample( "lofiC#/#B7.mp3",512);
    
    lofiC5s.add(loC5s);    lofiC5s.add(loE5s);    lofiC5s.add(loG5s);    lofiC5s.add(loA5s);
    lofiC6s.add(loC6s);    lofiC6s.add(loE6s);    lofiC6s.add(loG6s);    lofiC6s.add(loA6s);
    lofiC7s.add(loC7s);    lofiC7s.add(loE7s);    lofiC7s.add(loG7s);    lofiC7s.add(loA7s);
    
    lofi2.add(loC5s);    lofi2.add(loD5s);    lofi2.add(loE5s);    lofi2.add(loF5s);    lofi2.add(loG5s);    lofi2.add(loA5s);    lofi2.add(loB5s); 
    lofi2.add(loC6s);    lofi2.add(loD6s);    lofi2.add(loE6s);    lofi2.add(loF6s);    lofi2.add(loG6s);    lofi2.add(loA6s);    lofi2.add(loB6s); 
    lofi2.add(loC7s);    lofi2.add(loD7s);    lofi2.add(loE7s);    lofi2.add(loF7s);    lofi2.add(loG7s);    lofi2.add(loA7s);    lofi2.add(loB7s);
    
      //marimba
    mG4 = minim.loadSample( "marimba/G4.mp3",512);mrbMinorG4.add(mG4);
    mA4 = minim.loadSample( "marimba/A4.mp3",512);mrbMinorG4.add(mA4);
    mA4s = minim.loadSample( "marimba/#A4.mp3",512);mrbMinorG4.add(mA4s);
    mC5 = minim.loadSample( "marimba/C5.mp3",512);mrbMinorG4.add(mC5);
    mD5 = minim.loadSample( "marimba/D5.mp3",512);mrbMinorG4.add(mD5);
    mD5s = minim.loadSample( "marimba/#D5.mp3",512);mrbMinorG4.add(mD5s);
    mF5 = minim.loadSample( "marimba/F5.mp3",512);mrbMinorG4.add(mF5);
    mG5 = minim.loadSample( "marimba/G5.mp3",512);mrbMinorG4.add(mG5);
    
    lofi1.addAll(lofiMinorF7s);
    
    //sytrus1
    syF5s = minim.loadSample( "sytrus1/#F5.mp3",512);syMinorF5s.add(syF5s);
    syG5s = minim.loadSample( "sytrus1/#G5.mp3",512);syMinorF5s.add(syG5s);
    syA5 = minim.loadSample( "sytrus1/A5.mp3",512);syMinorF5s.add(syA5);
    syB5 = minim.loadSample( "sytrus1/B5.mp3",512);syMinorF5s.add(syB5);
    syC6s = minim.loadSample( "sytrus1/#C6.mp3",512);syMinorF5s.add(syC6s);
    syD6 = minim.loadSample( "sytrus1/D6.mp3",512);syMinorF5s.add(syD6);
    syE6 = minim.loadSample( "sytrus1/E6.mp3",512);syMinorF5s.add(syE6);

    //setVolume();
    
    
   //state set up
   mood = "calm"; //calm, happy

   //other instances setup
   jellys = new ArrayList<Jellyfish>();
   a = new Jellyfish(1,randomPosition(),0); jellys.add(a);
   b = new Jellyfish(2,randomPosition(),1); jellys.add(b);
   c = new Jellyfish(3,randomPosition(),0); jellys.add(c);
   d = new Jellyfish(4,randomPosition(),1); jellys.add(d);

   foods = new ArrayList<Food>();
   
   //pictures set up
   bgpic = loadImage("background.png");   bgpic.resize(1000,800);
   bgLight = loadImage("bgLight.png");   bgLight.resize(1000,800);
   panelPic = loadImage("panel.png");   panelPic.resize(1000,800);
   btnOn = loadImage("on.png");  btnOff = loadImage("off.png");
   stillM50 = loadImage("stillM40.png");  stillM50.resize(50,50);
   stillF50 = loadImage("stillF40.png");  stillF50.resize(50,50);
   shrimp = loadImage("shrimpStatic.png"); 
   fish = loadImage("sakaStatic.png");  fish.resize(70,70);
   heart = loadImage("heart.png");  heart.resize(20,20);
   algaeStatic = loadImage("algeaStatic.png");
   maleIcon = loadImage("male.png");
   femaleIcon = loadImage("female.png");
   bin1 = loadImage("mon1.png"); bin1.resize(100,100);
   bin2 = loadImage("mon2.png"); bin2.resize(100,100);
   
   
   algae = new Gif(this, "algea.gif");
   jellyM50 = new Gif(this, "jelly50.gif");   jellyM50.play();
   jellyM80 = new Gif(this, "jelly80.gif");   jellyM80.play();
   jellyM100 = new Gif(this, "jelly100.gif");   jellyM100.play();
   jellyF50 = new Gif(this, "jellyDark50.gif");   jellyF50.play();
   jellyF80 = new Gif(this, "jellyDark80.gif");   jellyF80.play();
   jellyF100 = new Gif(this, "jellyDark100.gif");   jellyF100.play();
   pinkJelly50 = new Gif(this, "pinkJelly50.gif");  pinkJelly50.play();
   pinkJelly100 = new Gif(this, "pinkJelly100.gif");  pinkJelly100.play();
   cherryJelly50 = new Gif(this, "cherryJelly50.gif");  cherryJelly50.play();
   cherryJelly100 = new Gif(this, "cherryJelly100.gif");  cherryJelly100.play();
   shrimpStillR = new Gif(this, "shrimpStillR.gif");   shrimpStillR.play();
   shrimpStillL = new Gif(this, "shrimpStillL.gif");   shrimpStillL.play();
   shrimpMoveR = new Gif(this, "shrimpMoveR.gif");   shrimpMoveR.play();
   shrimpMoveL = new Gif(this, "shrimpMoveL.gif");   shrimpMoveL.play();
   fishStillR = new Gif(this, "sakaStillR.gif");  fishStillR.play();
   fishStillL = new Gif(this, "sakaStillL.gif");  fishStillL.play();
   //fishRunR = new Gif(this, "sakaRunR.gif");   fishRunR.play();
   //fishRunL = new Gif(this, "sakaRunL.gif");   fishRunL.play();
   

   //panel
   panel = new Panel();

   
}


void draw(){
  background(BGCOLOR);  
  if(mood == "calm")
    image(bgpic,500,400);
  else
    image(bgLight,500,400);
  panel.draw();

 //current 
   currentUpdate(); 

  //draw foods
  if(foods.size() != 0){
    for(int i = 0; i < foods.size(); i++){
      if(foods.get(i).stillExist)
        foods.get(i).draw();
    }  
  } 

   //draw jellyfish
  for(int i = 0; i < jellys.size(); i++){
    imageMode(CENTER);
    jellys.get(i).draw();
  }
  
} 


  void deathProgress(){
  //go over all jellys, find out old jellys; 
  //if old jellyfish more than 1, reduce them to 1
  ArrayList<Jellyfish> dyingJellys = new ArrayList<Jellyfish>();
  for(int i = 0; i < jellys.size(); i++){
    if(jellys.get(i).age == 4)
      dyingJellys.add(jellys.get(i));
  }
  if(dyingJellys.size()>1){
    int keepIndex = random.nextInt(0,dyingJellys.size());
    dyingJellys.remove(keepIndex); 
    //now all the jellys left in dyingJellys are jellys that will be remove from existing jellys
    for(Jellyfish j : dyingJellys){
      j.isDead = true;
    }
  }

}

void currentUpdate(){
    if(millis() - currentTime > 5000){
      current.x = random(-0.1,0.1);
      current.y = random(-0.1,0.1);
      currentTime = millis();
    }
    //fill(255);
    //text("current: " + current.x + " " + current.y, 200, 200); //<>//
}  //<>//

void autoChord(ArrayList<AudioSample> list, AudioSample s){
  int index1 = 0;
  int index2 = 0;
  int index3 = 0;
  
  index1 = list.indexOf(s);
  
  if(index1 + 2 <= list.size()) //<>// //<>// //<>//
    index2 = index1 + 2; //<>// //<>//
  if(index1 + 4 <= list.size())
    index3 = index1 + 4;
  if(index1 != 0 && index2 != 0 && index3 != 0){
    try{
        list.get(index1).trigger();
        list.get(index2).trigger();
        list.get(index3).trigger();
    }catch(Exception e){
      e.printStackTrace();
    }
  }
}

//void keyPressed(){
//  if(key=='r') lofi1.get(3).trigger();
//  if(key=='t') lofi1.get(4).trigger();
//  if(key=='y') lofi1.get(5).trigger();
//  if(key=='u') lofi1.get(6).trigger();
//  if(key=='i') lofi1.get(7).trigger();
//}

void mousePressed(){
  prevMousePressed = true;
  
  for(Jellyfish j : jellys){
    if(j.overJelly) { 
      if(mouseButton == LEFT)
        j.isdrag = true; 
      else
        j.isDead = true;
    } else {
      j.isdrag = false;
    }
  }
  
  for(Food f : foods){
    if(f.overFood) { 
      if(mouseButton == LEFT)
        f.isdrag = true; 
    } else {
      f.isdrag = false;
    }
  }
  
  
  

}

void mouseReleased() {
  boolean overMonster = false;
  if(mouseX>width*0.9 && mouseX < width*0.95 && mouseY > height*0.7 && mouseY < height*0.8){
    overMonster = true;
  }
  
  for(Jellyfish j : jellys){
    if(j.isdrag)
        if(overMonster){
          jellys.remove(j);
          break;
        }
        j.isdrag = false;
    }
  for(Food f : foods){

    if(f.isdrag){
        if(overMonster){
          foods.remove(f);
          break;
        }
        f.isdrag = false;
    }

  }
  
  
  if(mouseX>width*0.04 && mouseX<width*0.96 && mouseY>height*0.04 && mouseY < height*0.8){
      panel.femaleAdd.released = true;
      panel.maleAdd.released = true;
      panel.algaeAdd.released = true;
      panel.shrimpAdd.released = true;
      panel.fishAdd.released = true;
  }


}


void stop(){
  for(AudioSample s : lofi1){
    s.close();
  }//Does this really work??
  minim.stop();
  super.stop();
}

PVector randomPosition(){
  PVector p = new PVector();
  p.x = random.nextInt(80, width-80);
  p.y = random.nextInt(80, height-220);
  return p;
}

//void setVolume(){
//  for(ArrayList<AudioSample> temp : allNotes){
//    for(AudioSample a : temp){
//      a.setGain(-25);
//    }
//  }
//}
