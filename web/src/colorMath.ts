import type p5 from "p5";

/** Four-channel colour sample (aligned with on-screen calibration labels: R G B A). */
export type Rgba = { r: number; g: number; b: number; a: number };

export function closeToColour(colour: Rgba, groundTruth: Rgba, tolerance = 50): boolean {
  const dr = Math.abs(groundTruth.r - colour.r);
  const dg = Math.abs(groundTruth.g - colour.g);
  const db = Math.abs(groundTruth.b - colour.b);
  const da = Math.abs(groundTruth.a - colour.a);
  return dr + dg + db + da < tolerance;
}

/** Average RGBA over a `sw`×`sh` region copied from `source` at (`sx`,`sy`). */
export function averageRegion(
  p: p5,
  source: p5.Image | p5.MediaElement,
  sx: number,
  sy: number,
  sw: number,
  sh: number
): Rgba {
  const g = p.createGraphics(sw, sh);
  g.pixelDensity(1);
  try {
    g.copy(source, sx, sy, sw, sh, 0, 0, sw, sh);
  } catch {
    return { r: 0, g: 0, b: 0, a: 255 };
  }
  g.loadPixels();
  const px = g.pixels;
  if (!px || px.length < 4) {
    return { r: 0, g: 0, b: 0, a: 255 };
  }
  let r = 0;
  let gch = 0;
  let b = 0;
  let a = 0;
  const n = px.length / 4;
  for (let i = 0; i < px.length; i += 4) {
    r += px[i] ?? 0;
    gch += px[i + 1] ?? 0;
    b += px[i + 2] ?? 0;
    a += px[i + 3] ?? 0;
  }
  const nf = Math.max(1, n);
  return { r: r / nf, g: gch / nf, b: b / nf, a: a / nf };
}
