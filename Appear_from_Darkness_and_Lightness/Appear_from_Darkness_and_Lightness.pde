PImage baseImgD, baseImgW, resultImg;
float darkness = 0;
float lightness = 0;
boolean fromDarkness = true;

void setup(){
  size(500, 500);
  //fullScreen();
  baseImgD = loadImage("ImpactKaeruB.png");
  baseImgD.filter(GRAY);
  baseImgW = loadImage("ImpactKaeruW.png");
  baseImgW.filter(GRAY);
  
}

void draw(){
  darkness = sin(frameCount/50.)*255;
  lightness = 255 - darkness;
  if(fromDarkness){
    background(darkness);
    resultImg = baseImgW.copy();
    for(int i=0; i<resultImg.width; i++){
      for(int j=0; j<resultImg.height; j++){
        color col = resultImg.pixels[i+j*resultImg.width];
        if(brightness(col) > darkness){
          resultImg.pixels[i+j*resultImg.width] = color(darkness, darkness, darkness);
        }
      }
    }
  }else{
    resultImg = baseImgD.copy();
    background(lightness);
    for(int i=0; i<resultImg.width; i++){
      for(int j=0; j<resultImg.height; j++){
        color col = resultImg.pixels[i+j*resultImg.width];
        if(brightness(col) < lightness){
          resultImg.pixels[i+j*resultImg.width] = color(lightness, lightness, lightness);
        }
      }
    }
  }
  image(resultImg, (width-height)/2, 0, height, height);
}
