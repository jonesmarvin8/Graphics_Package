rectangularPRISM test;
float[] t;

Boolean disO = true,
        dis1 = false,
        dis2 = false;

Boolean update;
Boolean want_vc = false;
int code;
int d;
Boolean vc_decrypt = false;
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
  test = new rectangularPRISM(150,5);
}

void draw()
{
  background(100);
  rectMode(CENTER);
  
    if(update == true)
  { check_for_updates(); }

  
  if(disO == true)
  {
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
}

void keyPressed()
{  
  update = true;
  code = keyCode;
  
  if(code == 76) //Lines up shares to decrypt (hit "L")
  {
    if(vc_decrypt == false)
    {
      vc_decrypt = true;
    }
    else if(vc_decrypt == true)
    { save("Decrypt.png"); }
  }
  else if(code == 80) //Print screen (hit "P")
  {
//    test_cube.select_painting();
  }
  else if(code == 49) //1
  {  
    if(dis1 == false)
    { 
      dis1 = true;
      dis2 = false;
      disO = false;
    }
    else if( dis1 == true)
    { save("Share_1.png"); }
  }
  else if(code == 50) //Display Share 2 (hit "2")
  {
      
    if(dis2 == false)
    {
      dis1 = false;
      dis2 = true;
      disO = false;
    }
    else if( dis2 == true)
    { save("Share_2.png"); }
  }
  else if(code == 51) //display original
  {
    if(disO == false)
    {
      dis1 = false;
      dis2 = false;
      disO = true;
    }
    else if(disO == true)
    { save("Original.png"); }
  }
  else if(code == 52) //make black
  {
     //test_cube.fuck(); 
  }
//}
  else if(code == 82)
  { x_rot += PI/2; }
  else if(code == 84)
  { x_rot -= PI/2; }
  else if(code == 70)
  { y_rot += PI/2;}
  else if(code == 71)
  { y_rot -= PI/2;}
  else if(code == 66) //b
  { z_rot += PI/2;}
  else if(code == 86) //v
  { z_rot -= PI/2;}
 
}


void keyReleased()
{ update = false; }

void check_for_updates() //key codes to move object
{
 if(code == 65)
  {  x_tran -=5;}
  else if(code == 68)
  {  x_tran +=5;}
  else if(code == 87)
  { y_tran -= 5;}
  else if(code == 83)
  { y_tran += 5;}
  else if(code == 81)
  { z_tran -= 5;}
  else if(code == 69)
  { z_tran += 5;}
}
