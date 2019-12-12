import java.util.Collections; //<>//
import java.util.function.Predicate;
import java.util.function.Consumer;

PVector polarPoint(PVector base, float angle, float distance) {
  PVector end = new PVector();
  end.x = base.x + cos(angle) * distance;
  end.y = base.y + sin(angle) * distance;
  return end;
}

PVector center;
Ring particleRing;
void setup() {
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
