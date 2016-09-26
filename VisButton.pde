public class VisButton{
    float x,y,width,height;
    boolean on;
    Hexagon_List HL;
    boolean isVisible=false;
    
    VisButton ( float xx, float yy, float ww, float hh, Hexagon_List HL ) {
        x = xx; 
        y = yy; 
        width = ww; 
        height = hh;
        Interactive.add( this ); // add this to GUIDO manager, important!
        this.HL=HL;
    }

    void mousePressed (){
        // called when the button has been pressed
        on = !on;
        if(on==true)
          makeDisappear();  
        else
          makeAppear();
    }
    
    void makeDisappear(){
      //go through HL and make isVisible = !isVisible for every button. 
      for(int i=0; i<HL.size; i++){
        if(HL.getHexagon(i)!=null){
          HL.getHexagon(i).button.isVisible=false;
        }
      }
    }
    void makeAppear(){
      //go through HL and make isVisible = !isVisible for every button. 
      for(int i=0; i<HL.size; i++){
        if(HL.getHexagon(i)!=null){
          HL.getHexagon(i).button.isVisible=true;
        }
      }
    }

    void draw (){
        // called by GUIDO after PApplet.draw() has finished
        fill( on ? 80 : 140 );
        rect( x, y, width, height );
    }
  
}