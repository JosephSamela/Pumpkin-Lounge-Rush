PImage winscreen;
PImage losescreen;
PImage startscreen;
PFont font;
int gamestate = 1;
int score = 0;
int highscore = 0;
int x=-200, y, vy=0;
int[] wx =  new int[2];
int[] wy = new int[2];
int offset = 5;
String[] SCORE;

int[] colors = { color(191,58,41), color(232,127,36), color(241,196,15), color(39,174,97), color(42,128,185), color(143,68,173), color(0) , color(150) };

void setup() {
    //size(displayWidth, displayHeight);
    //fullScreen();
    //size(1280, 720)
    //orientation(LANDSCAPE);
    size(1920, 1080);
    //size(384,192);
       
   
    //SCORE = loadStrings("/sdcard/score.txt");
    //highscore = int(SCORE[0]);  //This Reads Saved High Score

        
    startscreen = loadImage("startscreen.png");
    winscreen = loadImage("winscreen.png");
    losescreen = loadImage("losescreen.png");
    font = createFont("font.TTF", 12);
    textFont(font);
    textSize(displayHeight*0.08);
}

void draw() {
  
  if(gamestate == 0){
    frameRate(60);
    
    if(score < 10) background(colors[0]);
    if(score > 9 & score < 20) background(colors[1]);
    if(score > 19 & score < 30) background(colors[2]);
    if(score > 29 & score < 40) background(colors[3]);
    if(score > 39 & score < 50) background(colors[4]);
    if(score > 49 & score < 60) background(colors[5]);
    if(score > 59 & score < 70) background(colors[6]);
    if(score > 69 & score < 80) background(colors[7]);
    if(score > 80) gamestate = 3;
    
    x -= 1;
    vy += height*0.005;    //Gravity
    y += vy/3;
   
   
    for(int i = 0 ; i < 1 ; i++) {
     rectMode(CORNERS);
     noStroke();
     fill(130);
     int gap = height/4;
     
     int wallwidth = int(width*0.08);
     rect(wx[i], 0, wx[i]+wallwidth, wy[i]); //top
     rect(wx[i], wy[i]+gap, wx[i]+wallwidth, height); //bottom
      
     if(wx[i] < -width*0.1){
       wy[i] = (int)random(0,height-gap);
       wx[i] = width;
     }
      
                  
      if(wx[i] == width/3){
        score += 1;
        highscore = max(score, highscore);
      }
      
      //Comment this loop to enable "god mode".
      if(y > height || y < 0 || (width/3 == wx[i] && (y>wy[i]+gap-(height*0.1)/3 || y<wy[i]+(height*0.1)/3))){
      gamestate = 2; 
      }
      
      wx[i] -= width*0.008; // Increase Speed (Even Int Only or scoring breaks)
    }
    fill(255);
    ellipse(width/3, y, height*0.1, height*0.1);
    text(" "+score, width*0.04, height*0.1);
  }
  
   else{
    int background = int(random(0,5));
    delay(100);
    background(colors[background]);
    imageMode(CORNER);
    image(startscreen,0,0,width,height);
    textAlign(CENTER);
    text("High Score " +highscore, width/2, height-height*0.06);
   }
   
    if(gamestate == 2){
    frameRate(60);
    imageMode(CORNER);
    background(0);
    image(losescreen,0,0,width,height);
    //SCORE[0] = str(highscore);  //This Saves Current High Score //<>//
    //saveStrings("//sdcard/downloads/score.txt", SCORE);
    }

    if(gamestate == 3){
    int background = int(random(0,5));
    delay(100);
    imageMode(CORNER);
    background(colors[background]);
    image(winscreen,0,0,width,height);
    highscore = 0;
    }
  }


void keyPressed() {
  vy = -int(height*0.05);
     
  if(gamestate==1) {
    wx[0] = width;
    wy[0] = height/2;

    x = gamestate = score = 0;
    y = height/2;
  }

if(gamestate == 2){
   gamestate = 1; 
  }

if(gamestate == 3){
   gamestate = 1; 
  }

}