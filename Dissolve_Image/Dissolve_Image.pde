float noiseS = 100;//noise scale
float noiseP = 0.1;//nosie power
int partiL = 100;//particle lifetime
int partiS = 1;//particle size

DissolveImg dissolveImg;

void setup(){
  size(500, 500, P3D);
  //fullScreen();
  colorMode(HSB, 360, 100, 100, 100);
  //create image to disolve
  PGraphics pg;
  pg = createGraphics(width, height);
  pg.beginDraw();
  pg.background(0);
  pg.textAlign(CENTER, CENTER);
  pg.textSize(100);
  pg.text("Nekodigi", pg.width/2, pg.height/2);
  pg.endDraw();
  //create disolve img
  dissolveImg = new DissolveImg(new PVector(0, 0), pg, partiL, noiseS, noiseP, partiL, true);
  dissolveImg.toParticles(partiS, true);
}

void draw(){
  background(0);
  noStroke();
  dissolveImg.update();
  dissolveImg.show();
}

class DissolveImg{
  PImage img;
  PVector imgOff;
  int lifeTime;
  int age = 0;
  float noiseS;
  float noiseP;
  ArrayList<Particle> particles = new ArrayList<Particle>();
   //                                                                             sampling interval if pixel is black, dont create particle
  DissolveImg(PVector imgOff, PImage img, int lifeTime, float noiseS, float noiseP, int sampItv, boolean blackAsNone){
    this.imgOff = imgOff;
    this.img = img;
    this.lifeTime = lifeTime;
    this.noiseS = noiseS;
    this.noiseP = noiseP;
    toParticles(sampItv, blackAsNone);
  }
  
   
  void toParticles(int sampItv, boolean blackAsNone){
    for(int i=0; i<img.width; i+=sampItv){
      for(int j=0; j<img.height; j+=sampItv){
        color col = img.pixels[i+j*img.width];
        if(blackAsNone && col == color(0))continue;
        particles.add(new Particle(new PVector(i, j).add(imgOff), sampItv, col, lifeTime));
      }
    }
  }
  
  void update(){
    for(Particle particle : particles)particle.update();
    age++;
  }
  
  void show(){
    if(age <= lifeTime)for(Particle particle : particles)particle.show();
  }
}

class Particle{
  PVector pos;
  PVector vel = new PVector();
  color col;
  float size;
  int lifeTime;
  int age;
  
  Particle(PVector pos, float size, color col, int lifeTime){
    this.pos = pos;
    this.size = size;
    this.col = col;
    this.lifeTime = lifeTime;
  }
  
  void update(){
    float angle = noise(pos.x/noiseS, pos.y/noiseS)*TWO_PI*8;
    vel.add(PVector.fromAngle(angle).mult(noiseP));
    pos.add(vel);
    age++;
  }
  
  void show(){
    stroke(col, map(age, 0, lifeTime, 100, 0));
    strokeWeight(size);
    point(pos.x, pos.y);
  }
}
