import gab.opencv.*;
import org.opencv.core.Core;
import org.opencv.core.Scalar;
import org.opencv.core.Mat;
import processing.video.*;
import java.awt.*;

Capture video;
OpenCV opencv;
Scalar avgColour;
PImage zeroTruthImg, oneTruthImg, twoTruthImg, threeTruthImg, fourTruthImg, fiveTruthImg, sixTruthImg, sevenTruthImg, eightTruthImg, nineTruthImg;
PImage allCalibratedUI, notAllCalibratedUI;
Scalar zeroTruth  = new Scalar(0, 0, 0, 0);
Scalar oneTruth  = new Scalar(0, 0, 0, 0); 
Scalar twoTruth  = new Scalar(0, 0, 0, 0); 
Scalar threeTruth  = new Scalar(0, 0, 0, 0); 
Scalar fourTruth  = new Scalar(0, 0, 0, 0);
Scalar fiveTruth  = new Scalar(0, 0, 0, 0);
Scalar sixTruth  = new Scalar(0, 0, 0, 0);
Scalar sevenTruth = new Scalar(0, 0, 0, 0);
Scalar eightTruth = new Scalar(0, 0, 0, 0);
Scalar nineTruth = new Scalar(0, 0, 0, 0);

Boolean showCalibration = false;
PImage zebraUI1, zebraUI2, zebraUI3, zebraUI4;
int curLevel;

void setup() {
  zebraUI1 = loadImage("GUI/zahlenzebra.png");
  zebraUI2 = loadImage("GUI/zahlenzebra2.png");
  zebraUI3 = loadImage("GUI/zahlenzebra3.png");
  zebraUI4 = loadImage("GUI/zahlenzebra4.png");
  allCalibratedUI = loadImage("GUI/haekchen.jpg");
  notAllCalibratedUI = loadImage("GUI/x.jpg");
  size(640, 480);
  video = new Capture(this, 640, 480);
  opencv = new OpenCV(this, 640, 480);
  video.start();
  curLevel = 1;
}

