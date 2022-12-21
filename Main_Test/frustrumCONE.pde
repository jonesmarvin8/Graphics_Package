import java.util.Arrays;
import java.util.Random;

public class frustrumCONE
{
  public final static int DEFAULT_NODE_SIZE = 3;
  public final static int TRI_NODE_SIZE = 3;
  public final static int QUAD_NODE_SIZE = 4;
  public final static int DIMENSION_SIZE = 3;
  public final static int DIMENSION_IMAGE_SIZE = 2;
  public final static int NUM_ENDS = 2;
  public final static float DEFAULT_BASE_RAD = 150;
  public final static float DEFAULT_TOP_RAD = 50;
  public final static int DEFAULT_SELECTION = 0;  
  
  int poly_num,
      lateral_layer_count;
  float base_rad,
        top_rad,
        cone_height,
        lateral_node_height,
        incr_rad;
  ngonFACE[] cone_ends;
  vertexNODE[][] lateral_array;
  
  float[][] temp_points;
  float[][] color_vec;
  color[] color_array;
    
  PShape lateral_surface;
  
  PImage bw;
  Random rand; 
  
  public frustrumCONE(int n_t, float[] rad_array, int lateral_t, float height_t)
  {      
    set_parameters(n_t, rad_array, lateral_t, height_t);
    init_lateral_array();
    
    color_vec = new float[TRI_NODE_SIZE][DIMENSION_IMAGE_SIZE];
    setup_bw();
    set_colors();
    init_lateral_surface();
  }
  
  public frustrumCONE(int n_t, float rad, int lateral_t, float height_t, int sel_t)
  {
    if(sel_t != DEFAULT_SELECTION)
    { set_parameters(n_t, new float[] {rad, 0}, lateral_t, height_t); }
    else{ set_parameters(n_t, new float[] {rad, rad}, lateral_t, height_t); }
    
    init_lateral_array();
    
    color_vec = new float[TRI_NODE_SIZE][DIMENSION_IMAGE_SIZE];
    setup_bw();
    set_colors();
    init_lateral_surface();
  }
  
