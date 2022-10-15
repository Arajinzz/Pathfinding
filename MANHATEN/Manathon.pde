class Manathon{
  
  int [][]map;
  
  int SX;
  int SY; //Start Cordinates
  
  int Goal; // Goal Coordinate
  
  ArrayList<Node> open = new ArrayList<Node>(); //Unvisited Nodes
  ArrayList<Node> closed = new ArrayList<Node>(); //Visited Nodes
  
  boolean isPathFound = false;
  
  Manathon(int [][]map, int SX, int SY, int Goal){
    
    this.map = new int[20][20];
    for(int i = 0 ; i < 20 ; i++){
      for(int j = 0 ; j < 20 ; j++){
        this.map[i][j] = map[i][j];
      }
    }
    
    this.SX = SX;
    this.SY = SY;
    
    this.Goal = Goal;
    
    open.add(new Node(SX, SY, 0, 0, null));
    
  }
  
  int Distance(int Point1_X, int Point1_Y, int Point2_X, int Point2_Y){
    
    int Distance = 0;
    
    Distance = abs(Point1_X - Point2_X);
    Distance += abs(Point1_Y - Point2_Y);
    
    return Distance;
    
  }
  
  // search lowest Fcost in open
  int SearchLowest(){
    
    int indexOfLowest = 0;
    Node min = open.get(0);
    
    for(int i = 0 ; i < open.size() ; i++){
      Node temp = open.get(i);
      if(min.FCost == temp.FCost){
        if(min.HCost >= temp.HCost){
          min = temp;
          indexOfLowest = i;
        }
      }else{
        if(min.FCost > temp.FCost){
          min = temp;
          indexOfLowest = i;
        }
      }
    }
    
    return indexOfLowest;
    
  }
  
  Node isExist(int X, int Y, ArrayList<Node> toSear){
    
    for(Node node : toSear){
      if(node.X == X && node.Y == Y){
        return node;
      }
    }
    
    return null;
    
  }
  
  void Iterate(){
    
    if(!open.isEmpty() && !isPathFound){
      
      Node current = open.remove(SearchLowest());
      closed.add(current);
      
      if(current.X == Goal && current.Y == Goal){
        isPathFound = true;
      }
      
      map[current.X][current.Y] = 4; //Visited

      ArrayList<Node> successors = getSuccessors(map, current);
      
      for(Node node : successors){
        
        map[node.X][node.Y] = 6;
        
        if(isExist(node.X, node.Y, closed) == null){
          
          if(isExist(node.X, node.Y, closed) == null){
            open.add(node);
          }else{
            Node temp = isExist(node.X, node.Y, closed);
            
            if(node.FCost < temp.FCost){
              temp.FCost = node.FCost;
              temp.p = node.p;
            }
            
          }
          
        }
        
      }
      
    }
    
    drawing();
    
  }
  
  ArrayList<Node> getSuccessors(int[][] map, Node node){
    ArrayList<Node> successors = new ArrayList<Node>();
    
    if(isValidIndex(map, node.X - 1, node.Y)) { successors.add(new Node(node.X-1, node.Y, Distance(node.X-1, node.Y, Goal, Goal), Distance(node.X-1, node.Y, SX, SY), new Parent(node.X, node.Y))); }
    if(isValidIndex(map, node.X , node.Y - 1)) { successors.add(new Node(node.X, node.Y-1, Distance(node.X, node.Y-1, Goal, Goal), Distance(node.X-1, node.Y, SX, SY), new Parent(node.X, node.Y))); }
    if(isValidIndex(map, node.X + 1, node.Y)) { successors.add(new Node(node.X+1, node.Y, Distance(node.X+1, node.Y, Goal, Goal), Distance(node.X-1, node.Y, SX, SY), new Parent(node.X, node.Y))); }
    if(isValidIndex(map, node.X, node.Y + 1)) { successors.add(new Node(node.X, node.Y+1, Distance(node.X, node.Y+1, Goal, Goal), Distance(node.X-1, node.Y, SX, SY), new Parent(node.X, node.Y))); }
    
    return successors;
  }
  
  boolean isValidIndex(int [][]map, int x, int y){
    return (x > 0 && x < 20-1 && y >0 && y < 20-1 && map[x][y] != 4 && map[x][y] != 1);
  }
  
  
  void drawing(){
    for(int i = 0; i < grid; i++){
      for(int j = 0; j < grid; j++){
        if(i == SX && j == SY) { continue; }
        if(i == Goal && j == Goal) { continue; }
        if(map[i][j] == 4){
          fill(255, 255, 0); 
          noStroke();
          rect(400 - (400 - i*20), 400 - (400 - j*20), 20, 20);
        }
        
        if(map[i][j] == 6){
          fill(255, 0, 255); 
          noStroke();
          rect(400 - (400 - i*20), 400 - (400 - j*20), 20, 20);
        }
      } 
    }
  }
  
}
