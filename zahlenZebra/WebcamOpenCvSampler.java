import gab.opencv.*;
import org.opencv.core.Core;
import org.opencv.core.Mat;
import org.opencv.core.Scalar;
import processing.core.PApplet;
import processing.core.PConstants;
import processing.core.PImage;
import processing.video.Capture;

/**
 * Wraps optional {@link Capture} + OpenCV for Processing ({@link OpenCV}). If no camera is available or
 * {@code Capture.start()} fails (e.g. GStreamer “Could not find any devices”), the sketch keeps running
 * using a static fallback frame instead of crashing the VM.
 */
public class WebcamOpenCvSampler {

  /** {@code null} when no working capture device was opened. */
  public final Capture video;
  public final OpenCV opencv;
  /** {@code true} if a live capture device opened and started successfully. */
  public final boolean cameraAvailable;

  private final PImage offlineFrame;

  public WebcamOpenCvSampler(PApplet app, int w, int h) {
    offlineFrame = app.createImage(w, h, PConstants.RGB);
    offlineFrame.loadPixels();
    int bg = app.color(40, 40, 44);
    for (int i = 0; i < offlineFrame.pixels.length; i++) {
      offlineFrame.pixels[i] = bg;
    }
    offlineFrame.updatePixels();

    opencv = new OpenCV(app, w, h);

    Capture cap = null;
    try {
      cap = new Capture(app, w, h);
      cap.start();
    } catch (Throwable t) {
      if (cap != null) {
        try {
          cap.stop();
        } catch (Throwable ignored) {
        }
      }
      cap = null;
    }

    video = cap;
    cameraAvailable = cap != null;
    loadVideoIntoOpenCv();
  }

  public void loadVideoIntoOpenCv() {
    if (cameraAvailable && video != null) {
      try {
        opencv.loadImage(video);
        return;
      } catch (RuntimeException e) {
        // e.g. device removed while running — fall back for this frame
      }
    }
    opencv.loadImage(offlineFrame);
  }

  public void setRoi(int x, int y, int w, int h) {
    opencv.setROI(x, y, w, h);
  }

  public PImage getPreviewImage() {
    return opencv.getInput();
  }

  /**
   * Same averaging path as the original sketch: full-color Mat, fixed sub-window, mean via {@link Core#sumElems}.
   */
  public Scalar averageColorForPatch(int patchX, int patchY, int patchW, int patchH) {
    opencv.setROI(patchX, patchY, patchW, patchH);
    Mat rgb = opencv.getColor();
    Mat subRGB = rgb.submat(patchY, patchY + patchH, patchX, patchX + patchW);
    Scalar colourSum = Core.sumElems(subRGB);
    float factor = 1.0f / (patchW * (float) patchH);
    Scalar divisor = new Scalar(factor, factor, factor, factor);
    return colourSum.mul(divisor);
  }
}
