import type p5 from "p5";
import { VIEW_H, VIEW_W } from "./constants";

/**
 * Browser webcam via p5 `createCapture`, with the same offline placeholder idea as the Processing sketch.
 */
export class WebcamSampler {
  capture: p5.MediaElement | null = null;
  cameraAvailable = false;
  private offline: p5.Image | null = null;

  init(p: p5): void {
    this.offline = p.createImage(VIEW_W, VIEW_H);
    this.offline.loadPixels();
    const px = this.offline.pixels;
    if (px) {
      for (let i = 0; i < px.length; i += 4) {
        px[i] = 40;
        px[i + 1] = 40;
        px[i + 2] = 44;
        px[i + 3] = 255;
      }
    }
    this.offline.updatePixels();

    try {
      const cap = p.createCapture({
        video: { width: { ideal: VIEW_W }, height: { ideal: VIEW_H } },
        audio: false,
      }) as p5.MediaElement;
      this.capture = cap;
      cap.size(VIEW_W, VIEW_H);
      cap.hide();
      const elt = cap.elt as HTMLVideoElement;
      const markReady = (): void => {
        if (elt.videoWidth > 0 && elt.videoHeight > 0) {
          this.cameraAvailable = true;
        }
      };
      elt.addEventListener("loadeddata", markReady);
      elt.addEventListener("canplay", markReady);
      elt.addEventListener("error", () => {
        this.cameraAvailable = false;
      });
    } catch {
      this.capture = null;
      this.cameraAvailable = false;
    }
  }

  /** Image or video element to draw full-frame and to sample with `copy`. */
  getFrameSource(): p5.Image | p5.MediaElement {
    if (this.cameraAvailable && this.capture) {
      return this.capture;
    }
    return this.offline!;
  }

  drawFrame(p: p5, x: number, y: number, w: number, h: number): void {
    p.image(this.getFrameSource(), x, y, w, h);
  }
}
