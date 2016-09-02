public class Hexagon{
   Integer[] vertices = new Integer[6];
   int open_vert;
   Hexagon[] neighbors = new Hexagon[6];
   int open_neighbor=0;
   Hexagon_List HL;
   Vertex_List VL;
   int index; //index in the hexagon_list
   boolean isInhibited;
   color c;
   int row;
   int column;
   MyButton button;
   float button_x;
   float button_y;
   //give each cell a row and column
   //if spawned from a differnt cell, give it that cells row and column
   
   public Hexagon(){
     //need constructor?
     isInhibited=false;
     open_vert=0;
     c=color(255);
     //println(this.getVertex(0).x);
     //button= new MyButton(this.getVertex(0).x, this.getVertex(0).y, 10, 10);
     //button.index=this.index;
   }
   
   void drawHexagon(){
     //Vertex current_vert=new Vertex(0, 0);//only intialized to avoid error. 
     fill(c);
     beginShape();
     for(int i=0; i<vertices.length; i++){
       if(vertices[i]!=null)
           vertex(VL.getVertex(vertices[i]).x, VL.getVertex(vertices[i]).y);
     }
     endShape(CLOSE);
   }
   
   Vertex getVertex(int i){
     if(this.vertices[i]==null){
       //println("requested a null vertex in getVertex. Vertex: ", i);
       return null;
     }
     else
       return VL.getVertex(vertices[i]);
   }
   
   void addVertex(Vertex vertex){
     //problem with putting in vertices who are already represented by another hexagon
     if(vertex.index==-1){
       VL.addVertex(vertex);
     }
       vertices[open_vert]= vertex.index;
       if(open_vert==0){
         button_x=vertex.x;
         button_y=vertex.y;
         createButton(button_x, button_y);
       }
       open_vert++;
   }
   
   void createButton(float x, float y){
     button=new MyButton(x, y, 20, 20, this.index, this);
     //button.index=this.index;
     //button.HL=this.HL;
   }
   
   void splitCell(){
     //only splits 6-sided polygons(hexagons), which is a problem(fix in future), maybe include instance variable of 
     //the number of sides of the cell and go from there
     float expand=.725; //1.25
     float contract=.725;  //1.1
     int rand_vert= (int)random(0, 3);
     int rand_vert_2=rand_vert+3;
     Hexagon new_cell= new Hexagon();
     new_cell.VL=this.VL;
     if(rand_vert==0){
      this.moveVertices(rand_vert, rand_vert_2, contract);
      this.moveVertices(1, 4, expand);
      this.moveVertices(2, 5, expand);
    
       new_cell.addVertex(this.getVertex(rand_vert));
       new_cell.addVertex(this.getVertex(1));
       new_cell.addVertex(this.getVertex(2));
       new_cell.addVertex(this.getVertex(rand_vert_2));
       //remove these verts from the original cell.
       this.vertices[1]=null;
       this.vertices[2]=null;
     }
     else if(rand_vert==1){
      this.moveVertices(rand_vert, rand_vert_2, contract);
      this.moveVertices(2, 5, expand);
      this.moveVertices(0, 3, expand);
       
       new_cell.addVertex(this.getVertex(rand_vert));
       new_cell.addVertex(this.getVertex(2));
       new_cell.addVertex(this.getVertex(3));
       new_cell.addVertex(this.getVertex(rand_vert_2));
       //remove these verts from the original cell. 
       this.vertices[2]=null;
       this.vertices[3]=null;
     }
     else if(rand_vert==2){
      this.moveVertices(rand_vert, rand_vert_2, contract);
      this.moveVertices(0, 3, expand);
      this.moveVertices(1, 4, expand);
       
       //add verts 3 and 4 to new cell
       new_cell.addVertex(this.getVertex(rand_vert));
       new_cell.addVertex(this.getVertex(3));
       new_cell.addVertex(this.getVertex(4));
       new_cell.addVertex(this.getVertex(rand_vert_2));
       //remove these verts from the original cell. 
       this.vertices[3]=null;
       this.vertices[4]=null;
     }
     //println("made it this far");
     //now i need to move the vertices upon splitting of the cells.
     //BRING THE TWO RANDOM VERTICES CLOSER TOGETHER AND THE OTHER VERTICES FARTHER APART
     //and then email peters after lunch 
     HL.addHexagon(new_cell);
     //println("split cell successfully");
   }//^^^^^^plain split cell^^^^^^^^^
   
   void symSplitCell(){  //both cells are inhibited upon splitting
     //only splits 6-sided polygons(hexagons), which is a problem(fix in future), maybe include instance variable of 
     //the number of sides of the cell and go from there
     this.inhibitNeighbors();
     float expand=.725;
     float contract=.725;   //.1012... the sez of the original
     int rand_vert= (int)random(0, 3);
     int rand_vert_2=rand_vert+3;
     Hexagon new_cell= new Hexagon();
     new_cell.VL=this.VL;
     if(rand_vert==0){
      this.moveVertices(rand_vert, rand_vert_2, contract);
      this.moveVertices(1, 4, expand);
      this.moveVertices(2, 5, expand);
    
       new_cell.addVertex(this.getVertex(rand_vert));
       new_cell.addVertex(this.getVertex(1));
       new_cell.addVertex(this.getVertex(2));
       new_cell.addVertex(this.getVertex(rand_vert_2));
       //remove these verts from the original cell.
       this.vertices[1]=null;
       this.vertices[2]=null;
     }
     else if(rand_vert==1){
      this.moveVertices(rand_vert, rand_vert_2, contract);
      this.moveVertices(2, 5, expand);
      this.moveVertices(0, 3, expand);
       
       new_cell.addVertex(this.getVertex(rand_vert));
       new_cell.addVertex(this.getVertex(2));
       new_cell.addVertex(this.getVertex(3));
       new_cell.addVertex(this.getVertex(rand_vert_2));
       //remove these verts from the original cell. 
       this.vertices[2]=null;
       this.vertices[3]=null;
     }
     else if(rand_vert==2){
      this.moveVertices(rand_vert, rand_vert_2, contract);
      this.moveVertices(0, 3, expand);
      this.moveVertices(1, 4, expand);
       
       //add verts 3 and 4 to new cell
       new_cell.addVertex(this.getVertex(rand_vert));
       new_cell.addVertex(this.getVertex(3));
       new_cell.addVertex(this.getVertex(4));
       new_cell.addVertex(this.getVertex(rand_vert_2));
       //remove these verts from the original cell. 
       this.vertices[3]=null;
       this.vertices[4]=null;
     }
     this.inhibitCell();
     new_cell.inhibitCell();
     HL.addHexagon(new_cell);
     println("split cell successfully");
   }
   //^^^^^symmetricSplitCell
   
   void AsymSplitCell(){  //one cell is inhibited upon splitting
     //only splits 6-sided polygons(hexagons), which is a problem(fix in future), maybe include instance variable of 
     //the number of sides of the cell and go from there
     //this.inhibitNeighbors();
     int rand_vert= (int)random(0, 3);
     int rand_vert_2= rand_vert+3;
     int which_inhibit=(int)random(0, 2);
     Hexagon new_cell= new Hexagon();
     new_cell.VL=this.VL;
     if(rand_vert==0){
       this.moveVertices0(0, which_inhibit);
    
       new_cell.addVertex(this.getVertex(rand_vert));
       new_cell.addVertex(this.getVertex(1));
       new_cell.addVertex(this.getVertex(2));
       new_cell.addVertex(this.getVertex(rand_vert_2));
       //remove these verts from the original cell.
       this.vertices[1]=null;
       this.vertices[2]=null;
     }
     else if(rand_vert==1){
      this.moveVertices0(1, which_inhibit);
       
       new_cell.addVertex(this.getVertex(rand_vert));
       new_cell.addVertex(this.getVertex(2));
       new_cell.addVertex(this.getVertex(3));
       new_cell.addVertex(this.getVertex(rand_vert_2));
       //remove these verts from the original cell. 
       this.vertices[2]=null;
       this.vertices[3]=null;
     }
     else if(rand_vert==2){
      this.moveVertices0(2, which_inhibit);
       
       //add verts 3 and 4 to new cell
       new_cell.addVertex(this.getVertex(rand_vert));
       new_cell.addVertex(this.getVertex(3));
       new_cell.addVertex(this.getVertex(4));
       new_cell.addVertex(this.getVertex(rand_vert_2));
       //remove these verts from the original cell. 
       this.vertices[3]=null;
       this.vertices[4]=null;
     }
     //int which_inhibit=(int)random(0, 2);
     if(which_inhibit==1){ //new_cell is brain cell 
       new_cell.inhibitCell();
       new_cell.c=color(0, 180, 0);
       this.inhibitCell();  //for now. 
       this.c=color(75, 75, 255);
     }
     else{   //original cell is brain cell
        this.inhibitCell();
        this.c=color(0, 180, 0);
        new_cell.inhibitCell();
        new_cell.c=color(75, 75, 255);
    }
     HL.addHexagon(new_cell);
     println("Asym split cell successfully");
   }
   //^^^^^AsymmetricSplitCell
   
   

    
    float getArea(){
      //input with the cell is vertices which gives indices of the vertices in the vertex list
      //at this point, can't get the area of a quadrilateral
      float area=0;
      int i=0;
      boolean done=false;
      boolean found=false;
      Vertex first=new Vertex(0, 0);
      Vertex current;
      Vertex next;
      while(found==false){
        if(this.vertices[i]!=null){
          first=this.getVertex(i);
          found=true;
        }
        i++;
      }
      current=first;
      while(done==false){
        if(i==this.vertices.length){
          next=first;
          //do calculation
          area+=(current.x)*(next.y)-(current.y)*(next.x);
          break;
        }
        else if(this.vertices[i]!=null){
          next=this.getVertex(i);
          area+=(current.x)*(next.y)-(current.y)*(next.x);
          current=next;
        }
        i++;     
      }
      if(area<0)//get absolute value of the area
        area=area*(-1);
         
      return area/2;
    }
    
    void adjustNeighbors(){
      for(int i=0; i<neighbors.length; i++){
        this.neighbors[i]=null;
        open_neighbor=0;
      }
      for(int i=0; i<this.HL.size; i++){                         //for every hexagon in hexagon list
        float adj_verts=0;
        if((i!=this.index) && (HL.getHexagon(i)!=null)){                                       //if the hexaogn is not the same as this one
          for(int j=0; j<this.open_vert; j++){                   //for every vertex in this hexagon
            if(this.getVertex(j)!=null){                         //if the vertex is not null
              for(int k=0; k<HL.getHexagon(i).open_vert; k++){   //compare it against the vertices in the other hexagon
                 if(HL.getHexagon(i).getVertex(k)!=null){
                   //if(i==25){println("k ", k);}
                   if(this.getVertex(j)==HL.getHexagon(i).getVertex(k)){  //if they are the same, add to adj_verts
                     //if(i==25){println("made it here");}
                     adj_verts++;
                   }
                 }
              }
            } 
          }   
        }
        if(adj_verts>=2){//check the number of connecting vertices for each cell
           this.addNeighbor(HL.getHexagon(i));
           //println("new neighbor added: ", i);
        }
        //println(i);
    }
  }  
  
  void addNeighbor(Hexagon hexagon){
    this.neighbors[open_neighbor]=hexagon;
    open_neighbor++;
  }
  
  void printNeighbors(){
    for(int i=0; i<6; i++){
      if(this.neighbors[i]!=null){
        println(this.neighbors[i].index);
      }
    }
  } 
  
  void printVertices(){
    for(int i=0; i<open_vert;i++){
      if(this.vertices[i]!=null){
        println(this.getVertex(i).x, "  ", this.getVertex(i).y);
      }
    }
  }
  
  int getNumVerts(){
    int num_verts=0;
    for(int i=0; i<this.open_vert;i++){
      if(this.getVertex(i)!=null)
        num_verts++;
    }
    return num_verts;
  }
  
  void inhibitCell(){
    this.isInhibited=true;
    this.c=color(255, 0, 0);
  }
  
  void inhibitNeighbors(){
    this.adjustNeighbors();
    for(int i=0; i<open_neighbor; i++){
      if(this.neighbors[i]!=null){
        this.neighbors[i].inhibitCell();
      }
    }
  }
  
   void moveVertices(int v1, int v2, float k){
      Vertex vert_a=new Vertex(0, 0);  //creating the vertices
      Vertex vert_b= new Vertex(0, 0);
      vert_a.x = k*this.getVertex(v1).x+(1-k)*this.getVertex(v2).x;    //changing their values
      vert_a.y = k*this.getVertex(v1).y+(1-k)*this.getVertex(v2).y;
      vert_b.x = k*this.getVertex(v2).x+(1-k)*this.getVertex(v1).x;
      vert_b.y = k*this.getVertex(v2).y+(1-k)*this.getVertex(v1).y;    
      VL.getVertex(vertices[v1]).x=vert_a.x;
      VL.getVertex(vertices[v1]).y=vert_a.y;
      VL.getVertex(vertices[v2]).x=vert_b.x;
      VL.getVertex(vertices[v2]).y=vert_b.y;
      //println(vert_a.x, "  ", vert_a.y);
      //println(vert_b.x, "  ", vert_b.y);
    }
   void moveVerticesAway(int v1, int v2, float k){
    //where v1 is the mutable vertex and v2 is the reference
    Vertex vert_a=new Vertex(0, 0);
    vert_a.x = k*this.getVertex(v1).x+(1-k)*this.getVertex(v2).x;    //changing their values
    vert_a.y = k*this.getVertex(v1).y+(1-k)*this.getVertex(v2).y;
    VL.getVertex(vertices[v1]).x=vert_a.x;
    VL.getVertex(vertices[v1]).y=vert_a.y;
  }
  void moveVerticesAway(int v1, Vertex v2, float k){
    //where v1 is the mutable vertex and v2 is the reference
    Vertex vert_a=new Vertex(0, 0);
    vert_a.x = k*this.getVertex(v1).x+(1-k)*v2.x;    //changing their values
    vert_a.y = k*this.getVertex(v1).y+(1-k)*v2.y;
    VL.getVertex(vertices[v1]).x=vert_a.x;
    VL.getVertex(vertices[v1]).y=vert_a.y;
  }

  void moveVertices0(int rand_vert, int rand_side){
    //use v0, v1, ... to delineate which vertex is which and assign different verts to each location.
    int v0, v1, v2, v3, v4, v5;
    if(rand_vert==0){
       v0=0;
       v1=1; 
       v2=2;
       v3=3;
       v4=4;
       v5=5;
    }
    else if(rand_vert==1){
       v0=1;
       v1=2; 
       v2=3;
       v3=4;
       v4=5;
       v5=0;
    }
    else{
       v0=2;
       v1=3; 
       v2=4;
       v3=5;
       v4=0;
       v5=1;
    }
    
    //int rand_side=(int)random(0, 2);
    //rand_side=1;
    if(rand_side==0){
      //then small hex vertices are 0, 1, 2, 3
      //and big hex vertices are 0, 3, 4, 5 
      
      //move 0 and 3 only slightly closer together. 
      this.moveVertices(v0, v3, .9);
      //save verts 1 and 2. 
      Vertex va=this.getVertex(v1);
      Vertex vb=this.getVertex(v2);
      //move 1 and 2 closer to 4 and 5 respectively. 
      this.moveVerticesAway(v1, v4, .75);
      this.moveVerticesAway(v2, v5, .75);
      // move 4 and 5 farther from 1 and 2 respectively.
      this.moveVerticesAway(v4, va, 1.2);
      this.moveVerticesAway(v5, vb, 1.2);
    }
    else if(rand_side==1){
      //then big hex vertices are 0, 1, 2, 3
      //and small hex vertices are 0, 3, 4, 5 
      
      //move 0 and 3 only slightly closer together. 
      this.moveVertices(v0, v3, .8);
      //save verts 4 and 5. 
      Vertex va=this.getVertex(v4);
      Vertex vb=this.getVertex(v5);
      //move 4 and 5 closer to 1 and 2 respectively. 
      this.moveVerticesAway(v4, v1, .75);
      this.moveVerticesAway(v5, v2, .75);
      // move 1 and 2 farther from 4 and 5 respectively.
      this.moveVerticesAway(v1, va, 1.25);
      this.moveVerticesAway(v2, vb, 1.25);
    }
    else{
      println("rand_side was not 0 or 1");
    } 
  }
  
  
} /////////////END OF HEXAGON CLASS/////////////






