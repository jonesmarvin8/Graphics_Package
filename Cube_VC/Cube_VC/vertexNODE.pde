/*
Authors: Marvin Jones, Linds Wise
File: squareNODE
Description: This class constructs the insistance of a square node
 for a 3d visual cryptography scheme.
 
Attributes:
node_coords[][] - 4 coordinate points for each vertex of the square.
node_color - color; CURRENTLY an int for just black and white.
*/

public class vertexNODE
{
  public final static int DIMENSION_SIZE = 3;
  public final static int COLOR_DEFAULT = 255;
  public final static int DEFAULT_VERTEX_SIZE = 3;
  
  coordinatePOINT[] node_points;
  color node_color;
  int node_size;
  
  vertexNODE(int ns_t)
  {
    node_color = COLOR_DEFAULT; //Default color to white.
    node_size = ns_t;
    
    node_points = new coordinatePOINT[node_size];
    for(int i = 0; i < node_size; i++)
    { node_points[i] = new coordinatePOINT(); }
  }
  
  vertexNODE()
  {
    node_color = color(COLOR_DEFAULT,COLOR_DEFAULT,COLOR_DEFAULT,COLOR_DEFAULT); //Default color to white.
    node_size = DEFAULT_VERTEX_SIZE;
    
    node_points = new coordinatePOINT[node_size];
    for(int i = 0; i < node_size; i++)
    { node_points[i] = new coordinatePOINT(); }
  }
  

  public void set_color(color c_t)
  { 
    node_color = c_t; 
  } 
  
  public void invert_color()
  { node_color = color(255-red(node_color), 255-green(node_color), 255-blue(node_color), 255); }

  public int get_color()
  { return node_color; }
  
  public void set_node(float[][] vals)
  {
    if(vals.length == node_size)
    {
      for(int i = 0; i < node_size; i++)
      {  node_points[i].set_point(vals[i]); }
    } else{
      System.out.println("ERROR: set_node(): val is wrong length ("+ vals.length +"."); }
  }
  
  public void set_coords_i(int i, float[] val)
  { node_points[i].set_point(val); }

  public float[] get_point_i(int i)
  { return node_points[i].get_point();}
}
