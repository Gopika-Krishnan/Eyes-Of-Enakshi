import processing.video.*;
import processing.sound.*;
SoundFile beep,theme,lose,win;
int last_stage = 0;
int aboutOver =0;
// Step 1. Declare a Movie object.
Movie movie1, movie2, movie3,stat;
int killerTrigger = -1;
int frameC = 0;
int frameE = 0;
int playO=0;
int introOver =0;
//LEGEND, CLUES(4)
int legend =-1;
int slide = 0;
int guess = -1;
int soln=-1;
int lockClue=0;
int password=0;
int diaryClue=0;
int newsClue=0;
int kidClue=0;
PImage img;
int alpha = 0;
int page=1;
int dcount=0; //diary count
int table=0;
import processing.video.*;
Capture video;
int locX, locY;
PImage prevFrame, myst;
float threshold=20;
PImage enakshi, diary, news, docs,kid,eyes, intro, D1,D2,D3,D4,D5,D6,D7,D8,card,about,perlin,instruct,good,morse,ev1,finger,lift,ev3,ev4,access,speak,ev2;
PFont mono;
int clueLog=0;
int proceedClue=0;
int passLock=0;
int interview=0;


PFont mono1,mono2;

import processing.serial.*;
Serial myPort;




void setup() {
  fullScreen();
  background(5);

  beep = new SoundFile(this, "beep.wav");
   theme = new SoundFile(this, "sound.mp3");
   lose = new SoundFile(this, "lose.mp3");
   win = new SoundFile(this, "win.mp3");
  theme.loop();
  printArray(Serial.list());
  String portname=Serial.list()[7];
  println(portname);
  myPort = new Serial(this, portname, 9600);
  myPort.clear();
  myPort.bufferUntil('\n');
 
  init(false);
  //save_pdf("14");
  example3();

  movie1 = new Movie(this, "1.mp4");
  movie2 = new Movie(this, "2.mp4");
  movie3 = new Movie(this, "3.mp4");
  stat = new Movie(this, "glitch.mp4");
   ev1 = loadImage("ev1.png");
   finger = loadImage("5.png");
   lift = loadImage("lift.png");
    ev2 = loadImage("ev2.png");
  myst = loadImage("myst.jpeg");
  diary = loadImage("diary.png");
  ev3 = loadImage("ev3.png");
//ev4 = loadImage("ev4.png");
access = loadImage("access.png");
speak = loadImage("speak.png");
  enakshi = loadImage("enakshi.png");
   good = loadImage("good.png");
  docs = loadImage("docs.png");
  perlin = loadImage("perlin.png");
  news = loadImage("news.png");
  kid = loadImage("kid.png");
  eyes = loadImage("eyes.png");
  intro = loadImage("intro.png");
  card = loadImage("card.png");
  morse = loadImage("morse.png");
about = loadImage("about.png");
instruct = loadImage("instruct.png");
 D1 = loadImage("D1.png");
 D2 = loadImage("D2.png");
 D3 = loadImage("D3.png");
 D4 = loadImage("D4.png");
 D5 = loadImage("D5.png");
 D6 = loadImage("D6.png");
 D7 = loadImage("D7.png");
 D8 = loadImage("D8.png");
  mono = loadFont("Luminari-Regular-32.vlw");
  textFont(mono);
  mono2 = loadFont("Luminari-Regular-120.vlw");
  mono1 = loadFont("Luminari-Regular-42.vlw");
}

void movieEvent(Movie movie) {
  movie.read();
}

