import type p5 from "p5";
import { MATCH_TOLERANCE, STORAGE_KEY } from "./constants";
import { closeToColour, type Rgba } from "./colorMath";

type StoredCalibration = Record<string, [number, number, number, number]>;

const ZEROS: Rgba = { r: 0, g: 0, b: 0, a: 0 };

export class DigitColorModel {
  private readonly truths: Rgba[] = Array.from({ length: 10 }, () => ({ ...ZEROS }));
  private readonly thumbs: (p5.Image | null)[] = Array.from({ length: 10 }, () => null);

  loadFromStorage(p: p5): void {
    try {
      const raw = localStorage.getItem(STORAGE_KEY);
      if (!raw) return;
      const data = JSON.parse(raw) as StoredCalibration;
      for (let d = 0; d < 10; d++) {
        const row = data[String(d)];
        if (!row || row.length < 4) continue;
        this.truths[d] = { r: row[0], g: row[1], b: row[2], a: row[3] };
        this.rebuildThumb(p, d);
      }
    } catch {
      /* ignore */
    }
  }

  private saveToStorage(): void {
    const data: StoredCalibration = {};
    for (let d = 0; d < 10; d++) {
      const t = this.truths[d];
      data[String(d)] = [t.r, t.g, t.b, t.a];
    }
    try {
      localStorage.setItem(STORAGE_KEY, JSON.stringify(data));
    } catch {
      /* quota / private mode */
    }
  }

  private rebuildThumb(p: p5, digit: number): void {
    const t = this.truths[digit];
    const g = p.createGraphics(1, 1);
    g.pixelDensity(1);
    g.background(t.r, t.g, t.b, t.a);
    const img = g.get(0, 0, 1, 1);
    this.thumbs[digit] = img;
  }

  allDigitsCalibrated(): boolean {
    return this.thumbs.every((t) => t !== null);
  }

  calibrateGroundTruth(p: p5, digit: number, avg: Rgba): void {
    if (digit < 0 || digit > 9) return;
    this.truths[digit] = { ...avg };
    this.rebuildThumb(p, digit);
    this.saveToStorage();
  }

  matchesDigit(digit: number, colour: Rgba): boolean {
    if (digit < 0 || digit > 9) return false;
    return closeToColour(colour, this.truths[digit], MATCH_TOLERANCE);
  }

  drawCalibrationThumbnails(
    p: p5,
    allCalibratedUI: p5.Image,
    notAllCalibratedUI: p5.Image
  ): void {
    const slots = [50, 100, 150, 200, 250, 300, 350, 400, 450, 500];
    p.noFill();
    for (let d = 0; d < 10; d++) {
      const x = slots[d] ?? 50;
      p.rect(x, 25, 25, 25);
      const thumb = this.thumbs[d];
      if (thumb) {
        p.image(thumb, x, 25, 25, 25);
      }
    }
    p.rect(550, 25, 25, 25);
    if (this.allDigitsCalibrated()) {
      p.image(allCalibratedUI, 550, 25, 25, 25);
    } else {
      p.image(notAllCalibratedUI, 550, 25, 25, 25);
    }
  }

  drawCalibrationValueLabels(p: p5, avg: Rgba): void {
    const fmt = (c: Rgba) =>
      `${Math.trunc(c.r)} ${Math.trunc(c.g)} ${Math.trunc(c.b)} ${Math.trunc(c.a)}`;
    p.text(`Values [Cur]: ${fmt(avg)}`, 20, 75);
    for (let d = 0; d < 10; d++) {
      p.text(`Values [${d}]: ${fmt(this.truths[d])}`, 20, 100 + d * 25);
    }
  }
}
