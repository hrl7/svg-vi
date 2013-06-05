import 'dart:html';
import 'dart:svg' as svg;
import 'textCursor.dart';
class svgText {
	int lines=0,
		x=10,y=0,width=0,height=0,
		cLine=0,cChar=0,
		fontSize=25;

	String LE="_";//the character that put end of the each lines
	String fontFamily = "Verdana",id="";
	
	svg.TextElement area;

	textCursor cursor;

/*******************************methods***************************/
	svgText([String _id="test"]){
		id = _id;
		area = new svg.TextElement();
		for(int i=0;i<=20;++i)addLine("$i :Hello World!!");
		insertLine(2,"test");
		cLine =0;
		cChar =0;
	}	
	void init(){
		updateCursor();
	}
	void addLine([String _text=""]){

		svg.TSpanElement s = new svg.TSpanElement();
	
		s.$dom_setAttribute("x","${x}px");
    	s.$dom_setAttribute("y","${(lines+1)*fontSize}px");
    	s.$dom_setAttribute("id",'${id}_line${lines}');
    	s.$dom_setAttribute("font-family",fontFamily);
    	s.$dom_setAttribute("font-size","${fontSize}");
    	s.text = _text;
    	area.children.add(s);
    	++lines;
    	cLine = lines -1;
    	addLineEnd(lines-1);
    	cursor = new textCursor();
    	updateLines();
    	updateCursor();
	}
	void insertLine([int l,String _text=""]){

		svg.TSpanElement s = new svg.TSpanElement();
	
		s.$dom_setAttribute("x","${x}px");
    	s.$dom_setAttribute("y","${(lines+1)*fontSize}px");
    	s.$dom_setAttribute("id",'${id}_line${lines}');
    	s.$dom_setAttribute("font-family",fontFamily);
    	s.$dom_setAttribute("font-size","${fontSize}");
    	s.text = _text;
    	if(l>=lines)l=lines;
    	area.children.insert(l,s);
    	++lines;
    	cChar = 0;
    	addLineEnd(l);

    	updateLines();
    	updateCursor();
	}


	void deleteLines(int l){
		if(l>0&&l<area.children.length){
			area.children[l].remove();
			--lines;
			if(cLine>=lines)k();
			updateLines();
		}else print("error :cannot delete line,line $l is not exist");
	}
	void h([int back=1]){
		changeChar(cChar-back);
	}
	void j([int down=1]){
		changeLine(cLine+down);
	}	
	void k([int up=1]){
		changeLine(cLine-up);
	}	
	void l([int forward=1]){
		changeChar(cChar+forward);
	}


	void updateCursor(){
    

	   	var tp = area.children[cLine].getStartPositionOfChar(cChar);
	 	var ep = area.children[cLine].getEndPositionOfChar(cChar);
		int a,b,c;
   		a = tp.x.round();
    	b = tp.y.round()-fontSize;
    	c = ep.x.round()-a;
 		cursor.setCursor(a,b,c,fontSize);
   

  }


	void insertChars(String t){
		String fs, s = area.children[cLine].text;
		fs = s.substring(0,cChar);
		fs += t;
		fs += s.substring(cChar);
		area.children[cLine].text = fs;
		if(cChar!=s.length)++cChar;
		updateCursor();
	}

	void deleteChars([int d=1]){
		if(area.children[cLine].text.length==1){
			deleteLines(cLine);
		}else {
			if(d == area.children[cLine].text.length-1)changeChar(cChar-1);
				String fs, s = area.children[cLine].text;
				fs = s.substring(0,cChar);
				fs += s.substring(cChar+d);
				area.children[cLine].text = fs;
			
		}
		updateCursor();

	}

	void updateLines(){
    	for(int i=0;i<lines;++i){
    	 	area.children[i].$dom_setAttribute("x","${x}px");
   		  	area.children[i].$dom_setAttribute("y","${(i+1)*fontSize}px");
    	   	area.children[i].$dom_setAttribute("id",'${id}_line${i}');
   		}
	}
  
	void addLineEnd(int l){
		if(!area.children[l].text.endsWith("_")){
			area.children[l].text+="_";
		}
	}



	void changeChar(int x){
		if(x>=0&&x<area.children[cLine].text.length-1){
			cChar = x;
		}else if(x<0){
			changeLine(cLine-1);
		}else if(x==area.children[cLine].text.length-1){
			if(cLine!=lines-1)cChar = 0;
			changeLine(cLine+1);
		}else print("error: cannot acces the $x th char");
		print("$x chars moved");
		updateCursor();
	}
	void changeLine(int y){
		if(y>=0&&y<area.children.length){
			cLine = y;
			if(area.children[cLine].text.length==1){
				cChar=0;
			} else if(cChar>area.children[cLine].text.length-2){
				cChar = area.children[cLine].text.length-2;
			}
		}
		print("$cLine lines moved");
		updateCursor();
	}



}