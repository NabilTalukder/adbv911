class Player
{
  float x, y;                   //position
  float w, h;                   //dimensions
  color colour;                 //colour
  boolean alive;                //life state
 
  // Constructor - this is called whenever a new player is created.
  Player()
  {
    // Initialise the state of the player
    w = 35;
    h = 40;
    colour = color(255, 0, 0);
    alive = true;
  }
 
  void draw()
  {
    noStroke();
    fill(colour);
    x = mouseX - w;
    y = mouseY + h/2;
    rect(x, y, w, h);
  }
}
