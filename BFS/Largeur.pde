/*
  Hadjerci Allaeddine
  Parcour en Largeur
  les Obstacles et la position de robot et
  l'objective sont generer automatiquement
*/


int windowSize = 400;
int backgroundColor = 0;
int boxSize = 20;
int grid = windowSize / boxSize;
int robotLocation[] = {0, 0};
int objectiveLocation;

//0 for objective ,1 for obstacle , 3 for robot ,2 space
int map[][] = new int[grid][grid];

ArrayList<Integer> Paths = new ArrayList<Integer>();

void generateRandomMap(){
  //Create Spaces
  for(int i = 0; i < grid; i++){
    for(int j = 0; j < grid; j++){
      map[i][j] = 2;
    }
  }
  
  //Create the Boundries
  for(int j = 0 ; j < grid ; j++){
    map[0][j] = 1;
    map[j][0] = 1;
    map[grid-1][j] = 1;
    map[j][grid-1] = 1;
  }
  
  //Create Obstacles
  for(int i=0 ; i < 30; i++){
    int howManyObstacle = int(random(1, 4));
    int whereToGenerateX = int(random(2, grid-4));
    int whereToGenerateY = int(random(2, grid-4));
    
    int transformationX = 0;
    int transformationY = 0;
    for(int j = 0 ; j < howManyObstacle ; j++){
      map[whereToGenerateX + transformationX][whereToGenerateY + transformationY] = 1;
      transformationX = int(random(-1, 2));
      transformationY = int(random(-1, 2));
    }
    
  }
    
  //Create Robot
  int robotX;
  int robotY;
  do{
    robotX = int(random(1, 15));
    robotY = int(random(2, 4));
  }while(map[robotX][robotY] != 2 || (map[robotX][robotY+1] == 1 &&
                                      map[robotX+1][robotY+1] == 1 &&
                                      map[robotX+1][robotY] == 1 &&
                                      map[robotX-1][robotY] == 1 &&
                                      map[robotX][robotY-1] == 1 &&
                                      map[robotX-1][robotY-1] == 1));
                                      
   map[robotX][robotY] = 3;
   robotLocation[0] = robotX;
   robotLocation[1] = robotY;
   
   //Create Objective
   int objective;
   do{
     objective = int(random(10, grid - 5));
   }while(map[objective][objective] != 2 || (map[objective][objective+1] == 1 &&
                                             map[objective+1][objective+1] == 1 &&
                                             map[objective+1][objective] == 1 &&
                                             map[objective-1][objective] == 1 &&
                                             map[objective][objective-1] == 1 &&
                                             map[objective-1][objective-1] == 1) );
   
   map[objective][objective] = 0;
   objectiveLocation = objective;
   
}

BFS bf;
int visitedCells[][];
void setup(){
  size(400, 400);
  smooth();
  generateRandomMap();
  bf = new BFS(robotLocation[0], robotLocation[1], objectiveLocation, map, grid);
}

void toAnimate(int k, int z){
  
  for(int f = 0 ; f < k ; f++){
    for(int g = 0 ; g < z ; g++){
      int obj = map[f][g];
      if(obj == 0){ fill(0, 255, 0); }
      if(obj == 1){ fill(0, 0, 255); }
      if(obj == 2){ fill(0, 0, 0); }
      if(obj == 3){ fill(255, 0, 0); }
      noStroke();
      rect(windowSize - (windowSize - f*boxSize), windowSize - (windowSize - g*boxSize), boxSize, boxSize);
    }
  }
  
}

int i = 0;
int j = 0;

void draw(){
  background(backgroundColor);
  
  /*
  if(i <= grid){ if(j <= grid){ toAnimate(i,j); j++; }else{ j=0; i++; }  }
  else{ toAnimate(grid,grid); }
  */
  
  toAnimate(grid,grid);
  bf.Iterate();
  
  /*
  boolean pathexist = false;
  if(!pathexist){
    BFS bf = new BFS(robotLocation[0], robotLocation[1], objectiveLocation, map, grid);
    bf.pathExists();
  }
  */
  
}
