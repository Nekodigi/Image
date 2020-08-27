PImage img, result;
float gamma = 0.5;

void setup(){
  //size(500, 500);
  fullScreen(P3D);//P3D is faster
  img = loadImage("ImpactKaeruW.png");
  result = img.copy();
  //image(img, 0, 0, width, height);
}

void draw(){background(255);
  gamma = map(mouseX, 0, width, 0, 5);
  for(int i=0; i<img.pixels.length; i++){
    int col = img.pixels[i];
    float r = pow(red(col)/255, gamma)*255;
    float g = pow(green(col)/255, gamma)*255;
    float b = pow(blue(col)/255, gamma)*255;
    result.pixels[i] = color(r, g, b);
  }
  result.updatePixels();
  image(result, (width-height)/2, 0, height, height);
}
