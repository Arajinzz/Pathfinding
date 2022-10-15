
class BFS{
  
  int size;
  int [][] map;
  int SX;
  int SY;
  int Obj;
  int Cout = 0;
  ArrayList<Node> queue = new ArrayList<Node>();
  ArrayList<Node> queueToFindPath = new ArrayList<Node>();
  boolean pathFound = false;
  
  Node child;
  Node Parent;
  
  BFS(int SX, int SY, int Obj, int [][] m,int size){
    map = new int[size][size];
    for(int i =0 ; i < size ; i++){
      for(int j = 0 ; j < size ; j++){
        map[i][j] = m[i][j];
      }
    }
    this.size = size;
    this.SX = SX;
    this.SY = SY;
    this.Obj = Obj;
    queue.add(new Node(this.SX, this.SY,null));
    print(Obj);
    
  }
  
  void drawing(){
    for(int i = 0; i < grid; i++){
      for(int j = 0; j < grid; j++){
        if(i == SX && j == SY) { continue; }
        if(i == Obj && j == Obj) { continue; }
        if(map[i][j] == 4){
          fill(255, 255, 0); 
          noStroke();
          rect(400 - (400 - i*20), 400 - (400 - j*20), 20, 20);
        }
        
        if(map[i][j] == 6){
          fill(255, 0, 0); 
          noStroke();
          rect(400 - (400 - i*20), 400 - (400 - j*20), 20, 20);
        }
      } 
    }
  }
  
  void Iterate(){
    if(!queue.isEmpty() && !pathFound){
      Node current = queue.remove(0);
       
       if(current.X == Obj && current.Y == Obj){
         pathFound = true;
         queueToFindPath.add(current);
       }
       
       //Visited
       int temp = map[current.X][current.Y];
       if(!pathFound && temp != 4){
         map[current.X][current.Y] = 4;
         Cout++;
         
         ArrayList<Node> successors = getSuccessors(map, current);
         queue.addAll(successors);
         queueToFindPath.add(current);
         
       }
       
    }
    
    if(pathFound){
      
         if(child == null){
           child = queueToFindPath.remove(queueToFindPath.size()-1);
         }
         
         if(child.X != SX || child.Y != SY){
           for(int i = 0 ; i < queueToFindPath.size(); i++){
             Node temp = queueToFindPath.get(i);
             if(child != null && child.Parent.X == temp.X && child.Parent.Y == temp.Y){
               child = queueToFindPath.remove(i);
               map[child.X][child.Y] = 6;
               break;
             }
           }
         }
         
         
    }
    
    drawing();
  }
  
  boolean pathExists(){
     
     while(!queue.isEmpty()){
       Node current = queue.remove(0);
       
       if(current.X == Obj && current.Y == Obj){
         pathFound = true;
         break;
       }
       
       //Visited
       int temp = map[current.X][current.Y];
       map[current.X][current.Y] = 4;
       if(temp != 3){
         fill(255, 255, 0); 
         noStroke();
         rect(400 - (400 - current.X*boxSize), 400 - (400 - current.Y*boxSize), boxSize, boxSize);
         delay(10);
       }
       Cout++;
       
       ArrayList<Node> successors = getSuccessors(map, current);
       queue.addAll(successors);
       
       
     }
     
     return pathFound;
  }
  
  ArrayList<Node> getSuccessors(int[][] map, Node node){
    ArrayList<Node> successors = new ArrayList<Node>();
    
    if(isValidIndex(map, node.X - 1, node.Y)) { successors.add(new Node(node.X-1, node.Y, new Node(node.X, node.Y, null))); }
    if(isValidIndex(map, node.X , node.Y - 1)) { successors.add(new Node(node.X, node.Y-1, new Node(node.X, node.Y, null))); }
    if(isValidIndex(map, node.X + 1, node.Y)) { successors.add(new Node(node.X+1, node.Y, new Node(node.X, node.Y, null))); }
    if(isValidIndex(map, node.X, node.Y + 1)) { successors.add(new Node(node.X, node.Y+1, new Node(node.X, node.Y, null))); }
    
    return successors;
  }
  
  boolean isValidIndex(int [][]map, int x, int y){
    return (x > 0 && x < size-1 && y >0 && y < size-1 && map[x][y] != 4 && map[x][y] != 1);
  }
  
}
