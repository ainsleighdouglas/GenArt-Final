class Particle {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float lifespan;

  boolean seed = false;

  float hu;

  Particle(float x, float y, float h) {
    hu = h;

    acceleration = new PVector(0, 0);
    //velocity = new PVector(0, random(-12, -5));
    velocity = new PVector(0, 0);
    //location =  new PVector(x, y);
    location =  new PVector(mouseX, mouseY);
    seed = true;
    lifespan = 255.0; //og is 255
  }

  Particle(PVector l, float h) {
    hu = h;
    acceleration = new PVector(0, 0);
    velocity = PVector.random2D();
    velocity.mult(random(4, 80));
    location = l.copy();
    lifespan = 95.0; // looping speed?
  }

  void applyForce(PVector force) {
    acceleration.add(force);
  }

  void run() {
    update();
    display();
  }

  boolean explode() {
    if (seed && velocity.y > 0) {
      lifespan = 0;
      return true;
    }
    return false;
  }

  // Method to update location
  void update() {

    velocity.add(acceleration);
    location.add(velocity);
    if (!seed) {
      smooth();
      lifespan -= 5.0;
      velocity.mult(.95); //og 0.95 //GRAVITY!! DIFFUSE ACROSS THE SCREEN
    }
    acceleration.mult(0);
  }

  // LOOK AND FEEL
  void display() {
    //stroke(hu, 255, 255, lifespan);
    //smooth();
    stroke(random(180, 245), random(10, 115), random(0, 5), lifespan);
    //stroke(204, 237, 0);
    if (seed) {
      strokeWeight(random(5, 30));
    } else {
      strokeWeight(random(5, 30));
    }
    
    point(location.x, location.y);
    //ellipse(location.x, location.y, 12, 12); //EXPLORE THIS MORE
  }

  // Is the particle still useful?
  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}
