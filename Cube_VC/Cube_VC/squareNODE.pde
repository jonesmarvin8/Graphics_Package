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
  
  coordinatePOINT[] node_points;
  int node_color;
  
  squareNODE()
  {
    node_color = 255; //Default color to white.
    
    node_points = new coordinatePOINT[NODE_SIZE];
    for(int i = 0; i < NODE_SIZE; i++)
    { node_points[i] = new coordinatePOINT(); }
  }

  public void set_color(int c_t)
  { 
    if( c_t == 255 || c_t == 0)
    { node_color = c_t; }
    else{ c_t = COLOR_DEFAULT; } 
  } 
  
  public void invert_color()
  { node_color = 255-node_color; }

  public int get_color()
  { return node_color; }
  
  public void set_node(float[][] vals)
  {
    if(vals.length == NODE_SIZE)
    {
      for(int i = 0; i < NODE_SIZE; i++)
      {  node_points[i].set_point(vals[i]); }
    } else{
      System.out.println("ERROR: set_node(): val is wrong length ("+ vals.length +"."); }
  }
  
  public void set_coords_i(int i, float[] val)
  { node_points[i].set_point(val); }

  public float[] get_point_i(int i)
  { return node_points[i].get_point(); }
}
