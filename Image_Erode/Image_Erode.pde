PImage img;
float[][] gaussMat;
int matSize = 10;
void setup(){
  size(500, 500);
  img = loadImage("ErodeTest.png");
  
  gaussMat = getGaussMat(10, matSize);
  image(img, 0, 0, width, height);
  
  loadPixels();
  for(int x=0; x<width; x++){
    for(int y=0; y<height; y++){
      float r = 0, g = 0, b = 0;
      for(int i=-matSize; i<=matSize; i++){
        for(int j=-matSize; j<=matSize; j++){
          int ci0 = constrain(i+x, 0, width-1);
          int cj0 = constrain(j+y, 0, height-1);
          int col = pixels[cj0*width+ci0];
          int ci = constrain(i+matSize, 0, width);
          int cj = constrain(j+matSize, 0, height);
          r += red(col)*gaussMat[ci][cj];
          g += green(col)*gaussMat[ci][cj];
          b += blue(col)*gaussMat[ci][cj];
        }
      }
      pixels[y*width+x] = color(r, g, b);
    }
  }
  updatePixels();
}

void draw(){
  
}

float[][] getGaussMat(float sigma, int size){
  float[][] result = new float[size*2+1][size*2+1];
  float sum = 0;
  for(int i = -size; i <= size; i++){
    for(int j = -size; j <= size; j++){
      float r2 = i*i + j*j;
      float gs = gaussF(sigma, r2);
      result[i+size][j+size] = gs;
      sum+=gs;
    }
  }
  //normalize value
  for(int i = -size; i <= size; i++){
    for(int j = -size; j <= size; j++){
      result[i+size][j+size] /= sum;
    }
  }
  return result;
}

float gaussF(float sigma, float x2){
  return exp(-x2/(2*sigma*sigma))/(2*PI*sigma*sigma);
}
