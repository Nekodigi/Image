//based on this site en https://docs.opencv.org/3.4/d8/dbc/tutorial_histogram_calculation.html
//jp http://labs.eecs.tottori-u.ac.jp/sd/Member/oyamada/OpenCV/html/py_tutorials/py_imgproc/py_histograms/py_histogram_begins/py_histogram_begins.html
PImage img;
int[]records = new int[256];

void setup(){
  size(1000, 500);
  blendMode(ADD);
  img = loadImage("USA_Antelope-Canyon Under(PD).jpg");
  img.resize(500, 500);
  background(0);
  //img.filter(GRAY);
  image(img, 0, 0, width/2, height);
  noStroke();
  histogram(img, 0);
  histogram(img, 1);
  histogram(img, 2);
  
}

void draw(){
}

void histogram(PImage input, int type){//type=red, green blue
  int maxRecord = 0;
  for(int i=0; i<input.width; i++){
    for(int j=0; j<input.height; j++){
      int record = 0;
      switch(type){
        case 0:
          record = ++records[(int)red(input.pixels[i+j*input.width])];
          break;
        case 1:
          record = ++records[(int)green(input.pixels[i+j*input.width])];
          break;
        case 2:
          record = ++records[(int)blue(input.pixels[i+j*input.width])];
          break;
        case 3:
          record = ++records[(int)hue(input.pixels[i+j*input.width])];
          break;
        case 4:
          record = ++records[(int)saturation(input.pixels[i+j*input.width])];
          break;
        case 5:
          record = ++records[(int)brightness(input.pixels[i+j*input.width])];
          break;
      }
      maxRecord = max(maxRecord, record);
    }
  }
  float rw = float(width)/2/256;//rect width
  switch(type){
    case 0:
      fill(255, 0, 0);
      break;
    case 1:
      fill(0, 255, 0);
      break;
    case 2:
      fill(0, 0, 255);
      break;
    default:
      fill(255);
      break;
  }
  for(int i=0; i<records.length; i++){
    rect(rw*i+width/2, height, rw+1, -map(records[i], 0, maxRecord, 0, height));
  }
}
