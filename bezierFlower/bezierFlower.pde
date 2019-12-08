void radialGradient(PShape parent, int radius, float x, float y) { //<>//
  //set env
  ellipseMode(RADIUS);
  noStroke();
  colorMode(HSB, 360, 100, 100);
  float h = 280;
  for (int r = radius; r > 0; r-= 1) {
    PShape circ = createShape(ELLIPSE, x, y, r, r);
    circ.colorMode(HSB, 360, 100, 100);
    circ.setFill(color(h, 90, 90));
    circ.setStrokeWeight(0);
    parent.addChild(circ);
    h = (h + 1) % 360;
  }
  //reset
  stroke(255);
  ellipseMode(CENTER);
  colorMode(RGB, 255, 255, 255);
}

PVector polarPoint(PVector base, float angle, float distance) {
  PVector end = new PVector();
  end.x = base.x + cos(angle) * distance;
  end.y = base.y + sin(angle) * distance;
  return end;
}

color sinColour(int max, float angle) {
  float[] result = new float[3];
  for (int i = 0; i < result.length; i++) {
    result[i] = abs( sin(0.3 *  angle + i ) * max);
  }
  return color(result[0], result[1], result[2]);
}

Boolean overCircle(PShape reference, float[] matrixOut) {
  float largestRadius = reference.getChildren()[0].getParams()[2];
  float sfX = matrixOut[0];
  return (dist(mouseX, mouseY, width/2, height/2) < (largestRadius * sfX));
}

PVector center = new PVector(0, 0);
float angleIncrement = (30 * PI/180);
PVector[] bezArray = new PVector[4];

PMatrix currentMatrix = new PMatrix2D();
float[] currentMatrixOut = null;

PShape flower, pistil, petal = new PShape();

void setup() {
  size(800, 800, P2D);
  currentMatrix.translate(width/2, height/2);
  stroke(255);
  strokeWeight(5);

  flower = createShape(GROUP);
  pistil = createShape(GROUP);
  radialGradient(pistil, 125, 0, 0);

  for (float angle = 0; angle < (2*PI); angle += angleIncrement) {
    bezArray[0] = polarPoint(center, (angle - (0.25 * angleIncrement)), 400);
    bezArray[1] = polarPoint(center, angle, 125);
    bezArray[2] = polarPoint(center, (angle + (1.25 * angleIncrement)), 400);
    bezArray[3] = polarPoint(center, (angle + angleIncrement), 125);
    petal = createShape();
    petal.beginShape();
    petal.vertex(bezArray[1].x, bezArray[1].y);
    petal.bezierVertex(bezArray[0].x, bezArray[0].y, bezArray[2].x, bezArray[2].y, bezArray[3].x, bezArray[3].y);
    petal.endShape();
    petal.setStroke(color(100, 100, 100));
    flower.addChild(petal);
  } 
  flower.addChild(pistil);
}

void draw() {
  currentMatrixOut = currentMatrix.get(currentMatrixOut); //<>//
  clear();
  applyMatrix(currentMatrix);
  if (overCircle(pistil, currentMatrixOut) && currentMatrixOut[0] < 1.5 && currentMatrixOut[4] < 1.5) {
    currentMatrix.scale(1.01);
  } else if (currentMatrixOut[0] > 0.3 && currentMatrixOut[4] > 0.3) {
    currentMatrix.scale(0.99);
  }
  PShape[] children = flower.getChildren();
  for (int ch = 0; ch < children.length; ch++) {
    if (children[ch].getKind() == 20) {
      children[ch].setFill(sinColour(255, map(currentMatrixOut[0], 0.3, 1.5, 0, (2*PI))));
    }
  }
  shape(flower, 0, 0);
}
