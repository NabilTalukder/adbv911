class Projectile
{
  float x, y;                   // position
  float w;                      // player width
  boolean f;                    // fire state
  Projectile (float xPos, float yPos,
  float wPlayer, boolean fired)
  {
    x = xPos + wPlayer / 2;
    y = yPos;
    w = wPlayer;
    f = fired;                  // allows projectile to travel upon fire
  }
  float diameter;               // diameter
  color colour;                 // colour
 
  // Constructor - this is called whenever a new projectile is created.
  Projectile()
  {
    // Initialise the state of the projectile
    diameter = 15;
    y -= diameter / 2;
    colour = color(255, 255, 0);
    
  }
 
  void draw()
  {
    noStroke();
    fill(colour);
    y -= 7;
    circle(x, y, diameter);
  }
  
  boolean touchingBall(Ball ball)
  {
    if (dist(x + (diameter/2), y + (diameter/2),
    ball.x + (diameter/2), ball.y + (diameter/2)) <= (diameter+ball.diameter)/2)
    {
      return true;
    }
    return false;
  }
}
