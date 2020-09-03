PImage img, result;
float gamma = 1;

void setup(){
  size(500, 500);
  //fullScreen(P3D);//P3D is faster
  colorMode(HSB, 360, 100, 100);
  img = loadImage("ImpactKaeruW.png");
  result = img.copy();
  //image(img, 0, 0, width, height);
}

void draw(){background(360);
  //gamma = map(mouseX, 0, width, 0, 5);
  for(int i=0; i<img.pixels.length; i++){
    int col = img.pixels[i];
    float h = (hue(col)+frameCount)%360;
    float s = saturation(col);
    float b = brightness(col);
    result.pixels[i] = color(h, s, b);
  }
  result.updatePixels();
  image(result, (width-height)/2, 0, height, height);
}
