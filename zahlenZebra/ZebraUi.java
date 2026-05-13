import org.opencv.core.Scalar;
import processing.core.PApplet;
import processing.core.PImage;

/** Level backgrounds and on-screen prompts (same layout as the original sketch). */
public class ZebraUi {

  PImage zebraUI1;
  PImage zebraUI2;
  PImage zebraUI3;
  PImage zebraUI4;
  PImage allCalibratedUI;
  PImage notAllCalibratedUI;

  public void loadAssets(PApplet p) {
    zebraUI1 = p.loadImage("GUI/zahlenzebra.png");
    zebraUI2 = p.loadImage("GUI/zahlenzebra2.png");
    zebraUI3 = p.loadImage("GUI/zahlenzebra3.png");
    zebraUI4 = p.loadImage("GUI/zahlenzebra4.png");
    allCalibratedUI = p.loadImage("GUI/haekchen.jpg");
    notAllCalibratedUI = p.loadImage("GUI/x.jpg");
  }

  public void drawLevel(PApplet p, int curLevel) {
    p.fill(255, 255, 255);
    p.textSize(16);
    if (curLevel == 1) {
      p.image(zebraUI1, 0, 0);
      p.text("Level 1", 25, 30);
      p.text("2*2-6:2 = ?", 250, 90);
    }
    if (curLevel == 2) {
      p.image(zebraUI1, 0, 0);
      p.text("Level 2", 25, 30);
      p.text("4+2-(2-4) = ?", 250, 90);
    }
    if (curLevel == 3) {
      p.image(zebraUI1, 0, 0);
      p.text("Level 3", 25, 30);
      p.text("9:3+6*(1:2) = ?", 250, 90);
    }
    if (curLevel == 4) {
      p.image(zebraUI2, 0, 0);
      p.text("Level 4", 25, 30);
      p.text("32:2:2:2 = ?", 250, 90);
    }
    if (curLevel == 5) {
      p.image(zebraUI2, 0, 0);
      p.text("Level 5", 25, 30);
      p.text("1+3*2+2 = ?", 250, 90);
    }
    if (curLevel == 6) {
      p.image(zebraUI2, 0, 0);
      p.text("Level 6", 25, 30);
      p.text("100:10-4-3-2-1 = ?", 250, 90);
    }
    if (curLevel == 7) {
      p.image(zebraUI3, 0, 0);
      p.text("Level 7", 25, 30);
      p.text("0.5*8*0.5 = ?", 250, 90);
    }
    if (curLevel == 8) {
      p.image(zebraUI3, 0, 0);
      p.text("Level 8", 25, 30);
      p.text("162:54 = ?", 250, 90);
    }
    if (curLevel == 9) {
      p.image(zebraUI4, 0, 0);
      p.text("Level 9", 25, 30);
      p.text("9*7-7*7-9 = ?", 250, 90);
    }
    if (curLevel == 10) {
      p.image(zebraUI4, 0, 0);
      p.text("Level 10", 25, 30);
      p.text("(5*6-20:4):5+2 = ?", 250, 90);
    }
  }

  public void drawRecognizedDigit(PApplet p, DigitColorModel model, Scalar avgColour) {
    p.textSize(16);
    if (model.matchesDigit(0, avgColour)) {
      p.text("0", 315, 455);
    } else if (model.matchesDigit(1, avgColour)) {
      p.text("1", 315, 455);
    } else if (model.matchesDigit(2, avgColour)) {
      p.text("2", 315, 455);
    } else if (model.matchesDigit(3, avgColour)) {
      p.text("3", 315, 455);
    } else if (model.matchesDigit(4, avgColour)) {
      p.text("4", 315, 455);
    } else if (model.matchesDigit(5, avgColour)) {
      p.text("5", 315, 455);
    } else if (model.matchesDigit(6, avgColour)) {
      p.text("6", 315, 455);
    } else if (model.matchesDigit(7, avgColour)) {
      p.text("7", 315, 455);
    } else if (model.matchesDigit(8, avgColour)) {
      p.text("8", 315, 455);
    } else if (model.matchesDigit(9, avgColour)) {
      p.text("9", 315, 455);
    }
  }
}
