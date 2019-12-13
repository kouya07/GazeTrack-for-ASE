import gazetrack.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

GazeTrack gazeTrack;
DateTimeFormatter dtf;
LocalDateTime ldt;

float slide = 0;
String localStr;

PrintWriter file;

void setup(){
  fullScreen();
  
  // Gaze cursor param.
  noFill();
  stroke(50, 100);
  strokeWeight(4);
  
  gazeTrack = new GazeTrack(this);
  
  // If the TobiiStream.exe asked you to use a 
  // different socket port (e.g., 5656), use this instead:
  // gazeTrack = new GazeTrack(this, "5656");
  
  ldt = LocalDateTime.now();
  dtf = DateTimeFormatter.ofPattern("yyyy_MM_dd_HH_mm");
  localStr = dtf.format(ldt);
  
  file = createWriter("Data" + "/" + localStr + ".csv");
  file.println("Data,GazeX,GazeY,Zone");
  
  dtf = DateTimeFormatter.ofPattern("yyyy_MM_dd HH:mm:ss.SSS");
  localStr = dtf.format(ldt);
  
  //float slide = 526.26; // forleft hand
  slide = -526.26; // for right hand
}

void draw(){
  background(255);
  //line(width/2, 0, width/2, height);
  
  //line(526.26, -height, 526.26, height); //for left hand
  //line(-526.26 + width/2, 0, -526.26 + width/2, height); //for right hand
  
  //rect(168, 212, 2400, 1400);
  //line(568, 212, 568, 1612);
  
  ldt = LocalDateTime.now();
  localStr = dtf.format(ldt);
  
  if (gazeTrack.gazePresent()){
    float GazeX = gazeTrack.getGazeX() + slide;
   
    //ellipse(GazeX, gazeTrack.getGazeY(), 100, 100);
    
    GazeX = GazeX/2;
    float GazeY = gazeTrack.getGazeY()/2;
    
    println("Time: " + localStr + " " + "GazeX: " + GazeX + " GazeY: " + GazeY);

    file.print(localStr + "," + GazeX + "," + GazeY);
    
    // for Surface Pro 4
    if(84 <= GazeX && GazeX <= 284 && 106 <= GazeY && GazeY <= 806){
      file.println(",A");
    } else if(284 <= GazeX && GazeX <= 1284 && 106 <= GazeY && GazeY <= 806){
      file.println(",B");
    } else {
      file.println();
    }
    
  } else {
    file.println(localStr + ",Not Present");
  }
  
  if(int(key) == 10){
    file.flush();
    file.close();
    exit();
  }
  
}
