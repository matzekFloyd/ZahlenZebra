[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

# ZahlenZebra

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

## Controls

- **Enter** — submit the recognized digit as your answer for the current level (when it matches the expected answer).
- **c** — toggle calibration mode: point the probe at each digit’s color and press **0**–**9** to save ground truth (writes into `GroundTruthImages/`).
- **l** — cycle to the next level (for testing).

## Repository layout

```text
ZahlenZebra/                 ← repository root (not the Processing sketch root)
  README.md
  LICENSE
  zahlenZebra/               ← open this folder in Processing
    zahlenZebra.pde          ← main sketch tab
    *.java                   ← helpers (OpenCV sampler, UI, game state, color model)
    GUI/                     ← UI images
    GroundTruthImages/       ← calibration snapshots (generated / updated in calibration)
```

## License

This project is licensed under the MIT License — see [LICENSE](LICENSE).
