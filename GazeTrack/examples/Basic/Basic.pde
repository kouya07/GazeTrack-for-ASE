import gazetrack.*;

GazeTrack gazeTrack;

float slide = 0;
  
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
  
  file = createWriter("test.csv");
  
  //float slide = 526.26; // left hand
  slide = -526.26; // right hand
}

void draw(){
  background(255);
  //line(0, height/2, width, height/2);
  line(width/2, 0, width/2, height);
  
  line(-526.26 + width/2, 0, -526.26 + width/2, height);
  //line(526.26, -height, 526.26, height);
  
  if (gazeTrack.gazePresent()){
    float gazeX = gazeTrack.getGazeX() + slide;
   
    ellipse(gazeX, gazeTrack.getGazeY(), 100, 100);
    
    // Print the tracker's timestamp for the gaze cursor above
    println("Latest gaze data at: " + gazeTrack.getTimestamp() + " " + "Time: " + year() + "/" + month() + "/" + day() + " " + hour() + ":" + minute() + ":" + second() + "." + millis() + " " 
            + "GazeX: " + gazeX/2 + " GazeY: " + gazeTrack.getGazeY()/2);

    file.print(year() + "/" + month() + "/" + day() + " " + hour() + ":" + minute() + ":" + second() + "." + millis());
    file.print(",");
    file.print(gazeX / 2);
    file.print(",");
    file.print(gazeTrack.getGazeY() / 2);
    
    if(84 <= gazeX/2 && gazeX/2 <= 284 && 106 <= gazeTrack.getGazeY()/2 && gazeTrack.getGazeY()/2 <= 806){
      file.print(",");
      file.println("A");
    } else if(284 <= gazeX/2 && gazeX/2 <= 1284 && 106 <= gazeTrack.getGazeY()/2 && gazeTrack.getGazeY()/2 <= 806){
      file.print(",");
      file.println("B");
    } else {
      file.println();
    }
    
  }
  
  if(int(key) == 10){
    file.flush();
    file.close();
    exit();
  }
    
}
