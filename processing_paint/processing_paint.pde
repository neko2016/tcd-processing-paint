// Ying Feng (IDM, Processing Assignment)

int pensize = 2;               
int maxpensize = 20;
int minpensize = 1;

color menu_color = 235;        
color background_color = 255;
color pencolor = 0;               // default pencolor, black
color choosing_c = menu_color;    // show when choosing color
color chosen_c = menu_color ;     // show when the color is chosen
color active_c = 150;

int menu_height = 100;
int btn_width = 50;
int btn_height = 50;

float lx1, ly1, lx2, ly2;  // for dragging line
float cx1, cy1, cx2, cy2;  // for dragging circle
float rx1, ry1, rx2, ry2, rsizex, rsizey;  // for dragging rectangle
boolean selection_mode; // for dragging process
PImage p;   // for clearing screen when dragging the ellipse & rectangle
PImage pic; // for loading pictures from another directory

boolean button1 = false;  // scribble
boolean button2 = false;  // pen 
boolean button3 = false;  // brush
boolean button4 = false;  // straight line
boolean button5 = false;  // ellipse
boolean button6 = false;  // rectangle
boolean button7 = false;  // eraser
boolean button8 = false;  // clear screen
boolean button9 = false;  // make bold stroke
boolean button10 = false; // made thin stroke
boolean button11 = false; // color picker
boolean button12 = false; // fill or noFill
boolean button13 = false; // load image
boolean button14 = false; // save file

void setup(){
  size(800, 600);
  background(background_color);
  smooth();
  frameRate(200);
}

void draw(){
  createButtons();
  drawIcons();
  drawSwatch();
  changeCursor();
  if (button1 && mouseY > menu_height) {
    scribble();
  }
  if (button2 && mouseY > menu_height) {
    pen();
  }
  if (button3 && mouseY > menu_height) {
    brush();
  }
  if (button4 && mouseY > menu_height) {
    drawLine();
  }
  if (button5 && mouseY > menu_height) {
    drawCircle();
  }
  if (button6 && mouseY > menu_height) {
    drawBox();
  }
  if (button7 && mouseY > menu_height) {
    eraser();
  }
  if (button11 && mouseY > btn_height && mouseY < menu_height) {  
    pickColor();
  }
  if (button12 == false) {
    btn12UI();
  }
}

int btn_sw = 2; // button strokeWeight
void createButtons(){
  for (int i = 0; i < 16; i++) {
    stroke(255);
    strokeWeight(btn_sw);
    fill(menu_color);
    rect(btn_width*i, 0, btn_width, btn_height);
  }
  if (button1) {
      fill(active_c);
      rect(btn_width*0, 0, btn_width, btn_height);
  }
  if (button2) {
      fill(active_c);
      rect(btn_width*1, 0, btn_width, btn_height);
  }
  if (button3) {
      fill(active_c);
      rect(btn_width*2, 0, btn_width, btn_height);
  }
  if (button4) {
      fill(active_c);
      rect(btn_width*3, 0, btn_width, btn_height);
  }
  if (button5) {
      fill(active_c);
      rect(btn_width*4, 0, btn_width, btn_height);
  }
  if (button6) {
      fill(active_c);
      rect(btn_width*5, 0, btn_width, btn_height);
  }
  if (button7) {
      fill(active_c);
      rect(btn_width*6, 0, btn_width, btn_height);
  }
  if (button8) {
      fill(active_c);
      rect(btn_width*7, 0, btn_width, btn_height);
  }
  if (button9) {
      fill(active_c);
      rect(btn_width*8, 0, btn_width, btn_height);
  }
  if (button10) {
      fill(active_c);
      rect(btn_width*9, 0, btn_width, btn_height);
  }
  if (button12) {
      fill(active_c);
      rect(btn_width*11, 0, btn_width, btn_height);
  }
  if (button13) {
      fill(active_c);
      rect(btn_width*12, 0, btn_width, btn_height);
  }
  if (button14) {
      fill(active_c);
      rect(btn_width*13, 0, btn_width, btn_height);
  }
  if (button11) {
    fill(active_c);                                   // color picker UI when activated
    rect(btn_width*10, 0, btn_width, btn_height);
    
    fill(choosing_c);                                 // display dynamic colors by moving the cursor above the swatch 
    rect(btn_width*14, 0, btn_width, btn_height);
    fill(chosen_c);                                   // display the chosen color for stroke() and fill() by clicking the mouse
    rect(btn_width*15, 0, btn_width, btn_height);
  } else  {                                           // color picker UI when not activated
    fill(chosen_c);
    rect(btn_width*14, 0, btn_width*2, btn_height);
  }
}


