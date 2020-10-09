class Grid {
  int numCols;
  int numRows;
  ArrayList<Ball>[][] grid;

  Grid() {
    numCols = int(sqrt(balls.size()) + 0.5);
    numRows = numCols;
    
    // array with empty borders to simplify the logic;
    grid = new ArrayList[numCols+2][numRows+2];

    // initialize each grid as an empty list
    for (int i = 0; i < numCols+2; i = i+1)
    {
      for (int j = 0; j < numRows+2; j = j+1)
      {
        grid[i][j] = new ArrayList();
      }
    }
  }

  // Show the grid
  void draw()
  {
    stroke(0);
    for (int i = 1; i < numCols; i = i+1)
    {
      int x = i*width/numCols;
      line(x, 0, x, height);
    }
    for (int j = 1; j < numRows; j = j+1)
    {
      int y = j*height/numRows;
      line(0, y, width, y);
    }
  }

  void checkCollisions()
  {
    // empty grid
    for (int i = 1; i <= numCols; i = i+1)
    {
      for (int j = 1; j <= numRows; j = j+1)
      {
        grid[i][j].clear();
      }
    }
    
    // add balls to grid
    for (Ball ball : balls)
    {
      int x = getStrip(ball.x / width, numCols);
      int y = getStrip(ball.y / height, numRows);
      grid[x][y].add(ball);
    }

    // look for collisions with neighbours
    for (int i = 1; i <= numCols; i = i+1)
    {
      for (int j = 1; j <= numRows; j = j+1)
      {
        for (Ball ball : grid[i][j])
        {
          checkLocalCollisions(ball, grid[i-1][j-1]);
          checkLocalCollisions(ball, grid[i-1][j]);
          checkLocalCollisions(ball, grid[i-1][j+1]);
          checkLocalCollisions(ball, grid[i][j-1]);
          checkLocalCollisions(ball, grid[i][j]);
          checkLocalCollisions(ball, grid[i][j+1]);
        }
      }
    }
  }

  void checkLocalCollisions(Ball ball, ArrayList<Ball> neighbours)
  {
    for (Ball ball2 : neighbours)
    {
      if ((ball2.x < ball.x || ball2.x == ball.x && ball2.y < ball.y) && ball.hasCollidedWith(ball2))
      {
        ball.bounce(ball2);
      }
    }
  }

  // The cell (1..count) corresponding to a fractional window position
  int getStrip(float frac, int count)
  {
    int i;
    i = int(frac * count) + 1;
    // ensure it is in range
    if (i < 1)
    {
      i = 1;
    } else if (i > count)
    {
      i = count;
    }
    return i;
  }
}
