class Vertex_List{
  int size=1000;
  Vertex[] vertices=new Vertex[size];
  int open_spot;
  
  public Vertex_List(){
    open_spot=0;
  }
  
  void clearList(){
    for(int i=0; i<this.size; i++){
      vertices[i]=null;
    }
    open_spot=0;
  }
  
  void addVertex(Vertex vertex){
    //check if the vertex is already in the vertex_list
    for(int i=0;i<open_spot; i++){ //iterate through the vertex list
      if((vertices[i].x==vertex.x) & (vertices[i].y==vertex.y)){
        vertex.index=vertices[i].index;
      }   
    }
    if(vertex.index==-1){
      vertices[open_spot]=vertex;
      vertex.index=open_spot;
      open_spot++;
    }
  }
  
  void changeVertex(Integer index, Vertex new_vert){
    if(vertices[i]!=null)
      vertices[i]=new_vert;
    else 
      println("error in changeVertex");
  }
  
  Vertex getVertex(Vertex vertex){
    if(this.getVertex(vertices[i])==null){
       print("Error on getVertex for value of ", i);
       return null;
    }
    return getVertex(vertex.index);
  }
  
  Vertex getVertex(int index){
    return vertices[index];
  }
}