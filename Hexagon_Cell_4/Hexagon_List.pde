public class Hexagon_List{
  int size=200;
  Hexagon hexagons[]=new Hexagon[size];
  int open_spot=0;
  int numrows;
  int numcols;
  
  public Hexagon_List(){
    
  }
  
  Hexagon getHexagon(int i){
    return hexagons[i];
  }
  Hexagon getHexagon(int row, int column){
    int index=-1;
    for(int i=0; i<open_spot; i++){
      if((this.getHexagon(i).row==row)&&(this.getHexagon(i).column==column)){
        index=i;
         break;
      }
    }
    if(index==-1){
      println("problem with the getHexagon() for row: ", row, " and column: " , column);
    }
    return HL.getHexagon(index);
  }
  
  void addHexagon(Hexagon hexagon){
    hexagon.index=open_spot;
    //hexagon.button.index=open_spot;
    hexagon.HL=this;
    hexagons[open_spot]=hexagon;
    open_spot++;
  }
  
  void drawAll(){
    for(int i=0; i<size; i++){
      if(hexagons[i]!=null)
        hexagons[i].drawHexagon();
    }
  }
  
  int numHexagons(){
    int sum=0;
    for(int i=0; i<this.size; i++){
      if(this.getHexagon(i)!=null){
        sum++;
      }
    }
    
    return sum;
  }
  boolean checkCol(int column){
    //return if there are still splitable cells in the column. 
    boolean colComplete=true;
    for(int i=0; i<open_spot; i++){
      if((HL.getHexagon(i).getNumVerts()==6)&&(HL.getHexagon(i).column==column)){
        colComplete=false;
      }
    }
    return colComplete;
  }
  
  
}