import org.opencv.core.Scalar;
import processing.core.PApplet;
import processing.core.PImage;

/**
 * Per-digit ground-truth colors, calibration capture, and classification (unchanged tolerance logic).
 */
public class DigitColorModel {

  private static final float MATCH_TOLERANCE = 50f;

  private Scalar zeroTruth = new Scalar(0, 0, 0, 0);
  private Scalar oneTruth = new Scalar(0, 0, 0, 0);
  private Scalar twoTruth = new Scalar(0, 0, 0, 0);
  private Scalar threeTruth = new Scalar(0, 0, 0, 0);
  private Scalar fourTruth = new Scalar(0, 0, 0, 0);
  private Scalar fiveTruth = new Scalar(0, 0, 0, 0);
  private Scalar sixTruth = new Scalar(0, 0, 0, 0);
  private Scalar sevenTruth = new Scalar(0, 0, 0, 0);
  private Scalar eightTruth = new Scalar(0, 0, 0, 0);
  private Scalar nineTruth = new Scalar(0, 0, 0, 0);

  PImage zeroTruthImg;
  PImage oneTruthImg;
  PImage twoTruthImg;
  PImage threeTruthImg;
  PImage fourTruthImg;
  PImage fiveTruthImg;
  PImage sixTruthImg;
  PImage sevenTruthImg;
  PImage eightTruthImg;
  PImage nineTruthImg;

  public boolean allDigitsCalibrated() {
    return zeroTruthImg != null && oneTruthImg != null && twoTruthImg != null && threeTruthImg != null
        && fourTruthImg != null && fiveTruthImg != null && sixTruthImg != null && sevenTruthImg != null
        && eightTruthImg != null && nineTruthImg != null;
  }

  public void calibrateGroundTruth(PApplet app, int digit, Scalar avgColour) {
    switch (digit) {
      case 0:
        zeroTruth = copyScalar(avgColour);
        app.save("GroundTruthImages/0_groundTruth.jpg");
        zeroTruthImg = app.loadImage("GroundTruthImages/0_groundTruth.jpg");
        break;
      case 1:
        oneTruth = copyScalar(avgColour);
        app.save("GroundTruthImages/1_groundTruth.jpg");
        oneTruthImg = app.loadImage("GroundTruthImages/1_groundTruth.jpg");
        break;
      case 2:
        twoTruth = copyScalar(avgColour);
        app.save("GroundTruthImages/2_groundTruth.jpg");
        twoTruthImg = app.loadImage("GroundTruthImages/2_groundTruth.jpg");
        break;
      case 3:
        threeTruth = copyScalar(avgColour);
        app.save("GroundTruthImages/3_groundTruth.jpg");
        threeTruthImg = app.loadImage("GroundTruthImages/3_groundTruth.jpg");
        break;
      case 4:
        fourTruth = copyScalar(avgColour);
        app.save("GroundTruthImages/4_groundTruth.jpg");
        fourTruthImg = app.loadImage("GroundTruthImages/4_groundTruth.jpg");
        break;
      case 5:
        fiveTruth = copyScalar(avgColour);
        app.save("GroundTruthImages/5_groundTruth.jpg");
        fiveTruthImg = app.loadImage("GroundTruthImages/5_groundTruth.jpg");
        break;
      case 6:
        sixTruth = copyScalar(avgColour);
        app.save("GroundTruthImages/6_groundTruth.jpg");
        sixTruthImg = app.loadImage("GroundTruthImages/6_groundTruth.jpg");
        break;
      case 7:
        sevenTruth = copyScalar(avgColour);
        app.save("GroundTruthImages/7_groundTruth.jpg");
        sevenTruthImg = app.loadImage("GroundTruthImages/7_groundTruth.jpg");
        break;
      case 8:
        eightTruth = copyScalar(avgColour);
        app.save("GroundTruthImages/8_groundTruth.jpg");
        eightTruthImg = app.loadImage("GroundTruthImages/8_groundTruth.jpg");
        break;
      case 9:
        nineTruth = copyScalar(avgColour);
        app.save("GroundTruthImages/9_groundTruth.jpg");
        nineTruthImg = app.loadImage("GroundTruthImages/9_groundTruth.jpg");
        break;
      default:
        break;
    }
  }

  public boolean matchesDigit(int digit, Scalar colour) {
    switch (digit) {
      case 0:
        return closeToColour(colour, zeroTruth);
      case 1:
        return closeToColour(colour, oneTruth);
      case 2:
        return closeToColour(colour, twoTruth);
      case 3:
        return closeToColour(colour, threeTruth);
      case 4:
        return closeToColour(colour, fourTruth);
      case 5:
        return closeToColour(colour, fiveTruth);
      case 6:
        return closeToColour(colour, sixTruth);
      case 7:
        return closeToColour(colour, sevenTruth);
      case 8:
        return closeToColour(colour, eightTruth);
      case 9:
        return closeToColour(colour, nineTruth);
      default:
        return false;
    }
  }

