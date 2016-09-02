import de.bezier.guido.*; //<>//


Vertex_List VL = new Vertex_List();
Hexagon_List HL=new Hexagon_List();
Hexagon_List HL2=new Hexagon_List();
Hexagon_List HL3=new Hexagon_List();
//Hexagon cell22;
Hexagon cell_2= new Hexagon();
Vertex v1= new Vertex(200, 200);
Vertex v2= new Vertex(200, 200);
int i=0;
int row=0;
int column=0;
Hexagon cell22;
boolean setup=false;


void setup(){
  Interactive.make(this);
  size(600, 600, P3D);
  background(200);
  VisButton vb = new VisButton(550, 550, 40, 40, HL);
  //createHexagonGroup(3, 3, 200, 200, 40, HL2, VL);
  //cell22 = createHexagon(width/2, height/2, 50, VL);               
  //HL2.addHexagon(cell22);
  createHexagonGroup(8, 8, 75, 75, 30, HL, VL); //(numrows, numcols, x_start, y_start, radius, HL, VL)
  frameRate(50);
  //println("What fraction of the original cell size would you like the spawned cell to be: ");
}

void draw(){  //<>//
  
  background(200);
  i++;
  HL.drawAll(); //<>//

  if((i%50==0)&&(column<HL.numcols)){
     //println(HL.getHexagon(1, column).getNumVerts()!=6);
     //column=runSimulation3(HL, column);
  }
}


void runSimulation(Hexagon_List HL){
  /*
      For standard splitting, nothing fancy. 
  */
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
  /*
      When cellular inhibition is present. 
  */
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

int runSimulation3(Hexagon_List HL, int column){ 
  /*  
    for using rows and columns with simple dividing. 
  */
  boolean colComplete=false;
  int random_row;
  boolean isFound=false;
  while(isFound==false){
    random_row=(int)random(0,HL.numrows);
    if((HL.getHexagon(random_row, column).getNumVerts()==6)&&(HL.getHexagon(random_row, column).isInhibited==false)){
      HL.getHexagon(random_row, column).AsymSplitCell();
      isFound=true;
    }
    else{
      random_row=(int)random(0,HL.numrows);
      //scan through the HL and determine if there is a cell with 
      colComplete=HL.checkCol(column);
      if(colComplete==true){
        column++;
        if(column==HL.numcols){
          println("went through entire grid");
          break;
        }
      }
    }
  }
  return column; //return the current column that we are on. 
}