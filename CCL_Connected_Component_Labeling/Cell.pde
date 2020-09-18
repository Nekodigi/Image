class Cell{
  boolean d;//binarized pixel data
  int label = 0;
  Cell[] adjs;//adjacent(neighbors)
  int x, y;//position
  
  Cell(int x, int y){
    this.x = x;
    this.y = y;
  }
  
  void calcAdj(){
    if(useEight)adjs = new Cell[8];
    else adjs = new Cell[4];
    if(x != 0)adjs[0] = datas[x-1][y];
    if(y != 0)adjs[1] = datas[x][y-1];
    if(x != ni-1)adjs[2] = datas[x+1][y];
    if(y != nj-1)adjs[3] = datas[x][y+1];
    if(useEight){
      if(x != 0 && y != 0)adjs[4] = datas[x-1][y-1];
      if(x != ni-1 && y != 0)adjs[5] = datas[x+1][y-1];
      if(x != ni-1 && y != nj-1)adjs[6] = datas[x+1][y+1];
      if(x != 0 && y != nj-1)adjs[7] = datas[x-1][y+1];
    }
  }
  
  void show(){
    if(d){fill((label*30)%360, 100, 100);
    
    }else fill(0);
    rect(x*pixelS, y*pixelS, pixelS, pixelS);
  }
}
