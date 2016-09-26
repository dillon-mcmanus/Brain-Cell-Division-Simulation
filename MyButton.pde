public class MyButton{
    float x,y,width,height;
    boolean on;
    int index=-1; // index in HL. 
    Hexagon hexagon;
    Hexagon_List HL;
    boolean isVisible=true;
    
    MyButton ( float xx, float yy, float ww, float hh, int index, Hexagon hexagon ) {
        x = xx; 
        y = yy; 
        width = ww; 
        height = hh;
        Interactive.add( this ); // add this to GUIDO manager, important!
        this.index=index;
        this.hexagon=hexagon;
    }

    void mousePressed (){
        // called when the button has been pressed
        if(hexagon.isInhibited==false){
          on = !on;
          preview_mode= true;
          selected_cell= this.hexagon.index;
          /*
          indices=this.hexagon.vertices;
          for(int i=0; i<6; i++){
            indices[i]=this.hexagon.vertices[i];
          }
          for(int i=0; i<6; i++){
            vertices[i]=hexagon.VL.getVertex(i);
          }*/
          for(int i=0; i<6; i++){
            indices[i]=this.hexagon.vertices[i];
            vertices[i]=new Vertex(VL1.getVertex(indices[i]).x, VL1.getVertex(indices[i]).y);
          }
          selected_cell= hexagon.index;
          println(selected_cell);
          //splitHexagon(index);   
        }
    }
    
    void splitHexagon(int index){
      //println(HL.size);
      if(this.hexagon.isInhibited==false){
        this.hexagon.AsymSplitCell();
      }
      //HL.getHexagon(index).c=color(0);
    }

    void draw (){
        // called by GUIDO after PApplet.draw() has finished
        fill( on ? 80 : 140 );
        //rectMode(CENTER);
        if((isVisible)&&(hexagon.isInhibited==false))
          rect( x, y, width, height );
    }
}