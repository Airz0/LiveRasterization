/*
    Controls: 'p' or 'P' to play/pause rotation.
    if rotation is paused, 'a'/'A' & 'd'/'D' to rotate left and right
*/

import processing.video.*;
Capture video;

boolean autoTurn = true;
float turnValue=0;
int frameC = 0;
float tiles = 100;
void setup() {
  size(640, 480, P3D);

    String[] cameras = Capture.list();

  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }
 
    video = new Capture(this, 640,480 , cameras[0]);
    video.start();
  }      

}

void draw() {
  background(#f1f1f1);
  fill(0);
  noStroke();
  sphereDetail(3);
  tiles = map(mouseX,0,width,10,200);
  float tileSize = width/tiles;
  pushMatrix();
  translate(width/2, height/2);

  rotateY(radians(frameC)); 

  if (autoTurn) {
    frameC++;
  }

 if (video.available()) {
    video.read();
    video.loadPixels();
  }
  
  for (int x = 0; x < tiles; x++) {
    for (int y = 0; y < tiles; y++) {
      color c = video.get(int(x*tileSize), int(y*tileSize));
      float b = map(brightness(c), 0, 255, 1, 0);
      float z = map(b, 0, 1, -150, 150);

      pushMatrix();
      translate(x*tileSize - width/2, y*tileSize - height/2, z);
      sphere(tileSize*b*0.8);
      popMatrix();
    }
  }
  popMatrix();

  if (keyPressed) {
    if (key=='a' || key=='A')
    {
      frameC--;
    }  
    if (key=='d' || key=='D')
    {
      frameC++;
    }
  }
}

void keyPressed() {
  if (key=='p' || key=='P')
  {
    autoTurn = !autoTurn;
  }
}
