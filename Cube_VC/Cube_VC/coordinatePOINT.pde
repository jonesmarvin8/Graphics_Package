import java.util.Arrays;

public class coordinatePOINT
{
  final static int DIMENSION_SIZE = 3;
  float[] pt_coords;
  
  coordinatePOINT()
  {
    pt_coords = new float[]{0,0,0};
  }
  
  public float[] get_point()
  { return pt_coords; }
  
  public void set_point_i(int i, float val)
  {
    if( 0 <= i && i < DIMENSION_SIZE)
    { pt_coords[i] = val; }
    else{
      System.out.println("ERROR: set_point_i():" + i + "is an invalid dimension.");}
  }
  
  public void set_point(float[] val)
  {
    if(val.length == DIMENSION_SIZE)
    { pt_coords = Arrays.copyOf(val, DIMENSION_SIZE); }
    else{
      System.out.println("ERROR: set_point(): val has incorrect length ("+val.length+").");}
  }
}
