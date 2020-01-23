class Visualizer
{
  int tX, tY;
  int bX, bY;
  float time;
  PVector velocity;
  PVector location;
  Visualizer(int x, int y)
  {
   this.tX =x;
   this.tY =y;
   this.bX =tX;
   this.bY =tY-500;
   
   
    location = new PVector(bX,bY);
   
   
  }
  
  void display()
  {
    fill(#012C40);
    triangle(tX,tY,tX+700,tY,tX,tY-500);
    fill(#FF404C);
    rect(location.x, location.y-50, 50,50);
    
         
  }
  void calculateVelocity(float time)
  {
    this.time = time;
    
    float frames = time*60;
    velocity = new PVector(700/frames, 500/frames);
  }
  
  
  void update()
  {
    if(location.x < tX+700)
    {
      location.add(velocity);
    }
  }
  
  void reset()
  {
    location.x = tX;
    location.y = tY-500;
  }
}
