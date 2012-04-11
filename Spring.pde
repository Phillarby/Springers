class Spring
{
  float tension;
  float xPos, yPos, radius;
  PVector move = new PVector(0,0,0);
  float growthRate = random(50)/10;
  
  Spring(float x, float y, float rad, float ten)
  {
    xPos = x;
    yPos = y;
    radius = rad;
    tension = ten;
    update();
  }
  
  void update()
  {
    smooth(); 
    fill(100, 0, 0, 50);
    stroke(150,150,150);
    ellipse(xPos, yPos, radius/2, radius/2);;
    
    if (radius > 100)
      growthRate = -growthRate;
    radius = radius + growthRate;
    
    if (radius < 1)
    {
      growthRate = -growthRate;
      xPos = random(width);
      yPos = random(height);
    }
  }
  
  PVector isGrabbed(float x, float y)
  {
    if(dist(x, y, xPos, yPos) < radius)
    {
      //set vector of attractor from agent
      move.set(xPos - x , yPos - y, 0);
      move.mult(tension * (move.mag())/radius);
      //Draw line to indicate strength of force applied 
      stroke(255, 0, 0, 255 * tension * (move.mag())/radius);
      line(x,y,xPos,yPos);
      //println("Grabbed " + move.x + " " + move.y);
    }
    else
    {
      move.set(0,0,0);
    }
    return move;
  }
  
  float getX()
  {
    return xPos;
  }
  
  float getY()
  {
    return yPos;
  }
}


