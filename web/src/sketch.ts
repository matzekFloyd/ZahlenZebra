import p5 from "p5";
import { PROBE_H, PROBE_W, PROBE_X, PROBE_Y, VIEW_H, VIEW_W } from "./constants";
import { averageRegion } from "./colorMath";
import { DigitColorModel } from "./digitColorModel";
import { GameSession } from "./gameSession";
import { WebcamSampler } from "./webcamSampler";
import { ZebraUi } from "./zebraUi";

function drawNoCameraOverlay(p: p5): void {
  p.fill(0, 170);
  p.rect(0, 0, p.width, p.height);
  p.fill(255);
  p.textAlign(p.CENTER, p.CENTER);
  p.textSize(15);
  p.text(
    "No webcam or permission denied.\n\nAllow camera access for this site and reload,\nor use a browser that can open the camera.\n\nThe math UI still runs underneath this overlay.",
    p.width / 2,
    p.height / 2
  );
  p.textAlign(p.LEFT, p.BASELINE);
}

/** Mount the p5 instance-mode sketch into `parent` (e.g. a div). */
export function mountZahlenZebra(parent: HTMLElement): p5 {
  const sketch = (p: p5) => {
    const colors = new DigitColorModel();
    const game = new GameSession();
    const ui = new ZebraUi();
    const webcam = new WebcamSampler();

    p.preload = () => {
      ui.loadAssets(p);
    };

    p.setup = () => {
      p.createCanvas(VIEW_W, VIEW_H).parent(parent);
      webcam.init(p);
      colors.loadFromStorage(p);
    };

    p.draw = () => {
      webcam.drawFrame(p, 0, 0, VIEW_W, VIEW_H);
      p.fill(255, 0, 0);
      p.rect(PROBE_X, PROBE_Y, PROBE_W, PROBE_H);
      p.fill(255, 255, 255);

      if (!game.showCalibration) {
        ui.drawLevel(p, game.curLevel);
      }

      if (game.showCalibration) {
        colors.drawCalibrationThumbnails(p, ui.allCalibratedUI, ui.notAllCalibratedUI);
        p.stroke(255, 255, 255);
      } else {
        p.stroke(255, 0, 0);
        p.noFill();
      }

      const avgColour = averageRegion(p, webcam.getFrameSource(), PROBE_X, PROBE_Y, PROBE_W, PROBE_H);

      if (game.showCalibration) {
        colors.drawCalibrationValueLabels(p, avgColour);
      }

      ui.drawRecognizedDigit(p, colors, avgColour);

      if (!game.showCalibration && webcam.cameraAvailable) {
        p.textSize(12);
        p.text("c = calibration", 10, 470);
        p.text("enter = confirm number", 485, 470);
      }

      game.setLastAverageColour(avgColour);

      if (!webcam.cameraAvailable) {
        drawNoCameraOverlay(p);
      }
    };

    p.keyPressed = () => {
      game.handleKey(p, colors);
    };
  };

  return new p5(sketch);
}
