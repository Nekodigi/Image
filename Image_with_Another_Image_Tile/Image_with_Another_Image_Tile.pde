import java.util.Collections;

PImage baseImg, targetImg;
ArrayList<Image> images;//base image(used as tile)
ArrayList<Image> timages;//target images
int tileS = 10;
int nw, nh;

void setup(){
  size(1000, 1000);
  //fullScreen();
  baseImg = loadImage("Mona_Lisa Small.jpg");
  baseImg.resize(width, height);
  targetImg = loadImage("ImpactKaeru.png");
  targetImg.resize(width, height);
  //baseImg.filter(GRAY);
  //targetImg.filter(GRAY);
}

void draw(){
  background(0);
  images = new ArrayList<Image>();
  timages = new ArrayList<Image>();
  tileS = (int)map(mouseX, 0, width, 10, width);
  nw = ceil((float)baseImg.width / tileS);
  nh = ceil((float)baseImg.height/ tileS);
  //divide base image to images
  for(int i=0; i<baseImg.width; i+=tileS){
    for(int j=0; j<baseImg.height; j+=tileS){
      images.add(new Image(i, j, baseImg.get(i, j, tileS, tileS)));
    }
  }
  for(Image img : images){
    img.calcAvg();
  }
  Collections.sort(images, new ImageComp());
  //divide target image to images
  for(int i=0; i<targetImg.width; i+=tileS){
    for(int j=0; j<targetImg.height; j+=tileS){
      timages.add(new Image(i, j, targetImg.get(i, j, tileS, tileS)));
    }
  }
  for(Image img : timages){
    img.calcAvg();
  }
  Collections.sort(timages, new ImageComp());//link tile with sort number
  for(int i=0; i<nw*nh; i++)timages.get(i).img = images.get(i).img;
  for(int i=0; i<nw; i++){
    for(int j=0; j<nh; j++){
      timages.get(i+j*nw).show();
    }
  }
}

class Image{
  PVector pos;
  PImage img;
  color avgCol;
  
  Image(float x, float y, PImage img){
    this.pos = new PVector(x, y);
    this.img = img;
  }
  
  void calcAvg(){
    float r = 0, g = 0, b = 0;
    int count = 0;
    for(int i=0; i<img.width; i++){
      for(int j=0; j<img.height; j++){
        color tcol = img.pixels[i+j*img.width];
        r += red(tcol);
        g += green(tcol);
        b += blue(tcol);
        count++;
      }
    }
    avgCol = color(r/count, g/count, b/count);
  }
  
  void show(){
    noStroke();
    fill(avgCol);
    //rect(pos.x, pos.y, tileS, tileS);
    image(img, pos.x, pos.y);
  }
}
