import java.util.Arrays;

public class rectangularFACE
{
  public static final int NUM_FACES = 6;
  public final static int NODE_SIZE = 4;
  public final static int DIMENSION_SIZE = 3;
  
  int node_width,
      node_height,
      face_num_width,
      face_num_height;
  
  squareNODE[][] face_array;
  
  float[][] color_vec;
  float[][] temp_node;
  
  PImage bw;
  public rectangularFACE(int w_t, int n_t)
  //Square face
  {
    node_width = w_t;
    node_height = w_t;
    face_num_width = n_t;
    face_num_height = n_t;
    
    color_vec = new float[4][2];
    
    temp_node = new float[4][3];
    
    init_face();
    setup_bw();
  }
  
  private void init_face()
  {
    face_array = new squareNODE[face_num_width][face_num_height];
    
    for(int x = 0; x < face_num_width; x++)
    {
      for(int y = 0; y < face_num_height; y++)
      {
        face_array[x][y] = new squareNODE();
        face_array[x][y].set_node( new float[][] {{x*node_width, y*node_height, 0},
                                                 {(x+1)*node_width, y*node_height, 0},
                                                 {(x+1)*node_width, (y+1)*node_height, 0},
                                                 {x*node_width, (y+1)*node_height, 0}} );
      }
    }
  }
  
  public void display()
  {
    beginShape(QUAD);
    textureMode(IMAGE);
    texture(bw);  
    
    for(int x = 0; x < face_num_width; x++)
    {
      for(int y = 0; y < face_num_width; y++)
      {
        for(int i = 0; i < NODE_SIZE; i++)
        { temp_node[i] =  Arrays.copyOf(face_array[x][y].get_point_i(i), DIMENSION_SIZE); }
        
        set_color_vec(face_array[x][y].get_color());
        vertex(temp_node[0][0], 
               temp_node[0][1],
               temp_node[0][2],
               color_vec[0][0],
               color_vec[0][1]);
        vertex(temp_node[1][0], 
               temp_node[1][1],
               temp_node[1][2],
               color_vec[1][0],
               color_vec[1][1]);
        vertex(temp_node[2][0], 
               temp_node[2][1],
               temp_node[2][2],
               color_vec[2][0],
               color_vec[2][1]);
        vertex(temp_node[3][0], 
               temp_node[3][1],
               temp_node[3][2],
               color_vec[3][0],
               color_vec[3][1]);
   
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
