class Particle {
  PVector accel = new PVector();
  PVector velocity = new PVector();
  PVector location = new PVector();
  float lifespan = 225;
  float maxSpeed;
  Particle(PVector l, PVector v, PVector a) {
    accel = a.copy();
    velocity = v.copy();
    location = l.copy();
    maxSpeed = velocity.mag() * 3;
  }

  PVector getLocation() {
    return location;
  }

  void update() {
    if (velocity.mag() < maxSpeed) {
      velocity.add(accel);
    }
    location.add(velocity);
    if (lifespan >1) {
      lifespan -= 1;
    }
  }

  public boolean inBounds() {
    if ( location.x > width || location.x < 0) {
      return false;
    } else if (location.y > height || location.y < 0) {
      return false;
    } else {
      return true;
    }
  }

  void display() {
    float fillCol = random(255);
    noStroke();
    fill(color(fillCol, fillCol, fillCol, lifespan));
    ellipse(location.x, location.y, 8, 8);
  }
}

class ParticleOutBounds<E> implements Predicate<Particle> {
  @Override
    public boolean test(Particle p) {
    return !p.inBounds();
  }
}

public class ParticleDisplay implements Consumer<Particle> {
  @Override
    public void accept(Particle p) {
    p.display();
  }
}
public class ParticleUpdate implements Consumer<Particle> {
  @Override
    public void accept(Particle p) {
    p.update();
  }
}
