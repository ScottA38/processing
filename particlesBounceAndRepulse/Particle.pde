class Particle {
  PVector accel = new PVector();
  PVector velocity;
  PVector location;
  //float lifespan = 225;
  float maxSpeed;
  int mass;
  Particle(PVector l, PVector v, int m) {
    velocity = v.copy();
    location = l.copy();
    maxSpeed = velocity.mag() * 3;
    mass = m;
  }

  PVector getLocation() {
    return location;
  }
  
  int getMass() {
    return mass;
  }
  
  public BoundStates inBounds() {
    if ( location.x > width || location.x < 0) {
      return BoundStates.outX;
    } else if (location.y > height || location.y < 0) {
      return BoundStates.outY;
    } else {
      return in;
    }
  }
  
  public boolean doesCollide(Particle other) {
    PVector otherPos = other.getLocation();
    int otherMass = other.getMass();
    return dist(this.location.x, this.location.y, otherPos.x, otherPos.y) < ((otherMass + mass) /2);
  }
  
  void bounce(){
    PVector v = this.velocity;
    PVector a = this.accel;
    boolean isIn = this.inBounds();
    if (isIn == 1) {
      v.x *= -1;
      a.x *= -0.5;
    }
    else if (isIn == 2) {
      v.y *= -1;
      a.x *= -0.5;
    }
    else {
      throw new Error("Inappropriate call to <Particle>.Bounce(), check that !<Particle>.inBounds() first");
    } 
  }
  
  void collision() {
    
  }
  
  void applyForce(PVector force) {
    PVector f = force.copy();
    f.div(mass);
    accel.add(f);
  }
  
  void update() {
    
    location.add(velocity);
    //if (lifespan >1) {
    //  lifespan -= 1;
    //}
    if (this.inBounds() != 0) {
      this.bounce();
    }
    accel.mult(0);
  }

  void display() {
    noStroke();
    fill(random(255));
    ellipse(location.x, location.y, mass, mass);
  }

}

public interface BoundsStates {
  int
  in = 0,
  outX = 1,
  outY = 2
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

public class ParticleApplyForce implements Consumer<Particle> {
  @Override
  public void accept(Particle p){
    p.update();
  }
}