  public void drawCalibrationThumbnails(
      PApplet p,
      PImage allCalibratedUI,
      PImage notAllCalibratedUI) {
    p.noFill();
    p.rect(50, 25, 25, 25);
    if (zeroTruthImg != null) {
      p.image(zeroTruthImg.get(301, 301, 1, 1), 50, 25, 25, 25);
    }
    p.rect(100, 25, 25, 25);
    if (oneTruthImg != null) {
      p.image(oneTruthImg.get(301, 301, 1, 1), 100, 25, 25, 25);
    }
    p.rect(150, 25, 25, 25);
    if (twoTruthImg != null) {
      p.image(twoTruthImg.get(301, 301, 1, 1), 150, 25, 25, 25);
    }
    p.rect(200, 25, 25, 25);
    if (threeTruthImg != null) {
      p.image(threeTruthImg.get(301, 301, 1, 1), 200, 25, 25, 25);
    }
    p.rect(250, 25, 25, 25);
    if (fourTruthImg != null) {
      p.image(fourTruthImg.get(301, 301, 1, 1), 250, 25, 25, 25);
    }
    p.rect(300, 25, 25, 25);
    if (fiveTruthImg != null) {
      p.image(fiveTruthImg.get(301, 301, 1, 1), 300, 25, 25, 25);
    }
    p.rect(350, 25, 25, 25);
    if (sixTruthImg != null) {
      p.image(sixTruthImg.get(301, 301, 1, 1), 350, 25, 25, 25);
    }
    p.rect(400, 25, 25, 25);
    if (sevenTruthImg != null) {
      p.image(sevenTruthImg.get(301, 301, 1, 1), 400, 25, 25, 25);
    }
    p.rect(450, 25, 25, 25);
    if (eightTruthImg != null) {
      p.image(eightTruthImg.get(301, 301, 1, 1), 450, 25, 25, 25);
    }
    p.rect(500, 25, 25, 25);
    if (nineTruthImg != null) {
      p.image(nineTruthImg.get(301, 301, 1, 1), 500, 25, 25, 25);
    }
    p.rect(550, 25, 25, 25);
    if (allDigitsCalibrated()) {
      p.image(allCalibratedUI, 550, 25, 25, 25);
    } else {
      p.image(notAllCalibratedUI, 550, 25, 25, 25);
    }
  }

  public void drawCalibrationValueLabels(PApplet p, Scalar avgColour) {
    p.text("Values [Cur]: " + (int) avgColour.val[0] + " " + (int) avgColour.val[1] + " " + (int) avgColour.val[2] + " " + (int) avgColour.val[3], 20, 75);
    p.text("Values [0]: " + (int) zeroTruth.val[0] + " " + (int) zeroTruth.val[1] + " " + (int) zeroTruth.val[2] + " " + (int) zeroTruth.val[3], 20, 100);
    p.text("Values [1]: " + (int) oneTruth.val[0] + " " + (int) oneTruth.val[1] + " " + (int) oneTruth.val[2] + " " + (int) oneTruth.val[3], 20, 125);
    p.text("Values [2]: " + (int) twoTruth.val[0] + " " + (int) twoTruth.val[1] + " " + (int) twoTruth.val[2] + " " + (int) twoTruth.val[3], 20, 150);
    p.text("Values [3]: " + (int) threeTruth.val[0] + " " + (int) threeTruth.val[1] + " " + (int) threeTruth.val[2] + " " + (int) threeTruth.val[3], 20, 175);
    p.text("Values [4]: " + (int) fourTruth.val[0] + " " + (int) fourTruth.val[1] + " " + (int) fourTruth.val[2] + " " + (int) fourTruth.val[3], 20, 200);
    p.text("Values [5]: " + (int) fiveTruth.val[0] + " " + (int) fiveTruth.val[1] + " " + (int) fiveTruth.val[2] + " " + (int) fiveTruth.val[3], 20, 225);
    p.text("Values [6]: " + (int) sixTruth.val[0] + " " + (int) sixTruth.val[1] + " " + (int) sixTruth.val[2] + " " + (int) sixTruth.val[3], 20, 250);
    p.text("Values [7]: " + (int) sevenTruth.val[0] + " " + (int) sevenTruth.val[1] + " " + (int) sevenTruth.val[2] + " " + (int) sevenTruth.val[3], 20, 275);
    p.text("Values [8]: " + (int) eightTruth.val[0] + " " + (int) eightTruth.val[1] + " " + (int) eightTruth.val[2] + " " + (int) eightTruth.val[3], 20, 300);
    p.text("Values [9]: " + (int) nineTruth.val[0] + " " + (int) nineTruth.val[1] + " " + (int) nineTruth.val[2] + " " + (int) nineTruth.val[3], 20, 325);
  }

  private static Scalar copyScalar(Scalar s) {
    return new Scalar(s.val[0], s.val[1], s.val[2], s.val[3]);
  }

  private static boolean closeToColour(Scalar colour, Scalar groundTruth) {
    Scalar subtractedColour = subtractTwoScalars(groundTruth, colour);
    Scalar absOfSubtractedColour = absOfScalar(subtractedColour);
    float lengthOfSubtractedColour = lengthOfScalar(absOfSubtractedColour);
    return lengthOfSubtractedColour < MATCH_TOLERANCE;
  }

  private static Scalar subtractTwoScalars(Scalar a, Scalar b) {
    return new Scalar(a.val[0] - b.val[0], a.val[1] - b.val[1], a.val[2] - b.val[2], a.val[3] - b.val[3]);
  }

  private static Scalar absOfScalar(Scalar s) {
    return new Scalar(Math.abs((float) s.val[0]), Math.abs((float) s.val[1]), Math.abs((float) s.val[2]), Math.abs((float) s.val[3]));
  }

  private static float lengthOfScalar(Scalar s) {
    return (float) (s.val[0] + s.val[1] + s.val[2] + s.val[3]);
  }
}
