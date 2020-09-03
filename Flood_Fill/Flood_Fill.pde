PImage img;
color fillColor;
ArrayList<Set> sets;//pixel that I have to calculate
float tolerance=10;//color tolerance

void setup(){
  size(500, 500);
  img = loadImage("FevCat.png");
  img.resize(200, 200);
  fillColor = color(255, 0, 0);
}

void draw(){
  image(img, 0, 0, width, height);
}

void mousePressed(){
  img.loadPixels();
  int i = (int)map(mouseX, 0, width, 0, img.width);
  int j = (int)map(mouseY, 0, height, 0, img.height);
  sets = new ArrayList<Set>();
  sets.add(new Set(i, j));
  floodFill(img.pixels[i+j*img.width], fillColor);
  img.updatePixels();
}

void floodFill(color targetColor, color fillColor){
  while(sets.size() > 0){
    Set set = sets.remove(0);
    int tx = set.tx;
    int ty = set.ty;
    if(tx<0 || img.width-1<tx || ty<0 || img.height-1<ty)continue;
    if(colorDiff(img.pixels[tx+ty*img.width], targetColor) <= tolerance && img.pixels[tx+ty*img.width] != fillColor){
      img.pixels[tx+ty*img.height] = fillColor;
      sets.add(new Set(tx+1, ty));
      sets.add(new Set(tx-1, ty));
      sets.add(new Set(tx, ty+1));
      sets.add(new Set(tx, ty-1));
    }
  }
}

class Set{
  int tx, ty;
  
  Set(int tx, int ty){
    this.tx = tx;
    this.ty = ty;
  }
}
