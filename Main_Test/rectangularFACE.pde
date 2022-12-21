import java.util.Arrays;

public class rectangularFACE
{
  public final static int DEFAULT_NODE_SIZE = 3;
  public final static int TRI_NODE_SIZE = 3;
  public final static int QUAD_NODE_SIZE = 4;
  public final static int DIMENSION_SIZE = 3;
  public final static int DIMENSION_IMAGE_SIZE = 2;
  
  int node_size,
      node_width,
      node_height,
      face_num_width,
      face_num_height;
  
  vertexNODE[][] face_array;
  
  float[][] color_vec;
  float[][] temp_node;
  
  PImage bw;
  public rectangularFACE(int w_t, int n_t)
  //Square face
  {
    node_size = DEFAULT_NODE_SIZE;
    node_width = w_t;
    node_height = w_t;
    face_num_width = n_t;
    face_num_height = n_t;
    
    color_vec = new float[node_size][DIMENSION_IMAGE_SIZE];
    temp_node = new float[node_size][DIMENSION_SIZE];
    
    if(node_size == QUAD_NODE_SIZE)
    { init_quad_face(); }
    else if (node_size == TRI_NODE_SIZE)
    { init_tri_face(); }
    
    setup_bw();
  }
  

  
  private void init_quad_face()
  {
    face_array = new vertexNODE[face_num_height][face_num_width];
    
    for(int y = 0; y < face_array.length; y++)
    {
      for(int x = 0; x < face_array[0].length; x++)
      {
        face_array[y][x] = new vertexNODE(node_size);
        face_array[y][x].set_node( new float[][] {{x*node_width, y*node_height, 0},
                                                 {(x+1)*node_width, y*node_height, 0},
                                                 {(x+1)*node_width, (y+1)*node_height, 0},
                                                 {x*node_width, (y+1)*node_height, 0}} );
      }
    }
  }
  
  private void init_tri_face()
  //TODO: change the patterning to alternate
  {
    face_array = new vertexNODE[face_num_height][2*face_num_width];
    
    for(int y = 0; y < face_array.length; y++)
    {
      for(int x = 0; x < face_array[0].length; x++)
      {
        face_array[y][x] = new vertexNODE(node_size);
        face_array[y][x].set_node( new float[][] {{((x-x%2)/2)*node_width, y*node_height, 0},
                                                 {((x-x%2)/2 +1)*node_width, y*node_height + ((y+1)%2-x%2+y%2)*node_height, 0},
                                                 {(x/2 + x%2)*node_width, (y+1)*node_height, 0}} );
      }
    }
  }
  
  public void display()
  {
    if(node_size == QUAD_NODE_SIZE){
      beginShape(QUAD);}
    else if(node_size == TRI_NODE_SIZE){
      beginShape(TRIANGLE);}
    
    textureMode(IMAGE);
    texture(bw);  
    
    for(int y = 0; y < face_array.length; y++)
    {
      for(int x = 0; x < face_array[0].length; x++)
      {
        for(int i = 0; i < node_size; i++)
        { temp_node[i] =  Arrays.copyOf(face_array[y][x].get_point_i(i), DIMENSION_SIZE); }
        
        set_color_vec(face_array[y][x].get_color());
        
        for(int i = 0; i < node_size; i++)
        {
          vertex(temp_node[i][0], 
                 temp_node[i][1],
                 temp_node[i][2],
                 color_vec[i][0],
                 color_vec[i][1]);
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
