import java.util.Comparator;

class ImageComp implements Comparator<Image>{//compare image brightness
  @Override
  public int compare(Image a, Image b){
    if(brightness(a.avgCol) == brightness(b.avgCol))return 0;
    return brightness(a.avgCol) > brightness(b.avgCol) ? 1 : -1;
  }
}
