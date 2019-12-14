
//Segment[] segs = new Segment[5];
Snake snake = new Snake(50, 10);

void setup() {
  //for (int s = 0; s< segs.length; s++) {
  //  if ( s > 0 ) {
  //    Segment prev = segs[s-1];
  //    PVector prevPos = prev.getPos();
  //    segs[s] = new Segment(prevPos.x, prevPos.y, 50);
  //  } else {
  //    segs[s] = new Segment(width/2, height/2, 50);
  //  }
    
  //}
  size(1000, 1000);
  strokeWeight(20);
  stroke(255, 100);
}

void draw() {
  background(0);
  //for (int s = 0; s< segs.length; s++) {
  //  if (s == 0 ) {
  //    segs[s].drag(mouseX, mouseY);
  //    segs[s].display();
  //  }
  //  else {
  //    PVector prev = segs[s-1].getPos();
  //    segs[s].drag(prev.x, prev.y);
  //    segs[s].display();
  //  }
  //}
  snake.drag(); //<>//
  snake.display();
}
