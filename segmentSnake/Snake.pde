import java.util.LinkedList;
import java.util.ListIterator;

class Snake extends LinkedList<Segment> {
  float segmentLength;
  Snake(float segmentLength, int amountSegs) {
    //int counter = amountSegs;
    PVector drawFrom = new PVector(width/2, height/2);
    Segment newSeg;
    while (amountSegs > 0) {
      newSeg = new Segment(drawFrom.x, drawFrom.y, segmentLength);
      this.push(newSeg);
      drawFrom = newSeg.getEnd();
      amountSegs--;
    }
  }
  Segment getHead() {
    return this.peek();
  }
  
  void drag() {
    PVector in = new PVector(mouseX, mouseY); //<>//
    ListIterator<Segment> iter = this.listIterator();
    while (iter.hasNext()) {
      if (iter.hasPrevious()){
        in = this.get(iter.previousIndex()).getPos();
      }
      iter.next().drag(in.x, in.y);
    }
  }
  
  void display() {
    ListIterator<Segment> iter = this.listIterator();
    while (iter.hasNext()){
      iter.next().display();
    }
  }
}