void drawIcons(){
  PShape scribble;
  scribble = loadShape("01.svg");
  shape(scribble, 10, 10, 33, 33);
  PShape pen;
  pen = loadShape("02.svg");
  shape(pen, 10+btn_width, 10, 33, 33);
  PShape brush;
  brush = loadShape("03.svg");
  shape(brush, 10+btn_width*2, 10, 33, 33);
  PShape straightline;
  straightline = loadShape("04.svg");
  shape(straightline, 10+btn_width*3, 10, 33, 33);
  PShape circle;
  circle = loadShape("05.svg");
  shape(circle, 10+btn_width*4, 10, 33, 33);
  PShape square;
  square = loadShape("06.svg");
  shape(square, 10+btn_width*5, 10, 33, 33);
  PShape eraser;
  eraser = loadShape("07.svg");
  shape(eraser, 10+btn_width*6, 10, 33, 33);
  PShape refresh;
  refresh = loadShape("08.svg");
  shape(refresh, 10+btn_width*7, 10, 33, 33);
  PShape bold;
  bold = loadShape("09.svg");
  shape(bold, 10+btn_width*8, 10, 33, 33);
  PShape thin;
  thin = loadShape("10.svg");
  shape(thin, 10+btn_width*9, 10, 33, 33);
  PShape colorpicker;
  colorpicker = loadShape("11.svg");
  shape(colorpicker, 10+btn_width*10,10, 33, 33);
  PShape fillshape;
  fillshape = loadShape("12.svg");
  shape(fillshape, 10+btn_width*11,  10, 33, 33);
  PShape load;
  load = loadShape("13.svg");
  shape(load,10+btn_width*12,  10, 37, 37);
  PShape save;
  save = loadShape("14.svg");
  shape(save, 10+btn_width*13, 10, 33, 33);
}  

PImage swatch;
void drawSwatch(){
  swatch = loadImage("swatch.jpg");
  image(swatch, 0, btn_height, 800, 50);
}

// change the cursor for menu & canvas
void changeCursor(){
  if(mouseY < btn_height && mouseX <700){
    cursor(HAND);
  } else if (mouseY > btn_height && mouseY < menu_height && button11) {
    cursor(CROSS);
  } else {
    cursor(ARROW);
  }  
}

