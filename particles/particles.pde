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
boolean toggle;
ArrayList<Ring> rings = new ArrayList<Ring>();
void setup() {
  size(800, 800);
  //noLoop();
  center = new PVector(width/2, height/2);
  toggle = true;
  rings.add(new Ring(30, 1));
}

void draw() {
  clear();
  background(255);
  if (randomGaussian() > 2) {
    rings.add(new Ring(30, 1));
  }
  rings.removeIf(new RingOutBounds<Ring>());
  for (int i = 0; i < rings.size(); i++) {
    Ring r = rings.get(i);
    if (!r.inBounds()) {
      rings.remove(r);
    }
    //println(part.getLocation().x, part.getLocation().y);
    r.update();
    r.display();
  }
}
