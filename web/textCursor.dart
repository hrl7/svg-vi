import 'dart:html';
import 'dart:svg' as svg;
class textCursor{
  int x,y,dx,dy=20;
  svg.RectElement rec;
  textCursor(){
    rec= new svg.RectElement();
    rec.$dom_setAttribute("fill","black");
    rec.$dom_setAttribute("fill-opacity","0.1");
    rec.$dom_setAttribute("stroke","black");
    rec.$dom_setAttribute("x","${4}px");
    rec.$dom_setAttribute("y","${4}px");
    rec.$dom_setAttribute("width","${20}px");
    rec.$dom_setAttribute("height","${20}px");
  }
 void setCursor(int _x,int _y,int _dx,int _dy){
   x = _x;
   y = _y;
   dx = _dx;
   dy = _dy;
   update();
 }
 
 void update(){
   rec.$dom_setAttribute("x","${x}px");
   rec.$dom_setAttribute("y","${y}px");
   rec.$dom_setAttribute("width","${dx}px");
   rec.$dom_setAttribute("height","${dy}px");
 }

}
