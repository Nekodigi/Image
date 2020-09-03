float colorDiff(color A, color B){
  return abs(red(A)-red(B))+abs(green(A)-green(B))+abs(blue(A)-blue(B));
}
