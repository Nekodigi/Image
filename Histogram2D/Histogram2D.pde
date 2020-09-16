//based on this site en https://docs.opencv.org/master/dd/d0d/tutorial_py_2d_histogram.html
//jp https://docs.opencv.org/master/dd/d0d/tutorial_py_2d_histogram.html
PImage img;
int divres = 1;//divide resolution
int[][]records = new int[256/divres][256/divres];

void setup(){
  size(1000, 500, P3D);
  ortho();
  //blendMode(ADD);
  //img = loadImage("USA_Antelope-Canyon Under(PD).jpg");
  img = loadImage("Mona_Lisa Small.jpg");
  //img = loadImage("ImpactKaeruW.png");
  img.resize(500, 500);
  background(0);
  //img.filter(GRAY);
  image(img, 0, 0, width/2, height);
  histogram(img, 0);
  //histogram(img, 1);
  //histogram(img, 2);
  
}

void draw(){
}

void histogram(PImage input, int type){//type=red, green blue
  int maxRecord = 0;
  for(int i=0; i<input.width; i++){
    for(int j=0; j<input.height; j++){
      int record = ++records[(int)hue(input.pixels[i+j*input.width])/divres][(int)saturation(input.pixels[i+j*input.width])/divres];
      maxRecord = max(maxRecord, record);
    }
  }
  float rw = float(width)/2/(256/divres-1);//rect width
  float rh = float(height)/(256/divres-1);//rect height
  //stroke(255);
  //noFill();
  //lights();
  colorMode(HSB);
  noStroke();
  translate(0, height/2, -height);
  rotateX(1);
  for(int j=0; j<records[0].length-1; j++){
    beginShape(TRIANGLE_STRIP);
    for(int i=0; i<records.length; i++){
      //rect(rw*i+width/2, height, rw+1, -map(records[i][j], 0, maxRecord, 0, height));
      fill(map(records[i][j], 0, maxRecord, 0, 255), 255, 255);
      vertex(rw*i+width/2, rh*j, map(records[i][j], 0, maxRecord, 0, 255), 255, 255);
      fill(map(records[i][j+1], 0, maxRecord, 0, 255), 255, 255);
      vertex(rw*i+width/2, rh*j+rh, map(records[i][j+1], 0, maxRecord, 0, 255), 255, 255);
    }
    endShape();
  }
}
