public class rectangularPRISM
{
    public static final int NUM_FACES = 6;
    
    rectangularFACE[] prism_array;
    int node_width,
        face_width;
    
    public rectangularPRISM(int w_t, int num_nodes)
    {
      prism_array = new rectangularFACE[NUM_FACES];
      node_width = w_t;
      face_width = num_nodes;
      
      for(int i = 0; i < NUM_FACES; i++)
      { prism_array[i] = new rectangularFACE(node_width, num_nodes); }
    }

  public void display()
  { 
    prism_array[0].display();
    pushMatrix();
    translate(0,0,-node_width*(face_width));
    prism_array[1].display();
    popMatrix();
    pushMatrix();
    rotateY(PI/2);
    prism_array[2].display();
    pushMatrix();
    translate(0,0,node_width*(face_width));
    prism_array[3].display();
    popMatrix();
    rotateX(PI/2);
    prism_array[4].display();
    pushMatrix();
    translate(0,0, -node_width*(face_width));
    prism_array[5].display();
    popMatrix();
    popMatrix();
  }

}