// events, using boolean to switch buttons
void mousePressed(){
  // the first IF statement is to determine which button is selected
  if (mouseButton == LEFT && mouseY < btn_height) {
    int toolid = (int)(mouseX / btn_height);
    println(toolid);
    switch(toolid) {
      case 0:
        if (button1) {
          button1 = false; 
          println("button1 changed to 0");
        } 
        else {
          button2 = false;
          button3 = false;
          button4 = false;
          button5 = false;
          button6 = false;
          button7 = false;
          button11 = false; // turn off color picker
          println("the other buttons changed to 0");
          button1 = true;
          println("button1 changed to 1");
          println("btn1: 1st pressed no selection_mode");
          // p = null;
        }
        break;
    case 1:
        if (button2) {
          button2 = false; 
          println("button2 changed to 0");
        } 
        else {
          button1 = false;
          button3 = false;
          button4 = false;
          button5 = false;
          button6 = false;
          button7 = false;
          button11 = false; // turn off color picker
          println("the other buttons changed to 0");
          button2 = true;
          println("button2 changed to 1");
          // p = null;
        }
        break;
    case 2:
        if (button3) {
          button3 = false; 
          println("button3 changed to 0");
        } 
        else {
          button1 = false;
          button2 = false;
          button4 = false;
          button5 = false;
          button6 = false;
          button7 = false;
          button11 = false; // turn off color picker
          println("the other buttons changed to 0");
          button3 = true;
          println("button3 changed to 1");
        }
        break;
    case 3:
       if (button4) {
          button4 = false; 
          println("button4 changed to 0");
        } 
        else {
          button1 = false;
          button2 = false;
          button3 = false;
          button5 = false;
          button6 = false;
          button7 = false;
          button11 = false; // turn off color picker
          println("the other buttons changed to 0");
          button4 = true;
          println("button4 changed to 1");
          p = null;
          // selection_mode = true;
          // p = get();
          // println("bt4: 1st pressed, selection_on");
        }
        break;   
    case 4:
       if (button5) {
          button5 = false; 
          println("button5 changed to 0");
        } 
        else {
          button1 = false;
          button2 = false;
          button3 = false;
          button4 = false;
          button6 = false;
          button7 = false;
          button11 = false; // turn off color picker
          println("the other buttons changed to 0");
          button5 = true;
          println("button5 changed to 1");
          p = null;
        }
        break;   
    case 5:
        if (button6) {
          button6 = false; 
          println("button6 changed to 0");
        } 
        else {
          button1 = false;
          button2 = false;
          button3 = false;
          button4 = false;
          button5 = false;
          button7 = false;
          button11 = false; // turn off color picker
          println("the other buttons changed to 0");
          button6 = true;
          println("button6 changed to 1");
          p = null;
        }
        break;
    case 6:
        if (button7) {
          button7 = false; 
          println("button7 changed to 0");
        } 
        else {
          button1 = false;
          button2 = false;
          button3 = false;
          button4 = false;
          button5 = false;
          button6 = false; 
          button11 = false; // turn off color picker
          println("the other buttons changed to 0");
          button7 = true;
          println("button7 changed to 1");
        }
        break;
    case 7:                                    // button8 for clearing screen         
          button1 = false;
          button2 = false;
          button3 = false;
          button4 = false;
          button5 = false;
          button6 = false;
          button7 = false;                    // all buttons are switched off after clearing the screen
          button11 = false;                   // turned off color picker
          button12 = false;                   // reset to noFill() for button12;
          println("the other buttons changed to 0");
          button8 = true;
          println("button8 changed to 1");
          background(background_color); 
          p = null;
          // p = get(); useless because it will not be updated in draw();
          pic = null;                         // remove the loaded image if any
          pensize = 3;                        // reset pensize to default value
          button8 =! button8 ;
          break;
    case 8:                                         //  button9 increase strokeWeight          
          button9 = true;
          println("button9 changed to 1");
          button10 = false;
          println("button10 changed to 0");
          button1 = false;
          button2 = false;
          button3 = false;
          button4 = false;
          button5 = false;
          button6 = false;
          button7 = false;
          print("buttons 1-7 turned off");          
          if (pensize < maxpensize) {
            pensize ++;
          }
          break;
    case 9:                                         //  button10 reduce strokeWeight    
          button10 = true;
          println("button10 changed to 1");
          button9 = false;
          println("button9 changed to 0");
          button1 = false;
          button2 = false;
          button3 = false;
          button4 = false;
          button5 = false;
          button6 = false;
          button7 = false;
          print("buttons 1-7 turned off");
          if (pensize > minpensize) {
            pensize --;
          }
          break;
     case 10: 
          if (button11){                           // button11 pick color;
            button11 = false;  
            println("button11 changed to 0");
          }
          else {
            button11 = true;
            println("button11 changed to 1");
            button1 = false;
            button2 = false;
            button3 = false;
            button4 = false;
            button5 = false;
            button6 = false;
            button7 = false;
            // button12 = false;
            print("buttons 1-7 turned off");
          }
          break;
     case 11:                                 
          if(button12){                          // button12 for switching on fill(); 
            button12 = false;                    // unfilled ellipse & rectangle
            println("button12 changed to 0");
          }
          else {                                // filled ellipse & rectangle
            button12 = true;
            println("button12 changed to 1");
            button1 = false;
            button2 = false;
            button3 = false;
            button4 = false;
            button5 = false;
            button6 = false;
            button7 = false;
            print("buttons 1-7 turned off");
          }
          break;
     case 12:                                     // button13 to load image from a directory; the image could be removed by button8
          pic = null;                             // unload any image before opening a folder; 
          println("unloaded image");
          println("ready to load an image from folder");
          noLoop();                                            // pause the loop, otherwise it opens folders forever
          if (pic == null) selectInput("Choose an image", "inputFile"); 
          while (pic == null) delay(200);
          // image(pic, 0, 100);                              // option1: load the oringal image, automatically cropped if larger than the window
          pic.resize(800, 800*(int)(pic.height/pic.width));   // option2: resize image, using width to determine height to keep the original ratio;
          image(pic, 0, 100); 
          break;
     case 13:                                    //  button14  save the file; 
          PImage export = get(0,100,width,height-menu_height);
          export.save("export.jpg");             // overwrite the previous export if any
          println("image saved");
          break;
    }   
  }
  
  // the second IF statement to pick up the mouse coordinates before dragging
  if (mouseButton == LEFT && mouseY > menu_height){
      if (button4) {
        selection_mode = true;
        println("bt4: 2nd pressed, selection_on");
        lx1 = mouseX;
        ly1 = mouseY;
        lx2 = mouseX;
        ly2 = mouseY;
        p = get();
        println("lx1:", mouseX, "ly1:", mouseY);
      }
      if (button5) {
        selection_mode = true;
        println("btn5: 2nd pressed, selection_on");
        cx1 = mouseX;
        cy1 = mouseY;
        cx2 = mouseX;
        cy2 = mouseY;
        p = get();
        println("cx1:", mouseX, "cy1:", mouseY);
      }     
     if (button6) {
        selection_mode = true;
        println("btn6: 2nd pressed, selection_on");
        rx1 = mouseX;
        ry1 = mouseY;
        rsizex = 0;
        rsizey = 0;
        p = get();
        println("rx1:", mouseX, "ry1:", mouseY);
     }    
  }  
}