void draw() {
  //print("aboutOver: ");
  // println(aboutOver);
  //print("clueLog: ");
  // println(clueLog);
   print("legend: ");
  println(legend);
  if(clueLog>=1)
  {
    imageMode(CENTER);
    background(0);
    if(clueLog==1)
    {
      tint(255, 255);
      image(diary, width/2,height/2);
      textSize(27);
      fill(152, 251, 152);
      rect(1300, 860, 130, 40, 30);
      fill(0);
      text("Next", 1330, 890);
    }
    else if (clueLog==2)
    {
          image(news, width/2,height/2);
      textSize(27);
      fill(152, 251, 152);
    rect(1300, 860, 130, 40, 30);
    fill(0);
    text("Next", 1330, 890);
     fill(255,127, 127);
    rect(20, 860, 130, 40, 30);
    fill(0);
    text("Back", 50, 890);
    }
     else if (clueLog==3)
    {

    
    imageMode(CENTER);
      image(kid, width/2,height/2);
      textSize(27);
       fill(152, 251, 152);
    rect(1300, 860, 130, 40, 30);
    fill(0);
    text("Next", 1330, 890);
     fill(255,127, 127);
    rect(20, 860, 130, 40, 30);
    fill(0);
    text("Back", 50, 890);
    }
     else if (clueLog==4)
    {
      image(docs,width/2,height/2);
      textSize(27);
       fill(152, 251, 152);
    rect(1190, 860, 250, 40, 30);
    fill(0);
    text("Back to choosing", 1210, 890);
     fill(255,127, 127);
    rect(20, 860, 130, 40, 30);
    fill(0);
    text("Back", 50, 890);
    }
  }
  else
  {
  legend();
  // print("guess: ");
  //println(guess);
  //print("killerTrigger: ");
  //println(killerTrigger);
  if(diaryClue==400 && lockClue==400 && newsClue==400 && kidClue==400)
  {
     chooseKiller();
  }
  else
  {
  if(legend>14)
    solve();
  
  print("legend: ");
  println(legend);
  // print("kid: ");
  //println(kidClue, diaryClue,newsClue,lockClue);


  if (legend==4)
  {
    if(frameE<300)
    {
    background(0);
    if (video.available()) {
      prevFrame.copy(video, 0, 0, width, height, 0, 0, width, height);
      prevFrame.updatePixels();
      video.read();
    }
    video.loadPixels();
    prevFrame.loadPixels();
    loadPixels();
    float totalMotion=0;
    for (int y=0; y<height; y++) {
      for (int x=0; x<width; x++) {
        int loc = (video.width-x-1)+(y*width);
        color pix=video.pixels[loc];
        color prevPix=prevFrame.pixels[loc];
        float r1=red(pix);
        float g1=green(pix);
        float b1=blue(pix);
        float r2=red(prevPix);
        float g2=green(prevPix);
        float b2=blue(prevPix);
        float diff=dist(r1, g1, b1, r2, g2, b2);
        totalMotion+=diff;
        if (diff>threshold) {

          pixels[loc]=color(enakshi.get(x-width/4, y));
        } else {
          pixels[loc]=color(0);
        }
      }
    }
    float avgMotion=0;
    avgMotion=totalMotion/pixels.length;
    video.updatePixels();
    prevFrame.updatePixels();
    updatePixels();
    
    

    fill(253, 208, 23);


    textSize(30);
  
    text("Wave through the fog\n   to see Enakshi! ", 1100, 365);
    

   
    frameE++;
    }
    else
    {
        background(0);
    imageMode(CENTER);
     image(good,width/2,height/2);
    imageMode(CORNER);
  
     fill(152, 251, 152);
    rect(1300, 860, 130, 40, 30);
    fill(0);
    text("Next", 1330, 890);
     
    }
    //if(avgMotion>80)
    //{
    // background(0);
    // while(frameE<400)
    // {
    //  background(0);
    //fill(#FFDD17);
    //textSize(80);
    //text("Good job, Detective! You were able to take a \nlook and escape in time.", 100, height/2);
    // 
    // textSize(30);
    //}
    //if(frameE>=400)
    //{
    //  legend++;
    ////  frameE=100;
     
    //}
   
    
    
  }

 
}
}
}