  private void set_parameters(int n_t, float[] rad_array, int lateral_t, float height_t)
  {
    if(rad_array.length < 2)
    { 
      base_rad = DEFAULT_BASE_RAD;
      top_rad = DEFAULT_TOP_RAD;
    }
    else if( rad_array[0] >= rad_array[1] )
    {
      base_rad = rad_array[0];
      top_rad = rad_array[1];
    }
    else{
      base_rad = rad_array[1];
      top_rad = rad_array[0];
    }
    
    rand = new Random();
    color_array = new color[10];
    
    poly_num = n_t;
    
    cone_ends = new ngonFACE[NUM_ENDS];
    cone_ends[0] = new ngonFACE(poly_num, base_rad);
    cone_ends[1] = new ngonFACE(poly_num, top_rad);
    
    cone_height = height_t;
    lateral_layer_count = lateral_t;
    lateral_node_height = cone_height/lateral_layer_count;
    incr_rad = (base_rad-top_rad)/lateral_layer_count;  
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
        
        temp_points[0][0] = (base_rad-i*incr_rad)*cos(j*PI/poly_num);
        temp_points[0][1] = (base_rad-i*incr_rad)*sin(j*PI/poly_num);
        temp_points[0][2] = i*lateral_node_height;
        temp_points[1][0] = (base_rad-i*incr_rad)*cos(2*(j/2+1)*PI/poly_num);
        temp_points[1][1] = (base_rad-i*incr_rad)*sin(2*(j/2+1)*PI/poly_num);
        temp_points[1][2] = i*lateral_node_height; 
        
        if(i%2==0)
        { 
          temp_points[2] = Arrays.copyOf(temp_points[0], DIMENSION_SIZE);
          temp_points[2][0] -= incr_rad*cos(j*PI/poly_num);
          temp_points[2][1] -= incr_rad*sin(j*PI/poly_num);      
        }
        else{ 
          temp_points[2] = Arrays.copyOf(temp_points[1], DIMENSION_SIZE);
          temp_points[2][0] -= incr_rad*cos(2*(j/2+1)*PI/poly_num);
          temp_points[2][1] -= incr_rad*sin(2*(j/2+1)*PI/poly_num); 
        }
        

        temp_points[2][2] += lateral_node_height;
        
        lateral_array[i][j].set_node(new float[][] {temp_points[0], temp_points[1], temp_points[2]} );
        
        if(i%2 == 0)
        {
          temp_points[0] = Arrays.copyOf(temp_points[1], DIMENSION_SIZE);
          temp_points[1][0] -= incr_rad*cos(2*(j/2+1)*PI/poly_num);
          temp_points[1][1] -= incr_rad*sin(2*(j/2+1)*PI/poly_num);
          temp_points[1][2] += lateral_node_height;
        }else{
          temp_points[1] = Arrays.copyOf(temp_points[0], DIMENSION_SIZE);
          temp_points[0][0] -= incr_rad*cos(j*PI/poly_num);
          temp_points[0][1] -= incr_rad*sin(j*PI/poly_num);
          temp_points[0][2] += lateral_node_height;
        }
        
        lateral_array[i][j+1].set_node(new float[][] {temp_points[0], temp_points[1], temp_points[2]} );     
      }
    }
  }
  
  private void set_colors()
  {
    for(int i = 0; i < lateral_array.length; i++)
    {
      for(int j = 0; j < lateral_array[0].length; j++)
      {
        lateral_array[i][j].set_color(color_array[rand.nextInt(color_array.length)]);
      }
    }
  }
  
  public void update_colors()
  {
    set_colors();
    init_lateral_surface();
  }
  
  private void init_lateral_surface()
  {
    lateral_surface = createShape();
    
    lateral_surface.beginShape(TRIANGLE);
    lateral_surface.textureMode(IMAGE);
    lateral_surface.texture(bw);  
    
    for(int i = 0; i < lateral_array.length; i++)
    {
      for(int j = 0; j < lateral_array[0].length; j++)
      {
        for(int t = 0; t < TRI_NODE_SIZE; t++)
        { temp_points[t] =  Arrays.copyOf(lateral_array[i][j].get_point_i(t), DIMENSION_SIZE); }
        
        set_color_vec(lateral_array[i][j].get_color());
        
        for(int t = 0; t < TRI_NODE_SIZE; t++)
        {
          
          lateral_surface.vertex(temp_points[t][0], 
                 temp_points[t][1],
                 temp_points[t][2],
                 color_vec[t][0],
                 color_vec[t][1]);
        }
      }
    }
    
    lateral_surface.endShape(CLOSE);
  }
  
  public void display()
  {
    cone_ends[0].display();
    
    pushMatrix();
    translate(0,0, cone_height);
    cone_ends[1].display();
    popMatrix();
    
    shape(lateral_surface,0,0);
  }

  private void setup_bw()
  {
    color_array[0] = color(0,0,0,255);
    color_array[1] = color(255,0,0,255);
    color_array[2] = color(0,128,0,255);
    color_array[3] = color(0,0,255,255);
    color_array[4] = color(192,192,192,255);
    color_array[5] = color(255,255,0,255);
    color_array[6] = color(128,0,128,255);
    color_array[7] = color(0,0,128,255);
    color_array[8] = color(128,0,128,255);
    color_array[9] = color(255,255,255,255);
    
    bw = createImage(10, 100, ARGB);
    for (int i = 0; i < bw.height; i++)
    {
      for (int j = 0; j < 10; j++)
      { 
        bw.set(j, i, color_array[(i-i%10)/10]);
      }
    }
  }

  private void set_color_vec(color c_t)
  {
    int temp = -1;
    int i = 0;
    
    while(temp == -1)
    {
      if(red(c_t) == red(color_array[i]) && blue(c_t) == blue(color_array[i]) && green(c_t) == green(color_array[i]))
      { temp = i; }
      else{ i++; }
    }
    
    color_vec[0] = Arrays.copyOf( new float[] {0,i*10}, 2);
    color_vec[1] = Arrays.copyOf( new float[] {9,i*10}, 2);
    color_vec[2] = Arrays.copyOf( new float[] {9,(i+1)*10-1}, 2); 
  }
}
