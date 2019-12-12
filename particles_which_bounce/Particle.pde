class Particle {
  PVector accel;
  PVector velocity;
  PVector location;
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
    if (!this.inBounds()) {
      this.bounce();
    }
  }
  
  void bounce(){
    PVector l = this.location;
    PVector v = this.velocity;
    PVector a = this.accel;
    if (l.x > width || l.x < 0) {
      v.x *= -1;
      a.x *= -0.5;
    }
    else if (l.y > height || l.y < 0) {
      v.y *= -1;
      a.x *= -0.5;
    }
    else {
      throw new Error("Inappropriate call to <Particle>.Bounce(), check that !<Particle>.inBounds() first");
    }
    
  }

  public boolean inBounds() {
    if ( location.x > width || location.x < 0 || location.y > height || location.y < 0) {
      return false;
    } else {
      return true;
    }
  }

  void display() {
    float fillCol = random(255);
    noStroke();
    fill(color(fillCol, fillCol, fillCol));
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
