import type p5 from "p5";
import type { DigitColorModel } from "./digitColorModel";
import type { Rgba } from "./colorMath";

/** Level answers: index 1..10 (same as `GameSession.java`). */
const LEVEL_ANSWER_DIGIT = [-1, 1, 8, 6, 4, 9, 0, 2, 3, 5, 7];

const ENTER = 13;

export class GameSession {
  showCalibration = false;
  curLevel = 1;
  lastAvgColour: Rgba = { r: 0, g: 0, b: 0, a: 0 };

  setLastAverageColour(c: Rgba): void {
    this.lastAvgColour = { ...c };
  }

  handleKey(p: p5, colors: DigitColorModel): void {
    if (this.showCalibration && p.key.length === 1) {
      const code = p.key.charCodeAt(0);
      if (code >= 48 && code <= 57) {
        colors.calibrateGroundTruth(p, code - 48, this.lastAvgColour);
      }
    }

    const k = p.key;
    if (k === "c" || k === "C") {
      this.showCalibration = !this.showCalibration;
    }

    if (p.keyCode === ENTER) {
      const need = LEVEL_ANSWER_DIGIT[this.curLevel] ?? -1;
      if (need >= 0 && colors.matchesDigit(need, this.lastAvgColour)) {
        if (this.curLevel === 10) {
          this.curLevel = 1;
        } else {
          this.curLevel++;
        }
        console.log(this.curLevel);
      }
    }

    if (k === "l" || k === "L") {
      this.curLevel++;
      if (this.curLevel > 10) {
        this.curLevel = 1;
      }
    }
  }
}
