int steps = 6;
float off = 0;

PImage img, result;

void setup(){
  //fullScreen();
  size(500, 500);
  img = loadImage("ImpactKaeruW.png");
  
}

void draw(){
  background(255);
  off = map(mouseX, 0, width, 0, 255);
  steps = (int)map(mouseY, 0, height, 1, 20);
  result = img.copy();
  for(int i=0; i<img.width; i++){
    for(int j=0; j<img.height; j++){
      color col = img.pixels[i+j*img.width];
      float rR = int((red(col)+off)/255.0*steps)*255.0/steps;
      float rG = int((green(col)+off)/255.0*steps)*255.0/steps;
      float rB = int((blue(col)+off)/255.0*steps)*255.0/steps;
      result.pixels[i+j*img.width] = color(rR, rG, rB);
    }
  }
  image(result, (width-height)/2, 0, height, height);
}