void legend() {
  
  if(legend==-2)
  {
    aboutOver=0;
    pushMatrix();
    background(0);
    imageMode(CENTER);
    image(about,width/2,height/2);
    popMatrix();
    imageMode(CORNER);
    fill(152, 251, 152);
    rect(1300, 860, 130, 40, 30);
    fill(0);
    text("Back", 1330, 890);
  }
  
  if(legend==-1)
  {
    if (aboutOver==1) 
    {
      
      background(0); 
      aboutOver=0;
    }

    draw_and_update();
    textFont(mono2);
    fill(0,30);
    stroke(#ff7b7b);
    strokeWeight(0.5);
    rect(width/8,height/4,width-width/4,height-height/2,30);
    fill(255);
    text("Eyes of Enakshi",width/8+100,height/4+240);
    fill(255,0,0);
    text("Eyes of Enakshi",width/8+100,height/4+245);
    textFont(mono);
    stroke(0);
    strokeWeight(0.5);
  }
  if (legend==0)
  {

    background(5);
    movie1.loop();
    image(movie1, 100, 0);
    textSize(29);
    fill(0);
    rect(0, 700, width, height);
    rect(0, 0, width, 150);
    fill(253, 208, 23);

    text("It was 1864, when the Raman family moved to the temple town of Medikeru. The town was devoted\n   to their temple - the 'Karalore Devi' temple and workshipped the deity of the temple will utmost\n            devotion. As a tradition, the townsfolk made sure to donate to the temple annually. ", 60, 740);
    fill(152, 251, 152);
    rect(1300, 860, 130, 40, 30);
    fill(0);
    text("Next", 1330, 890);
  }
  if (legend==1)
  {

    movie1.stop();
    // Step 3. Start playing movie. To play just once play() can be used instead.
    movie2.loop();
    image(movie2, 100, 0);
    textSize(29);
    fill(0);
    rect(0, 700, width, height);
    rect(0, 0, width, 150);
    fill(253, 208, 23);
    text("The people went around collecting money from the residents for the temple. However, the head of\n the Raman family refused to give money, and proceeded to mock them for the tradition. But soon..", 60, 740);
    fill(152, 251, 152);
    rect(1300, 860, 130, 40, 30);
    fill(0);
    text("Next", 1330, 890);
    fill(255,127, 127);
    rect(20, 860, 130, 40, 30);
    fill(0);
    text("Back", 50, 890);
  }
  if (legend==2)
  {

    movie2.stop();
    // Step 3. Start playing movie. To play just once play() can be used instead.
    movie3.loop();
    image(movie3, 100, 0);
    textSize(29);
    fill(0);
    rect(0, 700, width, height);
    rect(0, 0, width, 150);
    fill(253, 208, 23);
    text("Enakshi came for him. She was angered by the disrespect. She is a supernatural creature who is\n      known to kill with her gaze - her doe-shaped eyes turn blood red when she is angered and \n        she kills within seconds. Soon, the man was killed. In the following years, the family devoted\n                                            themselves to Enakshi and donated money without fail.", 50, 740);
    fill(255, 0, 0);
    text("Enakshi", 50, 740);

    fill(152, 251, 152);
    rect(1300, 860, 130, 40, 30);
    fill(0);
    text("Next", 1330, 890);
    fill(255,127, 127);
    rect(20, 860, 130, 40, 30);
    fill(0);
    text("Back", 50, 890);
  }

  if (legend==3 )
  {
    
    video = new Capture(this, width, height);
    video.start();
    prevFrame=createImage(width, height, RGB);
    legend=4;
  }
  
  if(legend==5)
  {
    background(5);
   
    image(intro, 40, 60);
    fill(152, 251, 152);
    rect(1300, 860, 130, 40, 30);
    fill(0);
    text("Next", 1330, 890);
    
    
  }
  
  if(legend==6)
  {
    background(5);
   
    image(D1, 40, 60);
    fill(152, 251, 152);
    rect(1300, 860, 130, 40, 30);
    fill(0);
    text("Next", 1330, 890);
    fill(255,127, 127);
    rect(20, 860, 130, 40, 30);
    fill(0);
    text("Back", 50, 890);
    
  }
  
  if(legend==7)
  {
    background(5);
   
    image(D2, 40, 60);
    fill(152, 251, 152);
    rect(1300, 860, 130, 40, 30);
    fill(0);
    text("Next", 1330, 890);
    fill(255,127, 127);
    rect(20, 860, 130, 40, 30);
    fill(0);
    text("Back", 50, 890);
    
  }
   if(legend==8)
  {
    background(5);
   
    image(D3, 40, 60);
    fill(152, 251, 152);
    rect(1300, 860, 130, 40, 30);
    fill(0);
    text("Next", 1330, 890);
    fill(255,127, 127);
    rect(20, 860, 130, 40, 30);
    fill(0);
    text("Back", 50, 890);
    
  }
  
  if(legend==9)
  {
    background(5);
   
    image(D4, 40, 60);
    fill(152, 251, 152);
    rect(1300, 860, 130, 40, 30);
    fill(0);
    text("Next", 1330, 890);
    fill(255,127, 127);
    rect(20, 860, 130, 40, 30);
    fill(0);
    text("Back", 50, 890);
    
  }
  if(legend==10)
  {
    background(5);
   
    image(D5, 40, 60);
    fill(152, 251, 152);
    rect(1300, 860, 130, 40, 30);
    fill(0);
    text("Next", 1330, 890);
    fill(255,127, 127);
    rect(20, 860, 130, 40, 30);
    fill(0);
    text("Back", 50, 890);
    
  }
  if(legend==11)
  {
    background(5);
   
    image(D6, 40, 60);
    fill(152, 251, 152);
    rect(1300, 860, 130, 40, 30);
    fill(0);
    text("Next", 1330, 890);
    fill(255,127, 127);
    rect(20, 860, 130, 40, 30);
    fill(0);
    text("Back", 50, 890);
    
  }
   if(legend==12)
  {
    background(5);
   
    image(D7, 40, 60);
    fill(152, 251, 152);
    rect(1300, 860, 130, 40, 30);
    fill(0);
    text("Next", 1330, 890);
   fill(255,127, 127);
    rect(20, 860, 130, 40, 30);
    fill(0);
    text("Back", 50, 890);
    
  }
  
   if(legend==13)
  {
    background(5);
   
    image(D8, 40, 60);
    fill(152, 251, 152);
    rect(1300, 860, 130, 40, 30);
    fill(0);
    text("Next", 1330, 890);
   fill(255,127, 127);
    rect(20, 860, 130, 40, 30);
    fill(0);
    text("Back", 50, 890);
    
  }

  if (legend==14 )
  {
    background(5);
    tint(255, 90);
    image(eyes, width/2-400, height/2-330);
    fill(253, 208, 23);
    textSize(48);
    text("             Detective, I kill people, but this time, it's not me. \n Something's not right. Here's something I found that can help you!", 20, height/2-40);
    textSize(32);
    fill(130, 0, 0);

   fill(152, 251, 152);
    rect(1300, 860, 130, 40, 30);
    fill(0);
    text("Next", 1330, 890);
  }
  
    if (legend==15 )
  {
    background(5);
    imageMode(CENTER);
    tint(255,255);
    image(morse,width/2,height/2);
        introOver=1;
    imageMode(CORNER);
    fill(255,127, 127);
    
    rect(1290, 860, 150, 40, 30);
    fill(0);
    text("Solved!", 1320, 890);
    
  }
   if (legend==16 )
  {
    background(5);
    imageMode(CENTER);
    tint(255,255);
    image(finger,width/2,height/2);
    
    imageMode(CORNER);

    
  }
   if (legend==18 )
  {
    background(5);
    imageMode(CENTER);
    tint(255,255);
    image(ev2,width/2,height/2);
    
    imageMode(CORNER);

    
  }
  
  
  //kid one
  if (legend==19 )
  {
    background(5);
    imageMode(CENTER);
    tint(255,255);
    image(ev3,width/2,height/2);
    
    imageMode(CORNER);

    
  }
  //card one
  if (legend==21 )
  {
    background(5);
    imageMode(CENTER);
    tint(255,255);
    image(lift,width/2,height/2);
    
    imageMode(CORNER);

    
  }
  
  if (legend==45 )
  {
    movie3.stop();
    background(5);
    imageMode(CENTER);
    image(instruct,width/2,height/2);
    imageMode(CORNER);
    fill(152, 251, 152);
    rect(1300, 860, 130, 40, 30);
    fill(0);
    text("View!", 1330, 890);
   
  
  }
}

void solve()
{
  //table page
  //if (soln==0)
  //{
  //  //if(diaryClue==500)diaryClue=400;
  //  // if(newsClue==500)newsClue=400;
  //  //  if(lockClue==500)lockClue=400;
    
  //  background(5);
  //  tint(255, 90);
  //  image(myst, 90, height/2-330);
  //  fill(253, 208, 23);
  //  textSize(48);
  //  text("On the table in front of you, there are items acquired from the\n  murder scene. Inspect them and find clues to figure out who\n                                       the murderer is... ", 20, height/2-40);
  //  //fill(21, 105, 199);
  //  //rect(300, 720, 200, 50, 30);
  //  //fill(0);
  //  //textSize(40);
  //  //text("Hints", 350, 760);
  //  //fill(152, 251, 152);
  //  //rect(920, 720, 200, 50, 30);
  //  //fill(0);
  //  //text("Clue Log", 940, 760);

  //  //guess who
  //}


  ////cluelog
  //if (soln<=-1)
  //{
    
    
  //  if (diaryClue==400)
  //  {
  //    background(0);
  //    tint(255, 255);
  //    image(diary, width/4-40, 0);
     
  //  } else  if (newsClue==400)
  //  {
  //    println("im news");
  //    background(0);
  //    tint(255, 255);
  //    image(news, width/4-40, 0);
    
  //  } else if (lockClue==400)
  //  {
      
  //    println("im lock");
  //    background(0);
  //    tint(255, 255);
  //    //CHANGE DOCS
  //    image(docs, width/4-40, 0);
  
  //  }
  

  //  if (soln<=-2)
  //  {
  //    fill(152, 251, 152);
  //    rect(1300, 860, 130, 40, 30);
  //    fill(0);
  //    text("Next", 1330, 890);
  //  }
    
    
  //}

  //hints
  if (soln==911)
  {
  }


  //diary
  if (diaryClue==1)
  {
    background(0);
    imageMode(CENTER);
    image(ev1,width/2,height/2);
    imageMode(CORNER);
    fill(152, 251, 152);
    rect(1300, 860, 130, 40, 30);
    fill(0);
    text("Start!", 1320, 890);
  }

  //diarysolve
  if (proceedClue==1)
  {

    if (page==1)
    {

      background(0);
      page++;
      
      textSize(28);
      fill(253, 208, 23);
      text("Rub your finger \n  across diary page",20,50);
    }

    if (page>=2)
    {
      textSize(28);
      //fill(253, 208, 23);
      //text("Rub your finger \n  across diary page",20,50);
      diary.resize(1545/2, 2000/2);
      alpha=constrain(alpha,0,255);
      tint(255, alpha);
      image(diary, width/4-40, 0);  // Display at full opacity
    }

    if (alpha>1)
    {
      //textSize(28);
      //fill(253, 208, 23);
      //text("Rub your finger \n  across diary page",20,50);
      fill(152, 251, 152);
      rect(1300, 860, 130, 40, 30);
      fill(0);
      text("Proceed", 1315, 890);
    }
  }

  //news
  if (newsClue==1)
  {
    background(0);
    fill(253, 208, 23);
    tint(255);
    news.resize(1080-300, 1080-300);
    image(news, 100, 70);
    textSize(39);
    text("This was found near\n the murder scene", width-450, height/2-20);
    fill(152, 251, 152);
    rect(width-375, 700, 170, 50, 30);
    fill(0);
    textSize(35);
    text("Proceed!", width-355, 740);
  }
  //kid clue
  if (kidClue==1)
  {
    background(0);
    imageMode(CENTER);
    image(speak,width/2,height/2);
    imageMode(CORNER);
   fill(152, 251, 152);
    rect(1300, 860, 130, 40, 30);
    fill(0);
    textSize(28);
    text("Proceed", 1315, 890);
  }

  //interview
  if (interview==1)
  {
    background(0);
    fill(253, 208, 23);
    tint(255);
    image(kid, 100, 70);
    fill(152, 251, 152);
    rect(1300, 860, 130, 40, 30);
    fill(0);
    textSize(28);
    text("Proceed", 1315, 890);
  
  }


  //lock
  if (lockClue==1 && passLock!=1)
  {
    background(0);
    imageMode(CENTER);
    image(access,width/2,height/2);
    imageMode(CORNER);
    textSize(32);
    fill(152, 251, 152);
    rect(width/2-60, 800, 130, 60, 30);
    fill(0);
    textSize(35);
    text("Press", width/2-40, 840);
  }


  //DOCS
  if(passLock==1)
  {
    
    imageMode(CENTER);
    background(0);
    fill(253, 208, 23);
    tint(255);
    docs.resize(1545/3, 2000/3);
    image(docs, width/2,height/2);
    fill(152, 251, 152);
    rect(width-width/8, 800, 170, 50, 30);
    fill(0);
    textSize(32);
    text("Proceed!", width-width/8+25, 840);
  
  }



  //all done
}







void pass()
{
  background(0);
  image(docs, 0, 0);
}
void serialEvent(Serial myPort) {

  try
  {
    String s=myPort.readStringUntil('\n');

    s=trim(s);
    println(s);

    if (s!=null) {


      int values[]=int(split(s, ','));


      if (values.length==11) {
        int val = values[10];
        slide = values[9];
        if(val ==1)
          beep.play();   
         

        if (values[0]==1 && values[1]==0)
        {
          
          if(legend==-2 || legend==-1) aboutOver=1;
          if(killerTrigger==2) 
          {
            guess = values[9];
            killerTrigger =3;
          }
          else if(killerTrigger==3) killerTrigger=4;
          if(killerTrigger==1) 
          {
            killerTrigger=2;
            background(0);
          }
          else if (clueLog==4)
          {          
            killerTrigger=2;
            clueLog=-1;
            background(0);
          }
          else if (clueLog>=1)
          {          
            clueLog++;
          }
          if (legend==2) legend=45;
          else if(legend==45) legend=3;
          else
          if (legend<16) legend++;
         
          //else if (legend==16)
          //{
          //  legend++;
          //  soln=0;
          //  solve();
          //} 
         
          

          if (diaryClue==1)
          {

            proceedClue=1;
            diaryClue=0;
            soln=101;
          } else if (proceedClue==1)
          {

           // soln=0;
            diaryClue=400;
            proceedClue=0;
            legend=18;
          }
           if (kidClue==1)
          {

            interview=1;
            kidClue=0;
            soln=101;
          } else if (interview==1)
          {

            soln=0;
            kidClue=400;
            interview=0;
            legend=21;
          }
          if (newsClue==1)
          {
            soln=0;
            newsClue=400;
          }
          if (lockClue==1 )
          {

            password++;
            if (password==5)
            {
              println("me here");
              passLock=1;
              lockClue=0;
              soln=101;
            }
          } else if (passLock==1)
          {
            soln=0;
            lockClue=400;
            passLock=0;
            legend=22;
          }
          
        }
        if (values[5]==1 && legend==16 && proceedClue!=1 && diaryClue!=400 && diaryClue!=500)
        {
          diaryClue=1;
          solve();
          soln=-1;
          legend=17;
        }

        if (values[6]==0 && legend==18 && newsClue!=400 && newsClue!=500)
        {
          newsClue=1;
          legend=19;
        }

        if (values[7]==0 && legend==21 && lockClue!=400 && passLock!=1 && lockClue!=500)
        {
          lockClue=1;
          legend=21;
        }
        
        //KID!!
        if (values[8]==0 && legend==19 && kidClue!=400 && interview!=1 && kidClue!=500)
        {
          kidClue=1;
          legend=20;
        }
        
        


        if (values[2]==1 && values[3]==0)
        {
           if (legend==4) legend=0;
           if (legend==15) legend++;
          else if (legend<16) legend--;
          if (killerTrigger==2)
          {          
            clueLog = 1;
          }
        
          else if (clueLog>1)
          {          
            clueLog--;
          }
          else if (soln>=0)
          {
            soln=911;
          } else if (soln<-1)
          {
            soln++;
          } else if (proceedClue==1) diaryClue=1;
          
          //else
          //{
          //  if (legend>=9)
          //  {
          //    clueLog=0;
          //    table=1;
          //  } else
          //    legend--;
          //}
        }

        if (values[4]>4)
        {
          dcount++;
          if (dcount%100==0)
            alpha+=1;
        }
      }
    }


    myPort.write(int(introOver)+"\n");
    
  }
  catch(RuntimeException e) {
    e.printStackTrace();
  }
}

void chooseKiller(){
  println("here");
  if(killerTrigger==-1) 
  {
    background(0);
    fill(253, 208, 23);
    textSize(48);
    text("                  Congratulations, you've found all the clues. \n                        Choose the murderer, detective!", 20, height/2-40);
    fill(152, 251, 152);
    rect(width/2-70, 700, 200, 70, 30);
    fill(0);
    text("Choose!", width/2-60, 750);
    killerTrigger = 1;
  }
  if(killerTrigger==2)
  {
    fill(0);
    background(0);
    textSize(38);
    PImage img = loadImage("Choose murderer - "+slide+".png");
    img.resize(1366+50,768+50);
    imageMode(CENTER);
    image(img, width/2, height/2);
    fill(152, 251, 152);
    rect(width/2+100, 60, 200, 70, 30);
    fill(0);
    text("Choose!", width/2+130, 110);
    //killerTrigger = 1;
    fill(255,127, 127);
    rect(width/2-195, 60, 200, 70, 30);
    fill(0);
    text("Clue Log", width/2-170, 110);
    
  }

  if(killerTrigger==3)
  {
    if(guess == 6)
   {
    
    background(0);
    fill(#FFDD17);
    textSize(80);
    textAlign(CENTER);
    theme.pause();
    if(playO==0)
    {
      win.play();
      playO=1;
    }
    text("Well Done!!", width/2, height/2);
    fill(255);
    textSize(42);
    text("Enakshi can sense that you have found the right killer...", width/2, height/2 + 80);
    text("Now you can relax,\nShe is going to go and take care of it. There will be no need for arrests.", width/2, height/2 + 110);  
    fill(152, 251, 152);
    rect(width/2-100, height/2+300, 200, 70, 30);
    fill(0);
    text("Exit!", width/2-10, height/2+350);  
 }
     else
    {
     
    //background(5);
    //movie1.loop();
    //image(movie1, 100, 0);
       background(0);
   
    if(frameC<700)
    {
    textAlign(CENTER);
    
    println("frame:");
    println(frame);
    fill(#FFDD17);
    textSize(80);
    text("Uh oh", width/2, height/2);
    fill(255);
    textSize(30);
    text("Seems like Enakshi senses that this is the wrong answer..", width/2, height/2 + 80);
    text("Enakshi doesn't like that... She has waited long enough. Now she's going to take care of everyone.", width/2, height/2 + 110);
    } 
  // }
    //for (int i = 0; i<500; i++) {
    //if (frameCount - frame >= 5200 && frameCount - frame < 5800){
     if(frameC>=500 && frameC<600)
     {
        theme.pause();
   //  println("frame:");
   if(frameC==500)
    lose.play();
      background(0);
    image(eyes, width/2, height/4);
    fill(#FFDD17);
    textSize(80);
    text("Starting with you...", width/2, height/2);
    
    }
    if(frameC>=800){
      background(0);
     
     exit();
      
    }
    else
    if(frameC>=600){
      background(0);
     
      stat.loop();
      image(stat, width/2, height/2);
      
    }
    
    frameC++;
    println(frameC);
      
    }
  }
  
  if(killerTrigger==4)
  {
    exit();
  }
}