void draw() { 
  opencv.loadImage(video);
  opencv.setROI(300, 300, 2, 2);
  image(opencv.getInput(), 0, 0);
  fill(255, 0, 0);
  rect(300, 300, 2, 2);
  fill(255, 255, 255);

  if (!showCalibration) {
    fill(255, 255, 255);
    textSize(16);
    if (curLevel == 1) {
      image(zebraUI1, 0, 0);
      text("Level 1", 25, 30);
      text("2*2-6:2 = ?", 250, 90);  //1
    }
    if (curLevel == 2) {
      image(zebraUI1, 0, 0);
      text("Level 2", 25, 30);
      text("4+2-(2-4) = ?", 250, 90);  //8
    }
    if (curLevel == 3) {
      image(zebraUI1, 0, 0);
      text("Level 3", 25, 30);
      text("9:3+6*(1:2) = ?", 250, 90);  //6
    }
    if (curLevel == 4) {
      image(zebraUI2, 0, 0);
      text("Level 4", 25, 30);
      text("32:2:2:2 = ?", 250, 90);  //4
    }
    if (curLevel == 5) {
      image(zebraUI2, 0, 0);
      text("Level 5", 25, 30);
      text("1+3*2+2 = ?", 250, 90);  //9
    }
    if (curLevel == 6) {
      image(zebraUI2, 0, 0);
      text("Level 6", 25, 30);
      text("100:10-4-3-2-1 = ?", 250, 90);  //0
    }
    if (curLevel == 7) {
      image(zebraUI3, 0, 0);
      text("Level 7", 25, 30);
      text("0.5*8*0.5 = ?", 250, 90);  //2
    }
    if (curLevel == 8) {
      image(zebraUI3, 0, 0);
      text("Level 8", 25, 30);
      text("162:54 = ?", 250, 90);  //3
    }
    if (curLevel == 9) {
      image(zebraUI4, 0, 0);
      text("Level 9", 25, 30);
      text("9*7-7*7-9 = ?", 250, 90);  //5
    }
    if (curLevel == 10) {
      image(zebraUI4, 0, 0);
      text("Level 10", 25, 30);
      text("(5*6-20:4):5+2 = ?", 250, 90);  //7
    }
  }  

  if (showCalibration) {
    noFill();
    rect(50, 25, 25, 25);
    if (zeroTruthImg != null) image(zeroTruthImg.get(301, 301, 1, 1), 50, 25, 25, 25);
    rect(100, 25, 25, 25);
    if (oneTruthImg != null) image(oneTruthImg.get(301, 301, 1, 1), 100, 25, 25, 25);
    rect(150, 25, 25, 25);
    if (twoTruthImg != null) image(twoTruthImg.get(301, 301, 1, 1), 150, 25, 25, 25);
    rect(200, 25, 25, 25);
    if (threeTruthImg != null) image(threeTruthImg.get(301, 301, 1, 1), 200, 25, 25, 25);
    rect(250, 25, 25, 25);
    if (fourTruthImg != null) image(fourTruthImg.get(301, 301, 1, 1), 250, 25, 25, 25);
    rect(300, 25, 25, 25);
    if (fiveTruthImg != null) image(fiveTruthImg.get(301, 301, 1, 1), 300, 25, 25, 25);
    rect(350, 25, 25, 25);
    if (sixTruthImg != null) image(sixTruthImg.get(301, 301, 1, 1), 350, 25, 25, 25);
    rect(400, 25, 25, 25);
    if (sevenTruthImg != null) image(sevenTruthImg.get(301, 301, 1, 1), 400, 25, 25, 25);
    rect(450, 25, 25, 25);
    if (eightTruthImg != null) image(eightTruthImg.get(301, 301, 1, 1), 450, 25, 25, 25);
    rect(500, 25, 25, 25);
    if (nineTruthImg != null) image(nineTruthImg.get(301, 301, 1, 1), 500, 25, 25, 25);
    rect(550, 25, 25, 25);
    if (zeroTruthImg != null && oneTruthImg != null && twoTruthImg != null && threeTruthImg != null && fourTruthImg != null
      && fiveTruthImg != null  && sixTruthImg != null  && sevenTruthImg != null  && eightTruthImg != null  && nineTruthImg != null) {
      image(allCalibratedUI, 550, 25, 25, 25);
    } else {
      image(notAllCalibratedUI, 550, 25, 25, 25);
    }
    stroke(255, 255, 255);
  } else {
    stroke(255, 0, 0);
    noFill();
  }

  opencv.setROI(300, 300, 2, 2);
  Mat rgb = opencv.getColor();
  Mat subRGB = rgb.submat(300, 302, 300, 302);
  Scalar colourSum = Core.sumElems(subRGB);
  float factor = 1.0/(2.0*2.0);
  Scalar divisor = new Scalar(factor, factor, factor, factor);
  avgColour = colourSum.mul(divisor);

  if (showCalibration) {
    text("Values [Cur]: "+(int)avgColour.val[0]+" "+(int)avgColour.val[1]+" "+(int)avgColour.val[2]+" "+(int)avgColour.val[3], 20, 75);  
    text("Values [0]: "+(int)zeroTruth.val[0]+" "+(int)zeroTruth.val[1]+" "+(int)zeroTruth.val[2]+" "+(int)zeroTruth.val[3], 20, 100);
    text("Values [1]: "+(int)oneTruth.val[0]+" "+(int)oneTruth.val[1]+" "+(int)oneTruth.val[2]+" "+(int)oneTruth.val[3], 20, 125);
    text("Values [2]: "+(int)twoTruth.val[0]+" "+(int)twoTruth.val[1]+" "+(int)twoTruth.val[2]+" "+(int)twoTruth.val[3], 20, 150);
    text("Values [3]: "+(int)threeTruth.val[0]+" "+(int)threeTruth.val[1]+" "+(int)threeTruth.val[2]+" "+(int)threeTruth.val[3], 20, 175);
    text("Values [4]: "+(int)fourTruth.val[0]+" "+(int)fourTruth.val[1]+" "+(int)fourTruth.val[2]+" "+(int)fourTruth.val[3], 20, 200);
    text("Values [5]: "+(int)fiveTruth.val[0]+" "+(int)fiveTruth.val[1]+" "+(int)fiveTruth.val[2]+" "+(int)fiveTruth.val[3], 20, 225);
    text("Values [6]: "+(int)sixTruth.val[0]+" "+(int)sixTruth.val[1]+" "+(int)sixTruth.val[2]+" "+(int)sixTruth.val[3], 20, 250);
    text("Values [7]: "+(int)sevenTruth.val[0]+" "+(int)sevenTruth.val[1]+" "+(int)sevenTruth.val[2]+" "+(int)sevenTruth.val[3], 20, 275);
    text("Values [8]: "+(int)eightTruth.val[0]+" "+(int)eightTruth.val[1]+" "+(int)eightTruth.val[2]+" "+(int)eightTruth.val[3], 20, 300);
    text("Values [9]: "+(int)nineTruth.val[0]+" "+(int)nineTruth.val[1]+" "+(int)nineTruth.val[2]+" "+(int)nineTruth.val[3], 20, 325);
  }

  if (zero(avgColour)) text("0", 315, 455); 
  else if (one(avgColour)) text("1", 315, 455); 
  else if (two(avgColour)) text("2", 315, 455); 
  else if (three(avgColour)) text("3", 315, 455);
  else if (four(avgColour)) text("4", 315, 455);
  else if (five(avgColour)) text("5", 315, 455);
  else if (six(avgColour)) text("6", 315, 455);
  else if (seven(avgColour)) text("7", 315, 455);
  else if (eight(avgColour)) text("8", 315, 455);
  else if (nine(avgColour)) text("9", 315, 455);

  if (!showCalibration) {
    textSize(12);
    text("c = calibration", 10, 470);
    text("enter = confirm number", 485, 470);
  }
}

