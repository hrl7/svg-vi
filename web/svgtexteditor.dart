import 'dart:html';
import 'svgText.dart';

var modeList = ["Normal Mode","Insert Mode","CommandLine Mode","Visual Mode","Search Mode"];
int mode = 0;

var mainView = query("#output");
var input = query("#input");
var testText;
void main() {
	testText = new svgText();
	mainView.children.add(testText.area);
	mainView.children.add(testText.cursor.rec);
	testText.init();
	input.onKeyPress.listen(keyDown);
	query("#display").text = modeList[0];


	input.focus();
	window.onMouseMove.listen(mouseMove);
}

void mouseMove(MouseEvent e){
	input.focus();
}
void keyDown(KeyboardEvent e){
	print(e.charCode);
	   String t = new String.fromCharCode(e.$dom_keyCode);

		switch(e.$dom_charCode){

			case 27: // change to CommandLine Mode (mode=2) 
		    	modeChange(0);
	      		break;
	      	default:
				switch(mode){
					case 0:
		 				cmdEval(e.$dom_charCode);
		 				break;
					case 1:
						testText.insertChars(t);
						input.value="";
						break;
					case 2:
						break;
					case 3:
						break;
					default:
						break;
				}
				break;
			}
	print(input.value);
}
void textChanged(e){
		print("changed");

}

void cmdEval(int cmd){
	switch(cmd){
		case 58: // change to CommandLine Mode (mode=2) 
		    modeChange(2);
	      	break;
		case 104://h
			testText.h();
			break;
		case 106://j
			testText.j();
			break;		
		case 107://k
			testText.k();
			break;
		case 108://l
			testText.l();
			break;
		case 105: //change to Insert Mode(mode:1) i
    
   			testText.updateCursor();
    		modeChange(1);
    		input.value="";
    		break;		
    	case 97: //change to Insert Mode(mode:1) i
    
   			testText.updateCursor();
    		modeChange(1);
    		testText.l();
    		input.value="";
    		break;
    	case 100:
    		testText.deleteLines(testText.cLine);
    		break;
    	case 120:  // x
    		testText.deleteChars();
    		break;
    	case 111:  // o
    		testText.insertLine(testText.cLine);
    		modeChange(1);
    		break;
    	default:
    		break;

	}
}
void eval(String exp){

}
void modeChange(int _mode){
  mode = _mode;
  query("#display").text = modeList[mode];
  switch(_mode){
    case 0:
     	input.value ="";
     	input.classes.remove('show');
     	input.classes.add('hide');
      break;
  case 2:
   	input.value ="";
   	input.focus();
   	input.classes.remove('hide');
   	input.classes.add('show');
    break;
  case 1://Insert Mode
    

  default:
    break;
  }
}

