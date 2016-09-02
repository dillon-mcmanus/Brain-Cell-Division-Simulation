class Vertex_List{
  Vertex[] vertices=new Vertex[1000];
  int open_spot;
  
  public Vertex_List(){
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
  
  Vertex getVertex(Vertex vertex){
    if(VL.getVertex(vertices[i])==null){
       print("Error on getVertex for value of ", i);
       return null;
    }
    return getVertex(vertex.index);
  }
  
  Vertex getVertex(int index){
    return vertices[index];
  }
}