void captureEvent(Capture c) {
  c.read();
}

Scalar subtractTwoScalars(Scalar a, Scalar b) {
  Scalar result;
  result = new Scalar(a.val[0]-b.val[0], a.val[1]-b.val[1], a.val[2]-b.val[2], a.val[3]-b.val[3]);
  return result;
}

Scalar absOfScalar(Scalar s) {
  Scalar result;
  result = new Scalar(abs((float)s.val[0]), abs((float)s.val[1]), abs((float)s.val[2]), abs((float)s.val[3]));
  return result;
}

float lengthOfScalar(Scalar s) {
  float result;
  result = (float)(s.val[0] + s.val[1] + s.val[2] + s.val[3]);
  return result;
}

boolean closeToColour(Scalar colour, Scalar groundTruth) {  
  Scalar subtractedColour = subtractTwoScalars(groundTruth, colour);
  Scalar absOfSubtractedColour = absOfScalar(subtractedColour);
  float lengthOfSubtractedColour = lengthOfScalar(absOfSubtractedColour);
  if (lengthOfSubtractedColour < 50) return true;
  return false;
}

boolean zero(Scalar colour) {
  Scalar zero = zeroTruth;
  return closeToColour(colour, zero);
}

boolean one(Scalar colour) {
  Scalar one = oneTruth;
  return closeToColour(colour, one);
}

boolean two(Scalar colour) {
  Scalar two = twoTruth;
  return closeToColour(colour, two);
}

boolean three(Scalar colour) {
  Scalar three = threeTruth;
  return closeToColour(colour, three);
}

boolean four(Scalar colour) {
  Scalar four = fourTruth;
  return closeToColour(colour, four);
}

boolean five(Scalar colour) {
  Scalar five = fiveTruth;
  return closeToColour(colour, five);
}

