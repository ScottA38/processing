PVector polarPoint(PVector base, float angle, float distance) {
  PVector end = new PVector();
  end.x = base.x + cos(angle) * distance;
  end.y = base.y + sin(angle) * distance;
  return end;
}

float[] sinColour(int max, float angle) {
  int[] phase = { 0, 2, 4 };
  float[] result = new float[3];
  for (int i = 0; i < phase.length; i++) {
    result[i] = abs(sin(0.3 *  angle + i  ) * max);
  }
  return result;
}

PVector center = new PVector();


void setup() {
  size(800, 800);
  noLoop();
  center.x = width /2;
  center.y = height/2;
  strokeWeight(5);
  strokeCap(3);
  fill(0,0,0);
}

void draw() {
  for ( float i =0; i<(1.999999*PI); i += 10 * (PI/180)) {
    PVector point = polarPoint(center, i, 300);
    float[] strokeCol = sinColour(255, i); 
    stroke(strokeCol[0], strokeCol[1], strokeCol[2]);
    PVector offset = polarPoint(point, i, 10);
    fill(255 - strokeCol[0], 255 - strokeCol[1], 255 - strokeCol[2]);
    circle(offset.x, offset.y, 20);
    line(center.x, center.y, point.x, point.y);
  }
}
