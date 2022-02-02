class Pipe {
  //same distance between top and bottom pipe
  //width is the same but length can vary
  //find # of frames to spawn top and bottom pipe
  
  
  public float speed=5;
  public float w;
  private float top;
  private float bottom;
  private float x;
  private float y;
  private boolean added=false;
  private float gap;
  
  public Pipe(String gamemode) {
    if (gamemode.equals("ultrahard"))
       gap = 140;
    else
       gap = random(170, 300);
     x=width;
     y=0;
     w=50;
     top=random(height/4, height/2);
     bottom=height-top-gap;
     
  }
  public void move() {
    fill(0, 0, 0);
    x-=speed;
  }
  
  public void show() {
    fill(30, 227, 82);
    rect(x, 0, w, top); //top pipe
    rect(x, height-bottom, w, bottom); //bottom pipe
  }
  
   public boolean collide(bird b, float x, float y) {
    if((b.posX + x) >= this.x && (b.posX) <= (this.x + w)) {
      if (b.posY <= top || (b.posY+y) >= height-bottom ) { 
        return true;
      }
    }
    return false;
  }
}
