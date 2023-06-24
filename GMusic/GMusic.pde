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
public static final int ROAM_INCREMENT_PROPORTION = 1000;
public static final int CHASE_INCREMENT_PROPORTION = 800;

//music
Minim minim;

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


AudioSample syF5s;
AudioSample syG5s;
AudioSample syA5;
AudioSample syB5;
AudioSample syC6s;
AudioSample syD6;
AudioSample syE6;

//pictures

Gif gif;
PImage[] giftest;


//booleans
boolean prevMousePressed = false;

//numbers
int screenWidth = 1000;
int screenHeight = 800;

int roamIncrement;
int chaseIncrement;

//time

//instances
Random random;

ArrayList<AudioSample> lofiMinorF5s;
ArrayList<AudioSample> lofiMinorF6s;
ArrayList<AudioSample> lofi1 ;

ArrayList<AudioSample> mrbMinorG4;

ArrayList<AudioSample> syMinorF5s;

Jellyfish a;
Jellyfish b;
Jellyfish c;
Jellyfish d;
ArrayList<Jellyfish> jellys;

ArrayList<Food> foods;



void setup(){
   //fullScreen();
   size(1000,800);
   frameRate(60);
   background(#4A46CB);
   
   //display setup
   roamIncrement = displayWidth/ROAM_INCREMENT_PROPORTION ; 
   chaseIncrement = displayWidth/CHASE_INCREMENT_PROPORTION ; 
   

   //instances setup
   random = new Random();
   minim = new Minim(this);
  
   lofiMinorF5s = new ArrayList<AudioSample>();
   lofiMinorF6s = new ArrayList<AudioSample>();
   lofi1 = new ArrayList<AudioSample>();

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
    
    lofi1.addAll(lofiMinorF6s);
    
      //marimba
    mG4 = minim.loadSample( "marimba/G4.mp3",512);mrbMinorG4.add(mG4);
    mA4 = minim.loadSample( "marimba/A4.mp3",512);mrbMinorG4.add(mA4);
    mA4s = minim.loadSample( "marimba/#A4.mp3",512);mrbMinorG4.add(mA4s);
    mC5 = minim.loadSample( "marimba/C5.mp3",512);mrbMinorG4.add(mC5);
    mD5 = minim.loadSample( "marimba/D5.mp3",512);mrbMinorG4.add(mD5);
    mD5s = minim.loadSample( "marimba/#D5.mp3",512);mrbMinorG4.add(mD5s);
    mF5 = minim.loadSample( "marimba/F5.mp3",512);mrbMinorG4.add(mF5);
    mG5 = minim.loadSample( "marimba/G5.mp3",512);mrbMinorG4.add(mG5);
    
    //sytrus1
    syF5s = minim.loadSample( "sytrus1/#F5.mp3",512);syMinorF5s.add(syF5s);
    syG5s = minim.loadSample( "sytrus1/#G5.mp3",512);syMinorF5s.add(syG5s);
    syA5 = minim.loadSample( "sytrus1/A5.mp3",512);syMinorF5s.add(syA5);
    syB5 = minim.loadSample( "sytrus1/B5.mp3",512);syMinorF5s.add(syB5);
    syC6s = minim.loadSample( "sytrus1/#C6.mp3",512);syMinorF5s.add(syC6s);
    syD6 = minim.loadSample( "sytrus1/D6.mp3",512);syMinorF5s.add(syD6);
    syE6 = minim.loadSample( "sytrus1/E6.mp3",512);syMinorF5s.add(syE6);


    //setVolume();
   
   
   //other instances setup
   jellys = new ArrayList<Jellyfish>();
   a = new Jellyfish(roamIncrement, chaseIncrement,1); jellys.add(a);
   b = new Jellyfish(roamIncrement, chaseIncrement,2); jellys.add(b);
   c = new Jellyfish(roamIncrement, chaseIncrement,3); jellys.add(c);
   d = new Jellyfish(roamIncrement, chaseIncrement,4); jellys.add(d);

   
   foods = new ArrayList<Food>();
   
   //pictures set up
   
   //gif = new Gif(this, "pic/test.gif");
   //gif.loop();
   //giftest = Gif.getPImages(this, "pic/test.gif");
   
   
}

void autoChord(ArrayList<AudioSample> list, AudioSample s){
  int index1 = 0;
  int index2 = 0;
  int index3 = 0;
  
  index1 = list.indexOf(s);
  
  if(index1 + 2 <= list.size())
    index2 = index1 + 2;
  if(index1 + 4 <= list.size())
    index3 = index1 + 4;
  if(index1 != 0 && index2 != 0 && index3 != 0){
    list.get(index1).trigger();
    list.get(index2).trigger();
    list.get(index3).trigger();
  }
}


void draw(){
  background(BGCOLOR);
  //gif.play();
  //draw pictures
  //image(gif, 100,100);
   //<>//
  //button boolean
  prevMousePressed = mousePressed; //<>//
 
 //draw jelly fish //<>//
 for(Jellyfish j : jellys){
   j.draw();
 }

  //draw foods
  if(foods.size() != 0){
    for(Food f : foods){
      f.draw();
    } //<>//
  }


}


void keyPressed(){
  //if(key=='q') autoChord(lofi1, 0);
  //if(key=='w') autoChord(lofi1, 1);
  //if(key=='e') autoChord(lofi1, 2);
  if(key=='r') lofi1.get(3).trigger();
  if(key=='t') lofi1.get(4).trigger();
  if(key=='y') lofi1.get(5).trigger();
  if(key=='u') lofi1.get(6).trigger();
  if(key=='i') lofi1.get(7).trigger();
}

void mousePressed(){
  Food food = new Food(mouseX, mouseY);
  foods.add(food);
}

void stop(){
  for(AudioSample s : lofi1){
    s.close();
  }//Does this really work??
  minim.stop();
  super.stop();
}

//void setVolume(){
//  for(ArrayList<AudioSample> temp : allNotes){
//    for(AudioSample a : temp){
//      a.setGain(-25);
//    }
//  }
//}
