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
ArrayList<AudioSample> naturalM3;
ArrayList<AudioSample> naturalM4;
ArrayList<AudioSample> naturalM5;
ArrayList<AudioSample> naturalM6;
Jellyfish a;

Random random;

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

   naturalM3 = new ArrayList<AudioSample>();
   naturalM4 = new ArrayList<AudioSample>();
   naturalM5 = new ArrayList<AudioSample>();
   naturalM6 = new ArrayList<AudioSample>();
   
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
   
   
   //jellyfish setup
   a = new Jellyfish(roamIncrement, chaseIncrement);
   
   
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
  
  //button boolean
  prevMousePressed = mousePressed; //<>//
 
  a.draw();
    //if (millis() - noteTime >= 1000){
    //  if(a.state != "stay"){ //<>//
    //    naturalM4.get(random.nextInt(0, naturalM4.size())).trigger();
    //    noteTime = millis();
    //  }
    //}

}
 //<>//

void keyPressed(){
  if(key=='c') C4.trigger();
  if(key=='d') D4.trigger();
  if(key=='e') E4.trigger();
  if(key=='f') F4.trigger();
  if(key=='g') G4.trigger();
  if(key=='a') A4.trigger();
  if(key=='b') B4.trigger();
}

void stop(){
  minim.stop();
  super.stop();
}
