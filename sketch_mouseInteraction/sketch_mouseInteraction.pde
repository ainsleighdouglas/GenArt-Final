//import processing.serial.*;
//import net.java.games.input.*;
//import org.gamecontrolplus.*;
//import org.gamecontrolplus.gui.*;
//import cc.arduino.*;
//import org.firmata.*;

//ControlDevice cont;
//ControlIO control;

float rthumb1;
float rthumb2;
int rthumb3;

float lthumb1;
float lthumb2;
int lthumb3;

int value = 0; //controller

PShader blur; //blur shader

float tx;
float ty;
float txtwo;
float tytwo;
float txth;
float tyth;

ArrayList<Firework> fireworks;
PVector gravity = new PVector(0, 0.2);

void setup() {
  fullScreen(P2D);
  fireworks = new ArrayList<Firework>();
  background(237, 229, 206);
  //background(0);
  //blendMode(ADD);
  
  blur = loadShader("blur.glsl"); //blur shader

  //controller
  //control = ControlIO.getInstance(this);
  //cont = control.getMatchedDevice("control1.0");

  ellipseMode(RADIUS);
}

//public void getUserInput() {
//  rthumb1 = map(cont.getSlider("s1").getValue(), -1, 1, 0, width); //emables movement within a certain range
//  rthumb2 = map(cont.getSlider("s2").getValue(), -1, 1, 0, height);
//  rthumb3 = int(cont.getButton("click").getValue());
//  lthumb1 = map(cont.getSlider("s3").getValue(), -1, 1, 0, width); //emables movement within a certain range
//  lthumb2 = map(cont.getSlider("s4").getValue(), -1, 1, 0, height);
//  lthumb3 = int(cont.getButton("click2").getValue());
//  println(rthumb3);
//}

void draw() {
  
  filter(blur); //blur shader

   //blend modes + button interaction
  if (rthumb3 == 8) {
    //background(0);
    //blendMode(ADD);
   
   //saveFrame();
    
   //fill(random(10, 25), random(100, 115), random(50,85), 80);
   //fill(204, 237, 0, 60);
  } else {
    //background(255);
    //blendMode(MULTIPLY);
  }
  
  //getUserInput(); //controller

  float posX = mouseX;
  float posY = mouseY;
  float circleOneRadius = random(5, 15);

  float posXtwo = mouseX;
  float posYtwo = mouseY;
  float circleTwoRadius = random(5, 15) + 5;
  
  float posXth = mouseX;
  float posYth = mouseY;
  float circleThreeRadius = random(0, 15) + 10;
  
  
  
      pushMatrix(); //save current "default" matrix
      scale(-1,1); //scale the matrix
      popMatrix();
      
  if (frameCount % 4 == 0 ) {
    tx = posX + mouseY * random(-.2, .2);
    ty = posY + mouseX * random(-.5, .5);

    txtwo = posXtwo + mouseX * random(-.2, .2);
    tytwo = posYtwo + mouseY * random(-.5, .5);
    
    txth = posXth + mouseX * random(-.4, .4);
    tyth = posYth + mouseY * random(-.8, .8);
  }

  
 if (dist(tx, ty, txtwo, tytwo) < circleOneRadius + circleTwoRadius) {
    //colliding!

    if (random(1) < 0.08) {
      fireworks.add(new Firework());
    }
    for (int i = fireworks.size()-1; i >= 0; i--) {
    Firework f = fireworks.get(i);
    f.run();
    if (f.done()) {
      fireworks.remove(i);
    }
  }
  
    //fill(0, 60);
    //fill(200, 84, 0, 60); //orange
    //noStroke();
    ellipse(tx, ty, circleOneRadius, circleOneRadius);
    //fill(204, 237, 0); //lime
    //fill(0, 60, 95, 60); //deep blue
    //noStroke();
    ellipse(txtwo, tytwo, circleTwoRadius*2, circleTwoRadius*2);
  
  } else {
    //not colliding!
    
    fill(random(180, 245), random(10, 115), random(0, 5), 30);
    //fill(255, 105, 180); //pink
    //fill(200, 84, 0, 60); //orange
    
    ellipse(tx, ty, circleOneRadius, circleOneRadius);
    //fill(204, 237, 0); //lime
    //fill(0, 60, 95, 60); //deep blue
    
    fill(random(100, 145), random(110, 115), random(0, 5), 30);
    ellipse(txtwo, tytwo, circleTwoRadius, circleTwoRadius);
    
    fill(random(10, 45), random(40, 55), random(100, 150), 30);
    ellipse(txth, tyth, circleThreeRadius, circleThreeRadius);
  }
  
    noStroke();
    fill(random(232, 237), random(224, 229), random(201, 206), 10); //trail
    //fill(20, 2);
    rect(0, 0, width, height); //trail
    
}
