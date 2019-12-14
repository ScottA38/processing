import shiffman.box2d.*; //<>//
import java.util.*;
import java.util.function.*;

//import java.util.function.Consumer;

PVector polarPoint(PVector base, float angle, float distance) {
  PVector end = new PVector();
  end.x = base.x + cos(angle) * distance;
  end.y = base.y + sin(angle) * distance;
  return end;
}

Box2DProcessing box2d;
PVector center;
Ring particleRing;
void setup() {
  //box2d setup
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  
  //canvas setup
  size(800, 800);
  center = new PVector(width/2, height/2);
  particleRing = new Ring(30, 1);
}

void draw() {
  clear();
  background(255);
  particleRing.update();
  particleRing.display();
}
