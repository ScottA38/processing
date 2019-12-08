import java.util.LinkedList;

class CurveCircle {  
  PVector center;
  float radius;
  public CurveCircle(PVector center, float radius) {
    super();
    this.center = center;
    this.radius = radius;
  }
  
  public PShape drawCircle(float angleIncrement) {
    PShape newCurveCircle = new PShape();
    newCurveCircle = createShape();
    newCurveCircle.beginShape();
    for (float angle = 0; angle < (2 * PI) + (2 * angleIncrement); angle += angleIncrement) {
      //fill(angle, 50, 50);
      PVector circumPoint = polarPoint(this.center, angle, this.radius);
      newCurveCircle.curveVertex(circumPoint.x, circumPoint.y);
      //circle(circumPoint.x, circumPoint.y, 5);
    }
    newCurveCircle.endShape(CLOSE);
    return newCurveCircle;
  }
  
  public PVector getCenter() {
    return center;
  }
  
  public float getRadius() {
    return radius;
  }
  
  public Boolean doesCollide(CurveCircle other) {
    PVector otherCenter = other.getCenter();
    float otherRadius = other.getRadius();
    return dist(this.center.x, this.center.y, otherCenter.x, otherCenter.y) < (this.radius + otherRadius);
  }
}


PVector randomLoci() {
  PVector locus  = new PVector();
  locus.x = random((width * 0.1), (width *0.9) );
  locus.y = random((width * 0.1), (height * 0.9));
  return locus;
}
PVector polarPoint(PVector base, float angle, float distance) {
  PVector end = new PVector();
  end.x = base.x + cos(angle) * distance;
  end.y = base.y + sin(angle) * distance;
  return end;
}

CurveCircle[] circles = new CurveCircle[5];
float angleIncrement = PI / 6;

void setup() {
  noLoop();
  stroke(255);
  noFill();
  size(800, 800, P2D);
  for (int c = 0; c < circles.length; c++) {
    float radius = random(width/12, width/4);
    //30deg
    circles[c] = new CurveCircle(randomLoci(), radius);
    println("New circle's center is: " + circles[c].getCenter().x + " " + circles[c].getCenter().y + " and radius is: " + circles[c].getRadius()); 
  }
}

void draw() {
  LinkedList<CurveCircle> intersections = new LinkedList<CurveCircle>();
  for (int c = 0; c < circles.length; c++) {
    CurveCircle currentCircle = circles[c];
    PShape drawnCircle = currentCircle.drawCircle(angleIncrement);
    for (int cS=0; cS < circles.length; cS++) {
      if ( circles[cS] == currentCircle) {
        continue;
      } else if (currentCircle.doesCollide(circles[cS])) {
        println("Intersection found between circle " + c + " and circle " + cS);
        intersections.push(circles[cS]);
      }
    }
    shape(drawnCircle, 0, 0);
    for (int vert = 0; vert < drawnCircle.getVertexCount(); vert++) {
      PVector v = drawnCircle.getVertex(vert);
      for(int coll = 0; coll < intersections.size(); coll++) {
        CurveCircle examCircle = intersections.get(coll); 
        PVector collCenter = examCircle.getCenter(); //<>//
        float distance = dist(v.x, v.y, collCenter.x, collCenter.y);
        if ( distance < examCircle.getRadius()){
          circle(v.x, v.y, 10);
        }
      }
     }
  }
}
