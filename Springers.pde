Spring[] springs;
PVector[] attractors;
Roamer agnt;
float fr = 20; //desired framerate

void setup()
{
  size(512,512,P2D);
  frameRate(fr);
  createRandomSprings(50);
  createAttractorArray();
}

void createRandomSprings(int cnt)
{
  springs = new Spring[cnt];
  for(int i = 0; i < cnt; i++)
  {
    springs[i] = new Spring(random(width),
                            random(height),
                            max(random(100), 1),
                            random(100)/10);
  }
}

void createAttractorArray()
{
  //only allow up to 10 attractors
  attractors = new PVector[10];
  for(int i = 0; i < 10; i++)
  {
    attractors[i] = new PVector(0,0);
  }
}

void draw()
{
  background(255);
  int cnt = 0;
  float vecX = 0, vecY = 0;
  PVector move;
  
  //Refresh Springs
  for(int i = 0; i < springs.length; i++)
  {
    springs[i].update();
  }
  
  //If there is a roamer on the screen then calcualte it's movement
    if (agnt!= null)
    {
      //Iterate through all the springs
      for(int i = 0; i < springs.length; i++)
      {
        //If the roamer is within range of a spring then track it's effect
        move = springs[i].isGrabbed(agnt.getX(), agnt.getY());
        if(move.x != 0.0 && move.y != 0.0 )
        {
          if(cnt < 10)
          {
            //println("Storing vector :" + move.x + " " + move.y);
            attractors[cnt].set(move.x, move.y, 0); 
            cnt++;
          }
          move.set(0.0,0.0,0.0);
          //println("Stored vector :" + attractors[cnt-1].x + " " + attractors[cnt-1].y);
        }
      }    
    
    //println("added " + cnt + " attractors");
  
    //set any unused attractors (up to max of 10) to have no effect
    for(int j = cnt; j < 10; j++)
    {
      //println("Attractor " + (j + 1) + " cleared");
      attractors[j].set(0,0,0);
    }  
    
    //Iterate through attractor array adding any vectors to the roamer
    for(int j = 0; j < min(cnt, 9); j++)
    {  
      //add vectors
      //println("Adding vector :" + attractors[j].x + " " + attractors[j].y);
      agnt.AddVector(attractors[j]);
      
    }
    
    agnt.update();
  
    //Kill roamer if it exceeds boundary of screen
    if (agnt.getX() < 0 || agnt.getX() > width - 1 ||agnt.getY() < 0 || agnt.getY() > height - 1)
      agnt = null;
    }
}

void mouseClicked()
{
  agnt = new Roamer(mouseX, mouseY);
}
