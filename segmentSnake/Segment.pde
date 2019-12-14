
class Segment {
  PVector pos = new PVector();
  float angle;
  float len;
  Segment(float x, float y, float l){
    pos.x = x;
    pos.y = y;
    angle = 0;
    len = l;
  }
  
  PVector getPos() {
    return pos;
  }
  PVector getEnd() {
    PVector end = new PVector();
    end.x = pos.x + cos( angle ) * len;
    end.y = pos.y + sin( angle ) * len;
    return end;
  }
  
  void drag(float xin, float yin) {
    float dx = xin - pos.x;
    float dy = yin - pos.y;
    angle = atan2(dy, dx);
    angle = map(angle, 0, (2 * PI), 0, (2 * PI));
    pos.x = xin - cos(angle) * len;
    pos.y = yin - sin(angle) * len;
  }
  
  void display() {
    pushMatrix();
    stroke(pos.x, pos.y, angle);
    translate(pos.x, pos.y);
    rotate(angle);
    line(0, 0, len, 0);
    popMatrix();
  }
}
