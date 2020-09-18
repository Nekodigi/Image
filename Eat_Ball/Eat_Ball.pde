PImage bodyImg, headImg;
PVector rotateO = new PVector(182, 234);//rotate origin
float openDst = 300;

void setup(){
  size(500, 500);
  headImg = loadImage("ImpactKaeruHead.png");
  bodyImg = loadImage("ImpactKaeruBody.png");
  
  
}

void draw(){
  background(255);
  fill(255, 0, 0);
  ellipse(mouseX, mouseY, 50, 50);
  pushMatrix();
  translate(rotateO.x, rotateO.y);
  float dst = dist(mouseX, mouseY, rotateO.x, rotateO.y);
  //rotate(map(mouseX, 0, width, -QUARTER_PI, 0));
  rotate(constrain(map(openDst-dst, 0, openDst/2, 0, -QUARTER_PI), -QUARTER_PI, 0));
  image(headImg, -rotateO.x, -rotateO.y, width, height);
  popMatrix();
  
  image(bodyImg, 0, 0, width, height);
}

void mousePressed(){
  println(mouseX, mouseY);
}
