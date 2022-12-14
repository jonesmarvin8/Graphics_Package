import java.util.Arrays;

public class rectangularCYLINDER
{
  public final static int DEFAULT_NODE_SIZE = 3;
  public final static int TRI_NODE_SIZE = 3;
  public final static int QUAD_NODE_SIZE = 4;
  public final static int DIMENSION_SIZE = 3;
  public final static int DIMENSION_IMAGE_SIZE = 2;
  public final static int NUM_ENDS = 2;
    
  int poly_num,
      lateral_layer_count;
  float base_rad,
        cylinder_height,
        lateral_node_height;
  ngonFACE[] cylinder_ends;
  vertexNODE[][] lateral_array;
  
  float[][] temp_points;
  float[][] color_vec;
  
  PImage bw;
  
  public rectangularCYLINDER(int n_t, float rad_t, int lateral_t, float height_t)
  {
    base_rad = rad_t;
    poly_num = n_t;
    
    cylinder_ends = new ngonFACE[NUM_ENDS];
    cylinder_ends[0] = new ngonFACE(poly_num, base_rad);
    cylinder_ends[1] = new ngonFACE(poly_num, base_rad);
    
    cylinder_height = height_t;
    
    lateral_layer_count = lateral_t;
    lateral_node_height = cylinder_height/lateral_layer_count;
    init_lateral_array();
    
    color_vec = new float[TRI_NODE_SIZE][DIMENSION_IMAGE_SIZE];
    setup_bw();
  }

  private void init_lateral_array()
  {
    temp_points = new float[TRI_NODE_SIZE][DIMENSION_SIZE];
    
    lateral_array = new vertexNODE[lateral_layer_count][2*poly_num];
    
    for(int i = 0; i < lateral_array.length; i++)
    {
      for(int j = 0; j < lateral_array[0].length; j+=2)
      {
        lateral_array[i][j] = new vertexNODE(TRI_NODE_SIZE);
        lateral_array[i][j+1] = new vertexNODE(TRI_NODE_SIZE);
        
        temp_points[0] = Arrays.copyOf(cylinder_ends[0].get_node_i_point_1(j/2), DIMENSION_SIZE);
        temp_points[1] = Arrays.copyOf(cylinder_ends[0].get_node_i_point_2(j/2), DIMENSION_SIZE);
        if(i%2==0)
        { temp_points[2] = Arrays.copyOf(cylinder_ends[0].get_node_i_point_1(j/2), DIMENSION_SIZE); }
        else{ temp_points[2] = Arrays.copyOf(cylinder_ends[0].get_node_i_point_2(j/2), DIMENSION_SIZE); }
        
        temp_points[0][2] += i*lateral_node_height;
        temp_points[1][2] += i*lateral_node_height;
        temp_points[2][2] += (i+1)*lateral_node_height;
        
        lateral_array[i][j].set_node(new float[][] {temp_points[0], temp_points[1], temp_points[2]} );
        
        if(i%2 == 0)
        {
          temp_points[0] = Arrays.copyOf(temp_points[1], DIMENSION_SIZE);
          temp_points[1][2] += lateral_node_height;
        }else{
          temp_points[1] = Arrays.copyOf(temp_points[0], DIMENSION_SIZE);
          temp_points[0][2] += lateral_node_height;
        }
        
        lateral_array[i][j+1].set_node(new float[][] {temp_points[0], temp_points[1], temp_points[2]} );
        
      }
    }
  }
  
  public void display()
  {
    cylinder_ends[0].display();
    
    pushMatrix();
    translate(0,0,cylinder_height);
    cylinder_ends[1].display();
    popMatrix();

    
    for(int i = 0; i < lateral_array.length; i++)
    {
      for(int j = 0; j < lateral_array[0].length; j++)
      {
        for(int t = 0; t < TRI_NODE_SIZE; t++)
        { temp_points[t] =  Arrays.copyOf(lateral_array[i][j].get_point_i(t), DIMENSION_SIZE); }
        
        set_color_vec(lateral_array[i][j].get_color());
        
        for(int t = 0; t < TRI_NODE_SIZE; t++)
        {
          vertex(temp_points[t][0], 
                 temp_points[t][1],
                 temp_points[t][2],
                 color_vec[t][0],
                 color_vec[t][1]);
        }
      }
    }
    
    endShape();      
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