void mouseDragged(){
  if (mouseY > menu_height){    
    // button4
    if (button4) {        
      lx2 = mouseX;
      ly2 = mouseY;
      println("dragged: btn4");
    }  
    // button5
    if (button5) {
      cx2 = mouseX;
      cy2 = mouseY;
      println("dragged: btn5");
    }
    // button6
    if (button6) {
      rx2 = mouseX;
      ry2 = mouseY;
      rsizex = rx2 - rx1;
      rsizey = ry2 - ry1;
      println("dragged: btn6");
    }
  } 
}

void mouseReleased(){
  if (mouseButton == LEFT && mouseY > menu_height){
    // button4
    if (button4){       
      selection_mode = false;
      println("released: btn4");
    }
    // button5
    if (button5) {
      selection_mode = false;
      println("released: btn5");
    }
    // button6
    if (button6) {
      selection_mode = false;
      println("released: btn6");
    }
  }    
}


/* ========================================= specific functions for buttons ======================================= */

// button1
void scribble(){
    noStroke();
    strokeWeight(pensize);
    fill(pencolor);
    if(mousePressed){
      ellipseMode(CENTER);  // remove btn5 impact on btn1 
      ellipse(mouseX, mouseY, pensize+10, pensize+10);
    }
}

// button2
void pen(){
    stroke(pencolor);
    strokeWeight(pensize);
    if(mousePressed){
      line(mouseX, mouseY, pmouseX, pmouseY);
    }
}

// button3
void brush(){
    stroke(random(255), random(255), random(255));
    strokeWeight(random(3,pensize+5));
    strokeCap(ROUND);
    if (mousePressed) {
    line(mouseX, mouseY, pmouseX, pmouseY);
  }
}

//button4
void drawLine(){
  stroke(pencolor);
  strokeWeight(pensize);
  if (p != null) {
    image(p, 0, 0);
    if(selection_mode == true) {
      strokeWeight(pensize); 
      println("drawLine: selection_mode on");
      line(lx1, ly1, lx2, ly2);
    } else {
      strokeWeight(pensize); 
      line(lx1, ly1, lx2, ly2);
      p = get();   //to get the last frame of the mouse event
    }
  }
}

//button5
void drawCircle() {
  stroke(pencolor);
  strokeWeight(pensize);
  if (button12 == false){
     noFill();
  } 
  else { 
     fill(chosen_c);
  }
  if (p!=null) {
    image(p,0,0);
    if(selection_mode == true) {
      println("drawCircle: selection_mode on");
      ellipseMode(CORNERS);
      ellipse(cx1, cy1, cx2, cy2);
    } else {
      ellipse(cx1, cy1, cx2, cy2); 
      p = get();  //to get the last frame of the mouse event
    }
  }
}

//button6 
void drawBox(){
  stroke(pencolor);
  strokeWeight(pensize);
  if (button12 == false){
     noFill();
  } 
  else { 
     fill(chosen_c);
  }
  if (p!=null) {
    image(p,0,0);
    if(selection_mode == true) {
      println("drawBox: selection_mode on");
      rect(rx1, ry1, rsizex, rsizey);
    } else {
      rect(rx1, ry1, rsizex, rsizey); 
      p = get();  //to get the last frame of the mouse event
    }
  }
}

//button7
void eraser() {
  if (mousePressed) {
    noStroke();
    fill(background_color);
    ellipseMode(CENTER);  // remove btn5 impact on btn7
    ellipse(mouseX, mouseY, pensize+20, pensize+20); 
  }
}


/* -------- these  buttons doesn't need to be automatically updated in the draw() function------------ 
button8 clear screen
button9 increase strokeWeight
button10 reduce strokeWeight
button13 load image
button14 save file
----------------------------------------------------------------------------------------------------*/

void pickColor(){
   choosing_c = get(mouseX, mouseY);
   fill(choosing_c);
   rect(btn_width*14, 0, btn_width, btn_height);   // indication for choosing color on the left (button15)
   if(mousePressed) {
     chosen_c = get(mouseX, mouseY);
     pencolor = chosen_c;
     fill(chosen_c);
     rect(btn_width*14, 0, btn_width*2, btn_height);  // indication for the chosen color on the right (button16)
   } 
}

void btn12UI(){
    stroke(255);
    strokeWeight(btn_sw);
    fill(menu_color);
    rect(btn_width*11, 0, btn_width, btn_height);
    PShape fillshape;
    fillshape = loadShape("12.svg");
    shape(fillshape, 10+btn_width*11,  10, 33, 33);
}

void inputFile(File selected) {
  if (selected == null) {
  println("Window was closed or the user hit cancel.");
  // exit();    // return to the window rather than existing the program 
  } else {
  pic = loadImage(selected.getAbsolutePath());
  println("image loaded sucessfully");
  loop();      // keep refreshing to use other buttons
  } 
}
