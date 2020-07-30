import ddf.minim.*;
import ddf.minim.signals.*;
Minim minim;
AudioOutput out;
PImage img;
SineWave[] sines;
int si = 40;//sampling interval
float octDiv = 80;

void setup() {
  size(500, 500);
  minim = new Minim(this);
  out = minim.getLineOut(Minim.MONO);
  img = loadImage("ImpactKaeru.png");
  img.resize(width, height);
  img.filter(GRAY);
  sines = new SineWave[img.height/si];

  noStroke();
  fill(0);
  for (int j=0; j<img.height/si; j++) {
    sines[j] = new SineWave(440*pow(pow(2, 1./12), j*si/octDiv), 0.2, out.sampleRate());
    sines[j].portamento(100);
    out.addSignal(sines[j]);
  }
}

void draw() {
  background(255);
  image(img, 0, 0);
  int sampleX = int(float(frameCount)%img.width);
  for (int j=0; j<img.height/si; j++) {
    float bright = brightness(img.pixels[imgIx(sampleX, j*si)]);
    sines[j].setAmp(bright/255/10);//https://yoppa.org/bma10/1365.html
    rect(sampleX+bright*0.1, j*si, 20, 20);
  }
}

int imgIx(int i, int j) {//image index
  return j*img.width + i;
}
