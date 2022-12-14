import java.util.Arrays;

public class ngonFACE{
  
  public final static int DEFAULT_NODE_SIZE = 3;
  public final static int TRI_NODE_SIZE = 3;
  public final static int DIMENSION_SIZE = 3;
  public final static int DIMENSION_IMAGE_SIZE = 2;
  
  int node_size,
      node_width,
      node_height,
      face_num_width,
      face_num_height;
      
  float ngon_rad;    
      
  int num_sides;    
  
  vertexNODE[] face_array;
  
  float[][] color_vec;
  float[][] temp_node;
  
  PImage bw;
  
  ngonFACE(int ns_t, float rad_t)
  {
    num_sides = ns_t;
    ngon_rad = rad_t;
    node_size = DEFAULT_NODE_SIZE;
    color_vec = new float[node_size][DIMENSION_IMAGE_SIZE];
    temp_node = new float[node_size][DIMENSION_SIZE];
    setup_bw();
    init_face_array();
  }
  
  private void init_face_array()
  {
    face_array = new vertexNODE[num_sides];
    
    face_array[0] = new vertexNODE(node_size);
    face_array[0].set_node( new float[][] {{0, 0, 0},
                                           {ngon_rad, 0, 0},
                                           {ngon_rad*cos(2*PI/num_sides), ngon_rad*sin(2*PI/num_sides), 0}});
    
    for(int i = 1; i < face_array.length; i++)
    {
        face_array[i] = new vertexNODE(node_size);
        face_array[i].set_node( new float[][] {{0, 0, 0},
                                               {ngon_rad*cos(2*i*PI/num_sides), ngon_rad*sin(2*i*PI/num_sides), 0},
                                               {ngon_rad*cos(2*(i+1)*PI/num_sides), ngon_rad*sin(2*(i+1)*PI/num_sides), 0}});
    }
  }

  public float[] get_node_i_point_1(int i)
  { return face_array[i].get_point_i(1); }
  
  public float[] get_node_i_point_2(int i)
  { return face_array[i].get_point_i(2); }

  public void display()
  {
    beginShape(TRIANGLE);
    
    textureMode(IMAGE);
    texture(bw);  
    
    for(int t = 0; t < face_array.length; t++)
    {
      for(int i = 0; i < node_size; i++)
      { temp_node[i] =  Arrays.copyOf(face_array[t].get_point_i(i), DIMENSION_SIZE); }
      
      set_color_vec(face_array[t].get_color());
      
      for(int i = 0; i < node_size; i++)
      {
        vertex(temp_node[i][0], 
               temp_node[i][1],
               temp_node[i][2],
               color_vec[i][0],
               color_vec[i][1]);
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
