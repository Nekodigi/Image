//based on this site https://en.wikipedia.org/wiki/Connected-component_labeling
import java.util.Queue;
import java.util.ArrayDeque;

int ni = 20;
int nj = 20;
float pixelS;
boolean useEight = true;//use eight neighbors
Cell[][] datas = new Cell[ni][nj];

void setup(){
  colorMode(HSB, 360, 100, 100);
  size(500, 500);
  pixelS = float(height)/nj;
  for(int i=0; i<ni; i++){
    for(int j=0; j<nj; j++){
      datas[i][j] = new Cell(i, j);
      if(random(3)<1)datas[i][j].d = true;
      else datas[i][j].d = false;
    }
  }
  for(int i=0; i<ni; i++){
    for(int j=0; j<nj; j++){
      datas[i][j].calcAdj();
    }
  }
  solve();
  showDatas();
}

void draw(){
  
}

void solve(){
  int currentL = 1;//current label
  for(int i=0; i<ni; i++){
    for(int j=0; j<nj; j++){
      Cell cell = datas[i][j];
      if(cell.d == true && cell.label == 0){
        cell.label = currentL;
        flood(cell);
        currentL++;
      }
    }
  }
}

void flood(Cell input){//set label to all connecting cell 
  Queue<Cell> cells = new ArrayDeque<Cell>();
  cells.add(input);
  while(cells.size() > 0){
    Cell cell = cells.poll();
    for(Cell adj : cell.adjs){
      if(adj != null && adj.d == true && adj.label == 0){cells.add(adj);
        adj.label = input.label;
      }
    }
  }
}
