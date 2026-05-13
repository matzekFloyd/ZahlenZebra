import type p5 from "p5";
import type { DigitColorModel } from "./digitColorModel";
import type { Rgba } from "./colorMath";

export class ZebraUi {
  zebraUI1!: p5.Image;
  zebraUI2!: p5.Image;
  zebraUI3!: p5.Image;
  zebraUI4!: p5.Image;
  allCalibratedUI!: p5.Image;
  notAllCalibratedUI!: p5.Image;

  loadAssets(p: p5): void {
    this.zebraUI1 = p.loadImage("/GUI/zahlenzebra.png");
    this.zebraUI2 = p.loadImage("/GUI/zahlenzebra2.png");
    this.zebraUI3 = p.loadImage("/GUI/zahlenzebra3.png");
    this.zebraUI4 = p.loadImage("/GUI/zahlenzebra4.png");
    this.allCalibratedUI = p.loadImage("/GUI/haekchen.jpg");
    this.notAllCalibratedUI = p.loadImage("/GUI/x.jpg");
  }

  drawLevel(p: p5, curLevel: number): void {
    p.fill(255, 255, 255);
    p.textSize(16);
    if (curLevel === 1) {
      p.image(this.zebraUI1, 0, 0);
      p.text("Level 1", 25, 30);
      p.text("2*2-6:2 = ?", 250, 90);
    }
    if (curLevel === 2) {
      p.image(this.zebraUI1, 0, 0);
      p.text("Level 2", 25, 30);
      p.text("4+2-(2-4) = ?", 250, 90);
    }
    if (curLevel === 3) {
      p.image(this.zebraUI1, 0, 0);
      p.text("Level 3", 25, 30);
      p.text("9:3+6*(1:2) = ?", 250, 90);
    }
    if (curLevel === 4) {
      p.image(this.zebraUI2, 0, 0);
      p.text("Level 4", 25, 30);
      p.text("32:2:2:2 = ?", 250, 90);
    }
    if (curLevel === 5) {
      p.image(this.zebraUI2, 0, 0);
      p.text("Level 5", 25, 30);
      p.text("1+3*2+2 = ?", 250, 90);
    }
    if (curLevel === 6) {
      p.image(this.zebraUI2, 0, 0);
      p.text("Level 6", 25, 30);
      p.text("100:10-4-3-2-1 = ?", 250, 90);
    }
    if (curLevel === 7) {
      p.image(this.zebraUI3, 0, 0);
      p.text("Level 7", 25, 30);
      p.text("0.5*8*0.5 = ?", 250, 90);
    }
    if (curLevel === 8) {
      p.image(this.zebraUI3, 0, 0);
      p.text("Level 8", 25, 30);
      p.text("162:54 = ?", 250, 90);
    }
    if (curLevel === 9) {
      p.image(this.zebraUI4, 0, 0);
      p.text("Level 9", 25, 30);
      p.text("9*7-7*7-9 = ?", 250, 90);
    }
    if (curLevel === 10) {
      p.image(this.zebraUI4, 0, 0);
      p.text("Level 10", 25, 30);
      p.text("(5*6-20:4):5+2 = ?", 250, 90);
    }
  }

  drawRecognizedDigit(p: p5, model: DigitColorModel, avgColour: Rgba): void {
    p.textSize(16);
    for (let d = 0; d <= 9; d++) {
      if (model.matchesDigit(d, avgColour)) {
        p.text(String(d), 315, 455);
        return;
      }
    }
  }
}
