// rectangularCYLINDER(int n_t, float rad_t, float height_t)
rectangularPRISM test1;
//rectangularCYLINDER test;
frustrumCONE test;

float[] t;
Boolean update;

int code;
int timer = 1;

float x_tran = 150;
float y_tran = 150;
float z_tran = 0;

float x_rot = 0;
float y_rot = 0;
float z_rot = 0;

void setup()
{
  size(500,500, P3D);
  update = false;
  test = new frustrumCONE(50, 150, 50,200,1);
}

void draw()
{
  background(100);
  rectMode(CENTER);
  
  if(update == true)
  { check_for_updates(); }
  
  if(timer%20 == 0)
  { 
    test.update_colors(); 
    timer = 1;
  }
  else{ timer++; }

  pushMatrix();
  translate(x_tran, y_tran, z_tran);
  pushMatrix();
  rotateX(x_rot);
  rotateY(y_rot);
  rotateZ(z_rot);
  fill(255);
  test.display();
  popMatrix();
  popMatrix();
}

void keyPressed()
{  
  update = true;
  code = keyCode;if(code == 82)
  { x_rot += PI/5; }
  else if(code == 84)
  { x_rot -= PI/5; }
  else if(code == 70)
  { y_rot += PI/5;}
  else if(code == 71)
  { y_rot -= PI/5;}
  else if(code == 66) //b
  { z_rot += PI/5;}
  else if(code == 86) //v
  { z_rot -= PI/5;}
}


void keyReleased()
{ update = false; }

void check_for_updates() //key codes to move object
{
 if(code == 65) //A
  {  x_tran +=5;}
  else if(code == 68)//D
  {  x_tran -=5;}
  else if(code == 87)//W
  { y_tran += 5;}
  else if(code == 83)//S
  { y_tran -= 5;}
  else if(code == 81) //Q
  { z_tran += 5;}
  else if(code == 69) //E
  { z_tran -= 5;}
}
