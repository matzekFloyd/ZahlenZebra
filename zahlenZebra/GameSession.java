import org.opencv.core.Scalar;
import processing.core.PApplet;
import processing.core.PConstants;

/**
 * Level progression and keyboard handling. Digit keys use {@code key} so calibration works with different key layouts.
 */
public class GameSession {

  private static final int[] LEVEL_ANSWER_DIGIT = {
    -1,
    1, 8, 6, 4, 9, 0, 2, 3, 5, 7
  };

  public boolean showCalibration = false;
  public int curLevel = 1;

  Scalar lastAvgColour = new Scalar(0, 0, 0, 0);

  public void setLastAverageColour(Scalar avgColour) {
    this.lastAvgColour = avgColour;
  }

  public void handleKey(PApplet app, DigitColorModel colors) {
    if (showCalibration && app.key >= '0' && app.key <= '9') {
      int d = app.key - '0';
      colors.calibrateGroundTruth(app, d, lastAvgColour);
    }

    char k = app.key;
    if (k == 'c' || k == 'C') {
      showCalibration = !showCalibration;
    }

    if (app.keyCode == PConstants.ENTER) {
      int need = LEVEL_ANSWER_DIGIT[curLevel];
      if (colors.matchesDigit(need, lastAvgColour)) {
        if (curLevel == 10) {
          curLevel = 1;
        } else {
          curLevel++;
        }
        app.println(curLevel);
      }
    }

    if (app.key == 'l' || app.key == 'L') {
      curLevel = curLevel + 1;
      if (curLevel > 10) {
        curLevel = 1;
      }
    }
  }
}
