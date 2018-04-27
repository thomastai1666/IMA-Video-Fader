import processing.serial.*;
import processing.video.*;

String myString = null;
Serial myPort;
Movie mov1;
Movie mov2;

PImage movie1;
PImage movie2;

int NUM_OF_VALUES = 2;   /** YOU MUST CHANGE THIS ACCORDING TO YOUR PROJECT **/
int[] sensorValues;      /** this array stores values from Arduino **/
int vid, vol;
float trans1, trans2;
float audio1, audio2;

void setup() {
  fullScreen();
  background(0);
  mov1 = new Movie(this, "movie1.mp4");
  mov2 = new Movie(this, "movie2.mp4");
  mov1.play();
  mov2.play();
  setupSerial();
}

void draw() {
  updateSerial();
  printArray(sensorValues);
  
  vid = sensorValues[0];
  //print(vid);
  vol = sensorValues[1];
  
  trans1 = map(vid,0,1023,0,255);
  trans2 = 255 - trans1;
  
  audio1 = map(vol,0,1023,0,255);
  audio2 = 255 - audio1;
  
  mov1.volume(audio1);
  tint(255,trans1);
  image (mov1, 0, 0);
  
  mov2.volume(audio2);
  tint(255,trans2);
  image (mov2, 0, 0);
}


void movieEvent(Movie mov) {
  mov.read();
}

void setupSerial() {
  printArray(Serial.list());
  myPort = new Serial(this, Serial.list()[ 2 ], 9600);
  // WARNING!
  // You will definitely get an error here.
  // Change the PORT_INDEX to 0 and try running it again.
  // And then, check the list of the ports,
  // find the port "/dev/cu.usbmodem----" or "/dev/tty.usbmodem----" 
  // and replace PORT_INDEX above with the index number of the port.

  myPort.clear();
  // Throw out the first reading,
  // in case we started reading in the middle of a string from the sender.
  myString = myPort.readStringUntil( 10 );  // 10 = '\n'  Linefeed in ASCII
  myString = null;

  sensorValues = new int[NUM_OF_VALUES];
}

void updateSerial() {
  while (myPort.available() > 0) {
    myString = myPort.readStringUntil( 10 ); // 10 = '\n'  Linefeed in ASCII
    if (myString != null) {
      String[] serialInArray = split(trim(myString), ",");
      if (serialInArray.length == NUM_OF_VALUES) {
        for (int i=0; i<serialInArray.length; i++) {
          sensorValues[i] = int(serialInArray[i]);
        }
      }
    }
  }
}