/**
 * ZahlenZebra — Processing sketch (Java mode).
 *
 * Open this folder in Processing (sketch name must match folder: zahlenZebra).
 * Install libraries via Contribution Manager: "OpenCV for Processing", "Video".
 */

import org.opencv.core.Scalar;
import processing.video.Capture;

final int VIEW_W = 640;
final int VIEW_H = 480;
final int PROBE_X = 300;
final int PROBE_Y = 300;
final int PROBE_W = 2;
final int PROBE_H = 2;

WebcamOpenCvSampler webcam;
DigitColorModel colors;
ZebraUi ui;
GameSession game;

void setup() {
  ui = new ZebraUi();
  ui.loadAssets(this);
  size(640, 480);
  webcam = new WebcamOpenCvSampler(this, VIEW_W, VIEW_H);
  colors = new DigitColorModel();
  game = new GameSession();
}

void draw() {
  webcam.loadVideoIntoOpenCv();
  webcam.setRoi(PROBE_X, PROBE_Y, PROBE_W, PROBE_H);
  image(webcam.getPreviewImage(), 0, 0);
  fill(255, 0, 0);
  rect(PROBE_X, PROBE_Y, PROBE_W, PROBE_H);
  fill(255, 255, 255);

  if (!game.showCalibration) {
    ui.drawLevel(this, game.curLevel);
  }

  if (game.showCalibration) {
    colors.drawCalibrationThumbnails(this, ui.allCalibratedUI, ui.notAllCalibratedUI);
    stroke(255, 255, 255);
  } else {
    stroke(255, 0, 0);
    noFill();
  }

  Scalar avgColour = webcam.averageColorForPatch(PROBE_X, PROBE_Y, PROBE_W, PROBE_H);

  if (game.showCalibration) {
    colors.drawCalibrationValueLabels(this, avgColour);
  }

  ui.drawRecognizedDigit(this, colors, avgColour);

  if (!game.showCalibration && webcam.cameraAvailable) {
    textSize(12);
    text("c = calibration", 10, 470);
    text("enter = confirm number", 485, 470);
  }

  game.setLastAverageColour(avgColour);

  if (!webcam.cameraAvailable) {
    drawNoCameraOverlay();
  }
}

void drawNoCameraOverlay() {
  fill(0, 170);
  rect(0, 0, width, height);
  fill(255);
  textAlign(CENTER, CENTER);
  textSize(15);
  text(
    "No webcam or video input found.\n\n"
      + "Connect a camera, allow access in system privacy settings,\n"
      + "then restart this sketch.\n\n"
      + "(GStreamer / Video library reported no devices.)",
    width / 2,
    height / 2
  );
  textAlign(LEFT, BASELINE);
}

void captureEvent(Capture c) {
  if (webcam.video != null) {
    c.read();
  }
}

void keyPressed() {
  game.handleKey(this, colors);
}
