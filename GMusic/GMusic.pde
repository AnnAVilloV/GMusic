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
AudioSample C3;
AudioSample D3;
AudioSample E3;
AudioSample F3;
AudioSample G3;
AudioSample A3;
AudioSample B3;

AudioSample C4;
AudioSample D4;
AudioSample E4;
AudioSample F4;
AudioSample G4;
AudioSample A4;
AudioSample B4;

AudioSample C5;
AudioSample D5;
AudioSample E5;
AudioSample F5;
AudioSample G5;
AudioSample A5;
AudioSample B5;

AudioSample C6;
AudioSample D6;
AudioSample E6;
AudioSample F6;
AudioSample G6;
AudioSample A6;
AudioSample B6;

AudioSample mG4;
AudioSample mA4;
AudioSample mA4up;
AudioSample mC5;
AudioSample mD5;
AudioSample mD5up;
AudioSample mF5;
AudioSample mG5;

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
ArrayList<ArrayList<AudioSample>> allNotes;

ArrayList<AudioSample> naturalM3;
ArrayList<AudioSample> naturalM4;
ArrayList<AudioSample> naturalM5;
ArrayList<AudioSample> naturalM6;

ArrayList<AudioSample> mrbMinorG4;

Jellyfish a;

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
  
   allNotes = new ArrayList<ArrayList<AudioSample>>();

   naturalM3 = new ArrayList<AudioSample>();
   naturalM4 = new ArrayList<AudioSample>();
   naturalM5 = new ArrayList<AudioSample>();
   naturalM6 = new ArrayList<AudioSample>();
   mrbMinorG4 = new ArrayList<AudioSample>();
   
   //notes setup
   C3 = minim.loadSample( "C3.wav",512);naturalM3.add(C3);
   D3 = minim.loadSample( "D3.wav",512);naturalM3.add(D3);
   E3 = minim.loadSample( "E3.wav",512);naturalM3.add(E3);
   F3 = minim.loadSample( "F3.wav",512);naturalM3.add(F3);
   G3 = minim.loadSample( "G3.wav",512);naturalM3.add(G3);
   A3 = minim.loadSample( "A3.wav",512);naturalM3.add(A3);
   B3 = minim.loadSample( "B3.wav",512);naturalM3.add(B3);
   
   C4 = minim.loadSample( "C4.wav",512);naturalM4.add(C4);
   D4 = minim.loadSample( "D4.wav",512);naturalM4.add(D4);
   E4 = minim.loadSample( "E4.wav",512);naturalM4.add(E4);
   F4 = minim.loadSample( "F4.wav",512);naturalM4.add(F4);
   G4 = minim.loadSample( "G4.wav",512);naturalM4.add(G4);
   A4 = minim.loadSample( "A4.wav",512);naturalM4.add(A4);
   B4 = minim.loadSample( "B4.wav",512);naturalM4.add(B4);
   
   C5 = minim.loadSample( "C5.wav",512);naturalM5.add(C5);
   D5 = minim.loadSample( "D5.wav",512);naturalM5.add(D5);
   E5 = minim.loadSample( "E5.wav",512);naturalM5.add(E5);
   F5 = minim.loadSample( "F5.wav",512);naturalM5.add(F5);
   G5 = minim.loadSample( "G5.wav",512);naturalM5.add(G5);
   A5 = minim.loadSample( "A5.wav",512);naturalM5.add(A5);
   B5 = minim.loadSample( "B5.wav",512);naturalM5.add(B5);
   
   C6 = minim.loadSample( "C6.wav",512);naturalM6.add(C6);
   D6 = minim.loadSample( "D6.wav",512);naturalM6.add(D6);
   E6 = minim.loadSample( "E6.wav",512);naturalM6.add(E6);
   F6 = minim.loadSample( "F6.wav",512);naturalM6.add(F6);
   G6 = minim.loadSample( "G6.wav",512);naturalM6.add(G6);
   A6 = minim.loadSample( "A6.wav",512);naturalM6.add(A6);
   B6 = minim.loadSample( "B6.wav",512);naturalM6.add(B6);
   
   
    mG4 = minim.loadSample( "marimba/G4.mp3",512);mrbMinorG4.add(mG4);
    mA4 = minim.loadSample( "marimba/A4.mp3",512);mrbMinorG4.add(mA4);
    mA4up = minim.loadSample( "marimba/#A4.mp3",512);mrbMinorG4.add(mA4up);
    mC5 = minim.loadSample( "marimba/C5.mp3",512);mrbMinorG4.add(mC5);
    mD5 = minim.loadSample( "marimba/D5.mp3",512);mrbMinorG4.add(mD5);
    mD5up = minim.loadSample( "marimba/#D5.mp3",512);mrbMinorG4.add(mD5up);
    mF5 = minim.loadSample( "marimba/F5.mp3",512);mrbMinorG4.add(mF5);
    mG5 = minim.loadSample( "marimba/G5.mp3",512);mrbMinorG4.add(mG5);

   allNotes.add(naturalM3);allNotes.add(naturalM4);allNotes.add(naturalM5);allNotes.add(naturalM6);
   allNotes.add(mrbMinorG4);
    setVolume();
   
   
   //other instances setup
   a = new Jellyfish(roamIncrement, chaseIncrement);
   foods = new ArrayList<Food>();
   
   //pictures set up
   
   //gif = new Gif(this, "pic/test.gif");
   //gif.loop();
   //giftest = Gif.getPImages(this, "pic/test.gif");

   
   
   
   
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
  a.draw();

  //draw foods
  if(foods.size() != 0){
    for(Food f : foods){
      f.draw();
    } //<>//
  }


}


void keyPressed(){
  if(key=='q') mG4.trigger();
  if(key=='w') mA4.trigger();
  if(key=='e') mA4up.trigger();
  if(key=='r') mC5.trigger();
  if(key=='t') mD5.trigger();
  if(key=='y') mD5up.trigger();
  if(key=='u') mF5.trigger();
  if(key=='i') mG5.trigger();
}

void mousePressed(){
  Food food = new Food(mouseX, mouseY);
  foods.add(food);
}

void stop(){
  minim.stop();
  super.stop();
}

void setVolume(){
  for(ArrayList<AudioSample> temp : allNotes){
    for(AudioSample a : temp){
      a.setGain(-25);
    }
  }
}
