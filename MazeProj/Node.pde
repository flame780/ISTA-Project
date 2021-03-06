/*
*  Acts as the traversal object in the maze
*/

class Node
{
  int i;
  int j;
  boolean visited;
  boolean[] walls;
  boolean isPlayerLocation; // is the player here?
  boolean isEndLocation; // end location
  float c1;
  float c2;
  float c3;
  
  /*
  *  Node Constructor
  */
  Node(int i, int j, float c1, float c2, float c3)
  {
    this.i = i;
    this.j = j;
    visited = false;
    isPlayerLocation = false;
    walls = new boolean[]{true,true,true,true};
    this.c1 = c1;
    this.c2 = c2;
    this.c3 = c3;
  }
  
  /*
  *  Gets the visted value.
  */
  boolean getVisited()
  {
    return visited;
  }
  
  //unused
  boolean getIsPlayerLocation()
  {
    return isPlayerLocation;
  }
  
  //unused
  boolean getIsEndLocation()
  {
    return isEndLocation;
  }
  
  boolean getWallAt(int wall)
  {
   return walls[wall]; 
  }
  
  
  /*
  *  Returns a random neighbor node next to this node.
  */
  Node randNeighbor(Node[][] grid)
  {
    ArrayList<Node> neighbors = new ArrayList<Node>(); // Collection of neighbors
    
    // Make sure the index is valid and the valid index has not been visited
    if(validIndex(i,j-1,grid) && !grid[i][j-1].getVisited()) // Top
      neighbors.add(grid[i][j-1]);
    if(validIndex(i+1,j,grid) && !grid[i+1][j].getVisited()) // Right
      neighbors.add(grid[i+1][j]);
    if(validIndex(i,j+1,grid) && !grid[i][j+1].getVisited()) // Bottom
      neighbors.add(grid[i][j+1]);
    if(validIndex(i-1,j,grid) && !grid[i-1][j].getVisited()) // Left
      neighbors.add(grid[i-1][j]);
    
    
    if(neighbors.size() > 0)
    {
      int randLoc = (int)random(neighbors.size()); // Choose a random neighbor
      return neighbors.get(randLoc);
    }
    else // No valid neighbors
      return null;
  }
  
  /*
  *  Removes the walls between two nodes
  */
  void removeWalls(Node cur, Node next)
  {
    int x = cur.i - next.i; // Left & right
    if(x == 1) // Left
    {
       cur.walls[3] = false; 
       next.walls[1] = false;
    }
    if(x == -1) // Right
    {
       cur.walls[1] = false; 
       next.walls[3] = false;
    }
    
    int y = cur.j - next.j; // Up and down
    if(y == 1) // Down
    {
       cur.walls[0] = false; 
       next.walls[2] = false;
    }
    if(y == -1) // Up
    {
       cur.walls[2] = false; 
       next.walls[0] = false;
    }
  }
  
  /*
  *  Changes the value of visited
  */
  void setVisited(boolean visited)
  {
     this.visited = visited; 
  }
  
  /*
  *  Sets the location of the player
  */
  void setPlayerLocation(boolean playerLoc)
  {
    this.isPlayerLocation = playerLoc; 
  }
  
  void setEndLocation(boolean endLoc)
  {
    this.isEndLocation = endLoc;
  }
  
  /*
  *  Draws the node and its walls to the screen
  */
  void show(int w) {
    
    strokeWeight(6);
    int x = i * w;
    int y = j * w;
    
    if (frame % rate == 0 || last) {
      strobe = true;
      stroke(0); ////
    }
    else {
      strobe = false;
      stroke(255); ////
    }
     
    if(walls[0]) // top
      line(x, y, x + w, y);
    if(walls[1])
      line(x + w, y, x + w, y + w); // right
    if(walls[2])
      line(x + w, y + w, x, y + w); // bottom
    if(walls[3])
      line(x, y + w, x, y); // left
    
    if(visited) {
      noStroke();
      noFill();
      
      noStroke();
      for (int i = 0; i < 5; i++) {
        fill(random(255));
        rect(random(x, x + w), random(y, y + w), 4, 4);
      }
    }
    if(isPlayerLocation)
    {
      noStroke();
      fill(c1, c2, c3);
      rect(x + 4, y + 4, w - 4, w - 4);
      
      visited = true;
      
    }
    if(isEndLocation)
    {
      noStroke();
      
      fill(c1, c2, c3);
      
      rect(x + 4, y + 4, w - 4, w - 4);
    }
  }
  
  /*
  *  Checks if the index is valid
  */
  boolean validIndex(int i, int j, Node[][] grid)
  {
    return i > -1 && i < grid.length && j > -1 && j < grid[0].length;
  }
}