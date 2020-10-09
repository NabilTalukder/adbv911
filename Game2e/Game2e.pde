ArrayList<Projectile> bullets = new ArrayList<Projectile>();
Grid buckets;
ArrayList<Ball> balls = new ArrayList<Ball>();
Player player1;
long lastTime = 0;
long lastShot = 0;
int score = 0;

void setup()
{
  size(600, 600);
  
  noCursor();
  
  for (int i=0; i<random(5, 10); i++)
  {
    balls.add(new Ball());
  }
  buckets = new Grid();
  
  player1 = new Player();
  
  lastTime = millis();
}


void draw()
{
  background(0, 0, 0);
  
  if (player1.alive == true)
  {
    player1.draw();
  }
  else
  {
    cursor();
  }
  
  // First draw the balls in their current position.
  for (Ball ball : balls)
  {
    ball.draw();
  }
 
  // Check to see if any balls have collided
  for (int i=0; i<balls.size(); i++)
  {
    Ball b = balls.get(i);
    
    //remove ball when touching bottom of screen
    if (b.y >= height - b.diameter/2)
    {
      balls.remove(b);
    }
    
    // Compare each ball with any untested others
    for (int j=i+1; j<balls.size(); j++)
    {
      Ball b2 = balls.get(j);
      
      if (b.hasCollidedWith(b2))
      {
        b.bounce(b2);
      }
      
      if (b.hitPlayer(player1))
      {
        player1.alive = false;
      }
    }
  }
 
  //move all the balls by one step.
  for (Ball ball : balls)
  {
    ball.move();
  }
  
  if (millis() - lastTime > 1000)
  {
    for (int i=0; i<random(5, 7); i++)
    {
      balls.add(new Ball());
      
    }
    lastTime = millis();
  }
  
  for (int i = 0; i < bullets.size(); i++)
  {
    Projectile proj = bullets.get(i);
    proj.draw();
    fill(255, 255, 0);
    circle(proj.x, proj.y, 30);
    if (proj.y <= 0)
    {
      bullets.remove(proj);
    }
    
    //proj-ball collision
    for (int j=0; j<balls.size(); j++)
    {
      Ball b = balls.get(j);
      if (proj.touchingBall(b))
      {
        balls.remove(b);
        bullets.remove(proj);
        score += b.diameter;
      }
    }
  }
  
  if (mousePressed == true && millis() - lastShot > 400)
  {
    if (player1.alive == true)
    {
      bullets.add(new Projectile(player1.x, player1.y, player1.w, true));
    }
    lastShot = millis();
  }

  
  textSize(32);
  textAlign(CENTER);
  fill(255);
  text(score, 50, 50);
  
  if (player1.alive == false)
  {
    fill(255, 0, 0);
    text("YOU DIED", width/2, height/2);
  }
  
}
