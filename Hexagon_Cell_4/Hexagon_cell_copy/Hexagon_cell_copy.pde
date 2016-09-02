Vertex_List VL = new Vertex_List();
Hexagon_List HL=new Hexagon_List();
Hexagon_List HL2=new Hexagon_List();
Hexagon_List HL3=new Hexagon_List();
Hexagon cell22;
Hexagon cell_2= new Hexagon();
Vertex v1= new Vertex(200, 200);
Vertex v2= new Vertex(200, 200);
int i=0;

void setup(){
  size(600, 600, P3D);
  background(200);
  createHexagonGroup(3, 3, 200, 200, 40, HL2, VL);
  //cell22 = createHexagon(width/2, height/2, 50, VL);
  //HL2.addHexagon(cell22);
  createHexagonGroup(8, 8, 75, 75, 30, HL, VL); //(numrows, numcols, x_start, y_start, radius, HL, VL)
  frameRate(50);
}

void draw(){
  background(200);
  i++;
  HL.drawAll();
  if(i==50){
    //println(cell22.getArea());
    //HL2.getHexagon(4).splitCell();
    //println(cell22.getArea());
  }
      
  
  
  //HL.drawAll();
  if(i%25==0){
      runSimulation(HL);
  }
}

 /*void createHexagonGroup2(int numrows, int numcols, float x_start, float y_start, float side_length, Hexagon_List HL, Vertex_List VL){
   Hexagon[][] structure=new Hexagon[numrows][numcols];
   for(int i=0; i<
 }*/

void runSimulation(Hexagon_List HL){
  int num_hex=HL.numHexagons();
  int random_value=(int)random(0,num_hex);
  boolean done=false;
  int iterations=0;
  while(done==false){
    random_value=(int)random(0,num_hex);
    if(HL.getHexagon(random_value).isInhibited==false){
      if(HL.getHexagon(random_value).getNumVerts()==6)
        done=true;
      else
        println("tried hexagon ", random_value, " but it had ", HL.getHexagon(random_value).getNumVerts(), " vertices.");
    }
    iterations++;
    if(iterations>num_hex){
      println("Breaking from the simluation, because split every hexagon.");
      return;
      //break;
    }
  }
  println(random_value, " has ",  HL.getHexagon(random_value).getNumVerts(), " vertices and isInhibited is ", HL.getHexagon(random_value).isInhibited);
  HL.getHexagon(random_value).splitCell();
}

void runSimulation2(Hexagon_List HL){
  int num_hex=HL.numHexagons();
  int random_value=(int)random(0,num_hex);
  boolean done=false;
  int iterations=0;
  while(done==false){
    random_value=(int)random(0,num_hex);
    if(HL.getHexagon(random_value).isInhibited==false){
      if(HL.getHexagon(random_value).getNumVerts()==6)
        done=true;
      else
        println("tried hexagon ", random_value, " but it had ", HL.getHexagon(random_value).getNumVerts(), " vertices.");
    }
    iterations++;
    if(iterations>num_hex){
      println("Breaking from the simluation, because split every hexagon.");
      return;
      //break;
    }
  }
  println(random_value, " has ",  HL.getHexagon(random_value).getNumVerts(), " vertices and isInhibited is ", HL.getHexagon(random_value).isInhibited);
  HL.getHexagon(random_value).symSplitCell();
}

void runSimulation3(Hexagon_List HL){ //for demonstrating one cell dividing

  
  
}