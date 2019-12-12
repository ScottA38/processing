class Ring {
  ArrayList<Particle> particles;
  Ring(int noParticles, float add) {
    particles = new ArrayList<Particle>();
    for (float a = 0; a < ( 1.99*PI ); a += (PI/noParticles)) {
      PVector loc = center;
      PVector velocity = polarPoint(new PVector(0, 0), a, tunedGauss(2, add));
      PVector accel = polarPoint(new PVector(0,0), a, tunedGauss(20, 0));
      particles.add(new Particle(loc, velocity, accel));
      println("Location of particle is: ", loc.x, loc.y, "\nvelocity is: ", velocity.x, velocity.y, "\naccel is: ", accel.x, accel.y);
    }
  }

  public void update() {
    particles.forEach( new ParticleUpdate() );
  }

  public void display() {
    particles.forEach( new ParticleDisplay() );
  }

  public boolean inBounds() {
    particles.removeIf(new ParticleOutBounds<Particle>());
    return (particles.size() > 0);
  }
}

class RingOutBounds<E> implements Predicate<Ring> {
  @Override
    public boolean test(Ring r) {
    return !r.inBounds();
  }
}

float tunedGauss(int muting, float addition) {
  return (abs(randomGaussian()/muting) + addition);
}
