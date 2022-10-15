class Node{
  int X;
  int Y;
  
  Parent p;
  
  int HCost; //how far from goal
  int GCost; //how far from start
  
  int FCost;
  
  Node(int X, int Y, int HCost, int GCost, Parent p){
    this.X = X;
    this.Y = Y;
    this.HCost = HCost;
    this.GCost = GCost;
    this.p = p;
    
    this.FCost = this.HCost + this.GCost;
  }
  
}
