# ZahlenZebra

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

ZahlenZebra is a **Processing (Java mode)** sketch: a short math quiz where answers are confirmed with **color cards** in front of a webcam. The live image is analyzed with **OpenCV for Processing** (`gab.opencv`): a small region of the frame is averaged in RGB and matched to per-digit calibration values.

## Requirements

- [Processing](https://processing.org/) (Java mode)
- Contributed libraries (install via **Sketch → Import Library… → Add Library…**):

### OpenCV

- Install **OpenCV for Processing** (author **Greg Borenstein**). Search for **OpenCV**, not “Video”.
- This library provides `gab.opencv` and `org.opencv.core`.

### Video (`processing.video`)

The Contribution Manager lists several libraries whose names contain “video”. You want the **official GStreamer-based library from The Processing Foundation**:

| Your Processing version | Install this library |
|----------------------|----------------------|
| **Processing 4.x** | **Video Library for Processing 4** (The Processing Foundation) |
| **Processing 3.x** | **Video Library for Processing 3** (The Processing Foundation) |

Do **not** use unrelated entries such as *GL Video*, *Video Export*, *VLCJVideo*, *Syphon*, etc. — they do not supply `processing.video` / `Capture`.

Install **only** the Video library that matches your Processing major version (3 **or** 4, not both).

Libraries are installed under your **sketchbook** folder, in a subfolder named `libraries` (see **File → Preferences** for the sketchbook path).

## How to run

1. Install the libraries above and restart Processing if prompted.
2. In Processing, use **File → Open…** and open the **`zahlenZebra`** folder inside this repository (the folder that contains `zahlenZebra.pde` and the `GUI` / `GroundTruthImages` assets).  
   **Do not** open the repository root as the sketch; Processing expects the sketch folder name to match the main `.pde` filename.
3. Connect a webcam and click **Run**.

If no device is available (or the OS blocks camera access), the sketch still **starts**: you get a dark placeholder feed and an on-screen message instead of the VM exiting with a GStreamer “Could not find any devices” error.

## Web (p5.js + TypeScript)

A browser port lives in **`web/`** ([Vite](https://vitejs.dev/) + [p5.js](https://p5js.org/) + TypeScript). It mirrors the same levels, probe region, colour-matching tolerance, and keyboard behaviour. Differences from the desktop sketch:

- Uses **`getUserMedia`** via p5 `createCapture` (no OpenCV / GStreamer).
- Calibration is saved in **`localStorage`** (not `GroundTruthImages/` files). Colour values are in **RGBA** as read from the canvas; they are **not** interchangeable with the Java/OpenCV calibration—recalibrate in the browser.
- Use **HTTPS** or **localhost** so the browser allows the camera.

```bash
cd web
npm install
npm run dev
```

Then open the URL Vite prints (usually `http://localhost:5173`). Production build: `npm run build` (output in `web/dist/`).

### Netlify

The repo includes [`netlify.toml`](netlify.toml) at the root: **base directory** `web`, build **`npm ci && npm run build`**, **publish** `dist` (i.e. `web/dist`). **`package-lock.json`** under `web/` must be committed so `npm ci` succeeds.

In the Netlify UI, clear any old **Publish directory** / **Base directory** values that conflict with the file (the TOML overrides typical UI settings once merged). Camera access on the deployed site requires **HTTPS** (Netlify provides that by default).

## Controls

- **Enter** — submit the recognized digit as your answer for the current level (when it matches the expected answer).
- **c** — toggle calibration mode: point the probe at each digit’s colour and press **0**–**9** to save ground truth (Processing: files under `GroundTruthImages/`; web: `localStorage`).
- **l** — cycle to the next level (for testing).

## Repository layout

```text
ZahlenZebra/                 ← repository root (not the Processing sketch root)
  README.md
  LICENSE
  netlify.toml               ← Netlify: build web/ → deploy web/dist
  web/                       ← p5.js + TypeScript (npm run dev)
    public/GUI/              ← UI images for the web build
    src/
  zahlenZebra/               ← open this folder in Processing
    zahlenZebra.pde          ← main sketch tab
    *.java                   ← helpers (OpenCV sampler, UI, game state, color model)
    GUI/                     ← UI images (Processing)
    GroundTruthImages/       ← calibration snapshots (Processing; generated in calibration)
```

## License

This project is licensed under the MIT License — see [LICENSE](LICENSE).