boolean six(Scalar colour) {
  Scalar six = sixTruth;
  return closeToColour(colour, six);
}

boolean seven(Scalar colour) {
  Scalar seven = sevenTruth;
  return closeToColour(colour, seven);
}

boolean eight(Scalar colour) {
  Scalar eight = eightTruth;
  return closeToColour(colour, eight);
}

boolean nine(Scalar colour) {
  Scalar nine = nineTruth;
  return closeToColour(colour, nine);
}

void keyPressed() {
  if (keyCode == '0' && showCalibration) calibrateGroundTruth(0);
  if (keyCode == '1' && showCalibration) calibrateGroundTruth(1);
  if (keyCode == '2' && showCalibration) calibrateGroundTruth(2);
  if (keyCode == '3' && showCalibration) calibrateGroundTruth(3);
  if (keyCode == '4' && showCalibration) calibrateGroundTruth(4);
  if (keyCode == '5' && showCalibration) calibrateGroundTruth(5);
  if (keyCode == '6' && showCalibration) calibrateGroundTruth(6);
  if (keyCode == '7' && showCalibration) calibrateGroundTruth(7);
  if (keyCode == '8' && showCalibration) calibrateGroundTruth(8);
  if (keyCode == '9' && showCalibration) calibrateGroundTruth(9);
  if (keyCode == 'C') showCalibration = !showCalibration; 

  //LEVEL 1 / ANSWER  = 1
  if (curLevel == 1) {
    if (keyCode == ENTER  && one(avgColour)) {
      curLevel = 2;
      println(curLevel);
    }
  }

  //LEVEL 2 / ANSWER  = 8
  if (curLevel == 2) {
    if (keyCode == ENTER  && eight(avgColour)) {
      curLevel = 3;
      println(curLevel);
    }
  }

  //LEVEL 3 / ANSWER  = 6
  if (curLevel == 3) {
    if (keyCode == ENTER  && six(avgColour)) {
      curLevel = 4;
      println(curLevel);
    }
  }

  //LEVEL 4 / ANSWER  = 4
  if (curLevel == 4) {
    if (keyCode == ENTER  && four(avgColour)) {
      curLevel = 5;
      println(curLevel);
    }
  }

  //LEVEL 5 / ANSWER  = 9
  if (curLevel == 5) {
    if (keyCode == ENTER  && nine(avgColour)) {
      curLevel = 6;
      println(curLevel);
    }
  }

  //LEVEL 6 / ANSWER  = 0
  if (curLevel == 6) {
    if (keyCode == ENTER  && zero(avgColour)) {
      curLevel = 7;
      println(curLevel);
    }
  }

  //LEVEL 7 / ANSWER  = 2
  if (curLevel == 7) {
    if (keyCode == ENTER  && two(avgColour)) {
      curLevel = 8;
      println(curLevel);
    }
  }

  //LEVEL 8 / ANSWER  = 3
  if (curLevel == 8) {
    if (keyCode == ENTER  && three(avgColour)) {
      curLevel = 9;
      println(curLevel);
    }
  }

  //LEVEL 9 / ANSWER  = 5
  if (curLevel == 9) {
    if (keyCode == ENTER  && five(avgColour)) {
      curLevel = 10;
      println(curLevel);
    }
  }

  //LEVEL 10 / ANSWER  = 7
  if (curLevel == 10) {
    if (keyCode == ENTER  && seven(avgColour)) {
      curLevel = 1;
      println(curLevel);
    }
  }

  if (keyCode == 'L') {
    curLevel = curLevel + 1;
    if (curLevel > 10) curLevel = 1;
  }
}

