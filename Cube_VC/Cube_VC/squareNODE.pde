/*
Authors: Marvin Jones, Linds Wise
File: squareNODE
Description: This class constructs the insistance of a square node
 for a 3d visual cryptography scheme.
 
Attributes:
node_coords[][] - 4 coordinate points for each vertex of the square.
node_color - color; CURRENTLY an int for just black and white.
*/

public class squareNODE
{
  public final static int NODE_SIZE = 4;
  public final static int DIMENSION_SIZE = 3;
  public final static int COLOR_DEFAULT = 255;
  
  float[][] node_coords;
  int node_color;
  
  squareNODE()
  {
    node_color = 255; //Default color to white.
    node_coords = new float[4][3];
    init_coords();
  }
  
  //Defaults the coordinates for each vertex to (0,0,0).
  private void init_coords()
  {
    for(int i = 0; i < NODE_SIZE; i++)
    {
      for(int j = 0; j < DIMENSION_SIZE; j++)
      { node_coords[i][j] = 0; }
    }  
  }
    
  public void set_color(int c_t)
  { 
    if( c_t == 255 || c_t == 0)
    { node_color = c_t; }
    else{ c_t = COLOR_DEFAULT; } 
  } 
  
  public int get_color()
  { return node_color; }

  public void invert_color()
  { node_color = 255-node_color; }
  
  
  //Sets the i-th coordinates point.
  public void set_coords_i(int i, float x_t, float y_t, float z_t)
  {
    node_coords[i][0] = x_t;
    node_coords[i][1] = y_t;
    node_coords[i][2] = z_t;
  }
  
  /*
  //Returns the t-th entry of i-th coordinate point
  public float get_coords(int i, int t)
  { return coords[i][t]; }*/
  

  
}
