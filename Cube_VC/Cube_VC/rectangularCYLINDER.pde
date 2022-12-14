public class rectangularCYLINDER
{
  public final static int DEFAULT_NODE_SIZE = 3;
  public final static int TRI_NODE_SIZE = 3;
  public final static int QUAD_NODE_SIZE = 4;
  public final static int DIMENSION_SIZE = 3;
  public final static int DIMENSION_IMAGE_SIZE = 2;
  public final static int NUM_ENDS = 2;
    
  int poly_num;
  float base_rad,
        cylinder_height;
  ngonFACE[] cylinder_ends;
  vertexNODE[][] lateral_array;
  
  public rectangularCYLINDER(int n_t, float rad_t, float height_t)
  {
    base_rad = rad_t;
    poly_num = n_t;
    cylinder_ends = new ngonFACE[NUM_ENDS];
    cylinder_ends[0] = new ngonFACE(poly_num, base_rad);
    
    cylinder_height = height_t;
  }

}
