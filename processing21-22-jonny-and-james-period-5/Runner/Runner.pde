/**
 * Flappy bird
 * by Jonny Luo and James Liu. 
 * 
 * Play a game of flappy bird with various different gamemodes
 */
// https://www.youtube.com/watch?v=FVapAzb44DY
ArrayList<Pipe> pipeArr = new ArrayList<Pipe>(); //makes and Arraylist of the different pipes
PImage bg, img, bgBLUR;  //loads in the images that are used

public float width=1300, height=731; 
public int score = 0; //actual score during a single game
public int maxScore = 0;  //highest recorded score
private int checkScore = 0; //used to check if you beat the previous recorded high score
public int ultraX = (int) width/2 - 400, rectY = (int)height/2-100;
public int standardX = (int) width/2 + 200;

private boolean press = false; //check if spaced is pressed, then passes that into the b.move function

public String gamemode = "startup";
boolean isMousePressed = false;
int timesPlayed = 0;

boolean firstPressSpace = false; 

bird b; 


void setup(){
  size(1300, 731); //sets screen to be exact size of background image
  b = new bird();
  bg = loadImage("background.png"); //loads in cityscape image
  bgBLUR = loadImage("backgroundBLURRED.png"); 
}

void keyPressed() {
  if (key == ' ') {
    press = true;
    firstPressSpace = true; 
  }
  if (b.gameOver == 1) {
    if(key == ENTER) {
      b.gameOver = -1;  
      pipeArr.clear();
      background(bg);
      b.reset(600, 365, 0.5, 10.0, -10.0);

      score=0;
      if (maxScore > checkScore) {
        checkScore = maxScore; 
      }
      timesPlayed++;
    }
  }
}

boolean isMouseOver(int x, int y, int w, int h) {
  return mouseX >= x && mouseX <= x+w && mouseY >= y && mouseY <= y+h;
}

void mousePressed() {
 // if(isMouseOver((int) width/2, (int) height/2, 100, 50)==true) {
      isMousePressed = true;
  //}
}

void setMenuUI(int x1, int x2, int y) { //hard coded values x, y values for button + text
  background(bgBLUR);
  fill(0, 0, 0);
  textAlign(CENTER);
  textSize(30);
  fill(255, 0, 0);
  rect(x1, y, 200, 100); //"Ultrahard" button
  fill(0, 0, 0);
  text("Ultrahard", x1 + (200/2), 330);
  fill(0, 255, 0);
  rect(x2, y, 200, 100); //"Standard" button
  fill(0, 0, 0);
  text("Standard", x2 + (200/2), 330);
}

void draw() {
  fill(0, 0, 0);

  
  if (b.gameOver == -1) {
   if(gamemode.equals("startup") && timesPlayed == 0) { //
     
      setMenuUI(ultraX, standardX, rectY);
      if(isMousePressed==true) {
        if(isMouseOver(ultraX, rectY, 200, 100))
          gamemode = "ultrahard";
        else if(isMouseOver(standardX, rectY, 200, 100))
          gamemode = " ";
        b.gameOver=-1;

      }
      isMousePressed = false; 
    } 
    else {

      textAlign(LEFT); 
      
      background(bg);
      
      b.display();
      
      if (firstPressSpace == false){
            b.reset(600, 365, 0.5, 10.0, -10.0);
            pipeArr.clear();
      }
      else {
        b.move(press);
        press = false;
        if(frameCount%100 == 0)
          pipeArr.add(new Pipe(gamemode));
        for(int i=0; i<pipeArr.size(); ++i) {
          textSize(30);
          text("Score: " + score, 100, 100);
          text("High Score: " + maxScore, 100, 130);
          if((pipeArr.get(i).x+pipeArr.get(i).w<b.posX)&&!pipeArr.get(i).added) {
            pipeArr.get(i).added=true;
            score++;
          }
          if(pipeArr.get(i).collide(b, 835/12, 591/12)) {
            b.gameOver=1;
          }
          pipeArr.get(i).show();
          pipeArr.get(i).move();
          if(pipeArr.get(i).x<-pipeArr.get(i).w) {
            pipeArr.remove(i);
          }
        }
      }
    }
}

  else if (b.gameOver == 1) {
    firstPressSpace = false; 
    maxScore = max(maxScore, score);
    score = 0; 
    background(bgBLUR); 
    textAlign(CENTER);
    PFont font = loadFont(".SFNS-Regular-48.vlw");
    textFont(font, 48);
    if (maxScore > checkScore && timesPlayed > 0) {
      text("Game Over! \n Press ENTER to play again \n Score: " + score + "\n You're so cool, you beat your previous high score!", width/2, height/2-100);
    }
    else {
      text("Game Over! \n Press ENTER to play again \n Score: " + score, width/2, height/2-50);
    }
    fill(173,200, 230);
    rect(width/2-150, height/2+100, 300, 100);
    fill(0, 0, 0);
    textSize(20); 
    text("press to change gamemode", width/2, height/2+160); 

    if(isMousePressed==true) {
      if(isMouseOver((int) width/2-150, (int) height/2+100, 300, 100)) {
        setMenuUI(ultraX, standardX, rectY);
        b.gameOver=0;
        gamemode="startup";
       //can't have gameOver = false so add a game state for menu
      }
      isMousePressed = false;
    }
    
    //if the button's clicked do setMenuUI()
    //add a countdown once the game starts or have the bird hover until spacebar is pressed 
  }
  else {    
    b.reset(600, 365, 0.5, 10.0, -10.0);
    pipeArr.clear();

    setMenuUI(ultraX, standardX, rectY);
    if(isMousePressed==true) {
      if(isMouseOver(ultraX, rectY, 200, 100)) {
        gamemode = "ultrahard";
        b.gameOver = -1; 
      }
      else if(isMouseOver(standardX, rectY, 200, 100)) {
        gamemode = " ";
        b.gameOver = -1;
      }
      //b.gameOver= 1;
    }
    isMousePressed = false; 
    
    /**
    should probably make a function 
    */
  }
}
