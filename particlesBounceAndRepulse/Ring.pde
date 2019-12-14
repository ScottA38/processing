class Ring {
  ArrayList<Particle> particles;
  Ring(int noParticles, float add) {
    particles = new ArrayList<Particle>();
    for (float a = 0; a < ( 1.99*PI ); a += (PI/noParticles)) {
      PVector loc = center;
      PVector velocity = polarPoint(new PVector(0, 0), a, tunedGauss(2, add));
      int mass = round(randomGaussian() * 20);
      particles.add(new Particle(loc, velocity, mass));
      println("Location of particle is: ", loc.x, loc.y, "\nvelocity is: ", velocity.x, velocity.y, "\nmass is: ", mass);
    }
  }
  
  public void collide() {
    Particle current;
    ListIterator<Particle> iter = particles.listIterator();
    while (iter.hasNext()) {
      current = iter.next();
      ListIterator<Particle> subIter = particles.listIterator();
      while (subIter.hasNext()) {
        Particle subject = subIter.next();
        if (current.doesCollide(subject)){
          current.collision();
        }
      }
    }
  }
  
  public boolean inBounds() {
    particles.removeIf(new ParticleOutBounds<Particle>());
    return (particles.size() > 0);
  }
  
  public void applyForce() {
    particles.forEach( new ParticleApplyForce() );
  }

  public void update() {
    particles.forEach( new ParticleUpdate() );
  }

  public void display() {
    particles.forEach( new ParticleDisplay() );
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
