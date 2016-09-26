import de.bezier.guido.*; //<>//

//INPUT VALUES HERE TO DETERMINE CELL SIZE
float kpinch=.9;   //originally .9
float kcontract=.75;   //originally .75
float kexpand=1.2;   //originally 1.2

Vertex[] vertices = new Vertex[6];
Integer[] indices = new Integer[6];

Vertex_List VL1 = new Vertex_List();
Vertex_List VL2 = new Vertex_List();
Vertex_List VL_backup= new Vertex_List();
Hexagon_List HL=new Hexagon_List();
Hexagon_List HL2=new Hexagon_List();
Hexagon_List HL_backup=new Hexagon_List();

//Hexagon cell22;
Hexagon cell_2= new Hexagon();
Vertex v1= new Vertex(200, 200);
Vertex v2= new Vertex(200, 200);
int i=0;
int row=0;
int column=0;
Hexagon cell22;
boolean setup=false;
boolean preview_mode=false;
int selected_cell=-1;
color background=color(200);


void setup(){
  Interactive.make(this);
  size(600, 600, P3D);
  background=color(50);
  VisButton vb = new VisButton(550, 550, 40, 40, HL);
  //createHexagonGroup(3, 3, 200, 200, 40, HL2, VL1);
  //cell22 = createHexagon(width/2, height/2, 50, VL1);    
  //HL2.addHexagon(cell22);
  createHexagonGroup(8, 8, 75, 75, 30, HL, VL1); //(numrows, numcols, x_start, y_start, radius, HL, VL1)
  frameRate(50);
}

void draw(){ 
  background(background);
  i++; //<>//
  HL.drawAll(); //<>//
}

void keyPressed(){
  if(preview_mode==true){
    int vert=-1;
    int way=-1;
    if (key== '1') {
      for(int i=0; i<6; i++){ //<>//
        indices[i]=HL.getHexagon(selected_cell).vertices[i];
        vertices[i]=new Vertex(VL1.getVertex(indices[i]).x, VL1.getVertex(indices[i]).y);
      }
      
      vert=0;
      way=0;
      if(HL.getHexagon(selected_cell).c==color(255))
        HL.getHexagon(selected_cell).preview(0, 0);
      preview_mode=false;
    }
    if (key== '2') {
      vert=1;
      way=0;
      if(HL.getHexagon(selected_cell).c==color(255))
        HL.getHexagon(selected_cell).preview(1, 0);
      preview_mode=false;
    }
    if (key== '3') {
      vert=2;
      way=0;
      if(HL.getHexagon(selected_cell).c==color(255))
        HL.getHexagon(selected_cell).preview(2, 0);
      preview_mode=false;
    }
    if (key== '4') {
      vert=0;
      way=1;
      if(HL.getHexagon(selected_cell).c==color(255))
        HL.getHexagon(selected_cell).preview(0, 1);
      preview_mode=false;
    }
    if (key== '5') {
      vert=1;
      way=1;
      if(HL.getHexagon(selected_cell).c==color(255))
        HL.getHexagon(selected_cell).preview(1, 1);
      preview_mode=false;
    }
    if (key== '6') {
      vert=2;
      way=1;
      if(HL.getHexagon(selected_cell).c==color(255))
        HL.getHexagon(selected_cell).preview(2, 1);
      preview_mode=false;
    }
   if (key== 'p') {
    
     //HL.getHexagon(selected_cell).printVertices();
    }
    if(key==ENTER){
      preview_mode=false;
      //HL.getHexagon(selected_cell).preview(vert, way);
    }
    
  }
   if (key== '0') {
     if(selected_cell!=-1){
       convertBack(vertices, indices, HL, VL1, selected_cell);
     }
   }
}



void convertBack(Vertex[] vertices, Integer[] indices, Hexagon_List HL, Vertex_List VL, Integer selected_cell){

     for(int i=0; i<6; i++){
        VL1.getVertex(indices[i]).x=vertices[i].x;
        VL1.getVertex(indices[i]).y=vertices[i].y;
      }
       
      HL.removeHexagon(HL.most_recent.index);
      
      for(int i=0; i<6; i++){
        HL.getHexagon(selected_cell).vertices[i]=indices[i];
      }
      
      HL.getHexagon(selected_cell).isInhibited=false;
      HL.getHexagon(selected_cell).c=color(255);
      HL.getHexagon(selected_cell).button.on=false;
  

}