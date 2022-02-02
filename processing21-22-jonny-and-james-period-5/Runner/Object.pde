/**
  Creates a flappy bird object
*/

public class bird {
  
  private int gameOver = -1; //determines if game is over (1 = game over; 0 = in menu; -1 = in game) 
  
  private float posX;
  private float posY;
  private float gravity; 
  private float speedY; 
  private float jump; 
  
  private int flapCount = 1; //changes the image to "flap" the wings
  
  PImage flappyUp = loadImage("flappybirdwingup.png"); //loads in the flappy bird image with the wings up
  PImage flappyDown = loadImage("flappybirdwingdown.png"); //loads in the flappy bird image with the wings down

  /**
    constructor that sets the variables so that you can create birds
    with different starting position, gravity, speed, and jump amount
    
    @param = x,y positions & gravity & vertical speed & jump height
    @return nothing
  */ 
  
  public bird(float x_position, float y_position, float grav, float vert_speed, float jump_amount) {
    posX = x_position;
    posY = y_position;
    gravity = grav;
    speedY = vert_speed;
    jump = jump_amount;
  }
  
  /**
    sets default bird with set values
    
    @param none
    @return nothign
  */ 
  
  public void setBirdPos(float x, float y) {
    this.posX=x;
    this.posY=y;
  }
  
  public bird(){
    this(600, 365, 0.5, 10.0, -10.0); 
  }
  
  
  public void display() {
    
    /**
    changes images based on 'flapCount' to make the wings move
    */
    
    if (flapCount <= 10) { 
      image(flappyUp, posX, posY, 835/12, 591/12); //draws the bird with smaller dimensions that acutal png
    }
    else {
      image(flappyDown, posX, posY, 835/12, 591/12); //draws the bird with smaller dimensions that acutal png
      if (flapCount >= 20) {
        flapCount = 1; 
      }
    }
    flapCount++; 
    
    /**
    check if the bird hits the ground
    */
    
    if (posY >= height) {
      gameOver = 1; 
    }
    

  }
  
  /**
    moves the bird -> add speedY to posY to make the bird move down, then you add gravity to speedY to simulate acceleration
    if the space key is pressed, then you set speedY to a negative value, making the bird go up
    
    @param boolean press
    @return nothing
  */
  public void move(boolean press){
    posY += speedY; 
    speedY += gravity; 
    if (press) {
      speedY = jump;
    }
  }
  
  public void changeGrav(float newGrav) {
    gravity = newGrav; 
  }
  
  public void reset(float x_position, float y_position, float grav, float vert_speed, float jump_amount) {
    posX = x_position;
    posY = y_position;
    gravity = grav;
    speedY = vert_speed;
    jump = jump_amount;
  }
}
