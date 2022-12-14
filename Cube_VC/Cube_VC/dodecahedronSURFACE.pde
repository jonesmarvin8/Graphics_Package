import java.util.Arrays;

public class dodecahedronSURFACE
{
  public final static int DEFAULT_NODE_SIZE = 3;
  public final static int TRI_NODE_SIZE = 3;
  public final static int QUAD_NODE_SIZE = 4;
  public final static int DIMENSION_SIZE = 3;
  public final static int DIMENSION_IMAGE_SIZE = 2;
  public final static int NUM_ENDS = 2;
    
  int poly_num;
  float base_rad;
  ngonFACE[] face_array;
  
  float[][] temp_points;
  float[][] color_vec;
  
  PImage bw;
  
  public dodecahedronSURFACE(int n_t, float rad_t)
  {
    base_rad = rad_t;
    poly_num = n_t;
    
    face_array = new ngonFACE[12];
    
    for(int i = 0; i < 12; i++)
    { face_array[i] = new ngonFACE(5, base_rad); }

    color_vec = new float[TRI_NODE_SIZE][DIMENSION_IMAGE_SIZE];
    setup_bw();
  }

 
  public void display()
  {
    face_array[0].display();
    pushMatrix();
    rotateX(-116.57*PI/180);
    translate(base_rad*cos(108*PI/180),base_rad*sin(108*PI/180),0);
    face_array[1].display();
    popMatrix();
    
  }

  //TODO: needed?
  //minimize size for memory usage.
  private void setup_bw()
  {
    bw = createImage(50, 50, ARGB);
    for (int i = 0; i < 25; i++)
    {
      for (int j = 0; j < 50; j++)
      { 
        bw.set(i, j, color(255, 255, 255, 150));
      }
    }

    for (int i = 25; i < 50; i++)
    {
      for (int j = 0; j < 50; j++)
      { 
        bw.set(i, j, color(0, 0, 0, 150));
      }
    }
  }

  //TODO: fix these in general.
  private void set_color_vec(int c_t)
  {
    if(c_t == 255)
    {
      color_vec[0] = Arrays.copyOf( new float[] {0,0}, 2);
      color_vec[1] = Arrays.copyOf( new float[] {24,0}, 2);
      color_vec[0] = Arrays.copyOf( new float[] {24,24}, 2);
      color_vec[1] = Arrays.copyOf( new float[] {0,24}, 2);
    } else if (c_t == 0)
    {
      color_vec[0] = Arrays.copyOf( new float[] {26,0}, 2);
      color_vec[1] = Arrays.copyOf( new float[] {49,0}, 2);
      color_vec[0] = Arrays.copyOf( new float[] {49,24}, 2);
      color_vec[1] = Arrays.copyOf( new float[] {26,24}, 2);
    }
  }

}