void createHexagonGroup(int numrows, int numcols, float x_start, float y_start, float side_length, Hexagon_List HL, Vertex_List VL){
  //create a group of cells that will be used later on to try things. 
  HL.numrows=numrows;
  HL.numcols=numcols;
  int apothem=(int)(pow((float)3/4, (float)1/2)*side_length);
  Hexagon cell=new Hexagon();
  for(int col=0; col<numcols; col++){
    for(int row=0; row<numrows; row++){
      if(col%2==0){ //column is even
        cell=createHexagon(x_start+col*side_length*1.5, y_start+row*2*apothem, side_length, VL);
      }
      else if(col%2==1){  //column is odd
        cell=createHexagon(x_start+col*side_length*1.5, y_start+apothem+row*2*apothem, side_length, VL);
      }
      else{print("Something wrong in createHexagonGroup");}
      cell.row=row;
      cell.column=col;
      HL.addHexagon(cell);
    }
  } 
}

Hexagon createHexagon(float x, float y, float side_length, Vertex_List VL){
  //given a center at (x, y), create a hexagon with this side_length
  float scale=pow((float)3/4, (float)1/2);
  float radius=side_length;
  int apothem=(int)(scale*side_length);
  Hexagon cell=new Hexagon();
  cell.VL=VL;
  cell.addVertex(new Vertex(x-side_length/2, y-apothem));
  cell.addVertex(new Vertex(x+side_length/2, y-apothem));
  cell.addVertex(new Vertex(x+radius, y));
  cell.addVertex(new Vertex(x+side_length/2, y+apothem));
  cell.addVertex(new Vertex(x-side_length/2, y+apothem));
  cell.addVertex(new Vertex(x-radius, y));
  return cell;
}

float getDistance(Vertex v1, Vertex v2){
  return getDistance(v1.x, v1.y, v2.x, v2.y);
}

float getDistance(float x1, float y1, float x2, float y2){
  float xs=x2-x1;
  float ys=y2-y1;
  xs=pow(xs, 2);
  ys=pow(ys, 2);
  
  return pow(xs+ys, (float)1/2);
}