void calibrateGroundTruth(int digit) {
  if (digit == 0) {
    zeroTruth = new Scalar(avgColour.val[0], avgColour.val[1], avgColour.val[2], avgColour.val[3]);
    save("GroundTruthImages/0_groundTruth.jpg");
    zeroTruthImg = loadImage("GroundTruthImages/0_groundTruth.jpg");
  } else if (digit == 1) {

    oneTruth = new Scalar(avgColour.val[0], avgColour.val[1], avgColour.val[2], avgColour.val[3]);
    //println(oneTruth.val[0], oneTruth.val[1], oneTruth.val[2], oneTruth.val[3]);
    save("GroundTruthImages/1_groundTruth.jpg");
    oneTruthImg = loadImage("GroundTruthImages/1_groundTruth.jpg");
  } else if (digit == 2) {

    twoTruth = new Scalar(avgColour.val[0], avgColour.val[1], avgColour.val[2], avgColour.val[3]);
    //println(twoTruth.val[0], twoTruth.val[1], twoTruth.val[2], twoTruth.val[3]);
    save("GroundTruthImages/2_groundTruth.jpg");
    twoTruthImg = loadImage("GroundTruthImages/2_groundTruth.jpg");
  } else if (digit == 3) {

    threeTruth = new Scalar(avgColour.val[0], avgColour.val[1], avgColour.val[2], avgColour.val[3]);
    //println(threeTruth.val[0], threeTruth.val[1], threeTruth.val[2], threeTruth.val[3]);
    save("GroundTruthImages/3_groundTruth.jpg");
    threeTruthImg = loadImage("GroundTruthImages/3_groundTruth.jpg");
  } else if (digit == 4) {

    fourTruth = new Scalar(avgColour.val[0], avgColour.val[1], avgColour.val[2], avgColour.val[3]);
    //println(fourTruth.val[0], fourTruth.val[1], fourTruth.val[2], fourTruth.val[3]);
    save("GroundTruthImages/4_groundTruth.jpg");
    fourTruthImg = loadImage("GroundTruthImages/4_groundTruth.jpg");
  } else if (digit == 5) {

    fiveTruth = new Scalar(avgColour.val[0], avgColour.val[1], avgColour.val[2], avgColour.val[3]);
    //println(fiveTruth.val[0], fiveTruth.val[1], fiveTruth.val[2], fiveTruth.val[3]);
    save("GroundTruthImages/5_groundTruth.jpg");
    fiveTruthImg = loadImage("GroundTruthImages/5_groundTruth.jpg");
  } else if (digit == 6) {

    sixTruth = new Scalar(avgColour.val[0], avgColour.val[1], avgColour.val[2], avgColour.val[3]);
    //println(sixTruth.val[0], sixTruth.val[1], sixTruth.val[2], sixTruth.val[3]);
    save("GroundTruthImages/6_groundTruth.jpg");
    sixTruthImg = loadImage("GroundTruthImages/6_groundTruth.jpg");
  } else if (digit == 7) {

    sevenTruth = new Scalar(avgColour.val[0], avgColour.val[1], avgColour.val[2], avgColour.val[3]);
    //println(sevenTruth.val[0], sevenTruth.val[1], sevenTruth.val[2], sevenTruth.val[3]);
    save("GroundTruthImages/7_groundTruth.jpg");
    sevenTruthImg = loadImage("GroundTruthImages/7_groundTruth.jpg");
  } else if (digit == 8) {

    eightTruth = new Scalar(avgColour.val[0], avgColour.val[1], avgColour.val[2], avgColour.val[3]);
    //println(eightTruth.val[0], eightTruth.val[1], eightTruth.val[2], eightTruth.val[3]);
    save("GroundTruthImages/8_groundTruth.jpg");
    eightTruthImg = loadImage("GroundTruthImages/8_groundTruth.jpg");
  } else if (digit == 9) {

    nineTruth = new Scalar(avgColour.val[0], avgColour.val[1], avgColour.val[2], avgColour.val[3]);
    //println(nineTruth.val[0], nineTruth.val[1], nineTruth.val[2], nineTruth.val[3]);
    save("GroundTruthImages/9_groundTruth.jpg");
    nineTruthImg = loadImage("GroundTruthImages/9_groundTruth.jpg");
  }
}