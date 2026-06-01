import processing.video.*;

Capture cam;

color colorA;
color colorB;

int palette = 0;

void setup() {

  size(500,500);
  pixelDensity(1);

  String[] cameras = Capture.list();

  if (cameras.length == 0) {
    println("No camera found");
    exit();
  }

  cam = new Capture(this, 640, 480, cameras[0], 30);
  cam.start();

  // Starting duotone colours (Blue / Yellow)
  colorA = color(2, 65, 166);
  colorB = color(250, 182, 47);
}

void draw() {

  if (cam.available()) {
    cam.read();
  }

  // Draw webcam fullscreen
  image(cam, 0, 0, width, height);

  loadPixels();

  // Apply duotone filter
  for (int i = 0; i < pixels.length; i++) {
    pixels[i] = duotone(pixels[i], colorA, colorB);
  }

  // Apply Floyd-Steinberg dithering
  for (int i = 0; i < pixels.length; i++) {

    float grey = brightness(pixels[i]);

    float newPixel = (grey > 127) ? 255 : 0;

    float error = grey - newPixel;

    // Use the duotone colours instead of black and white
    if (newPixel == 255) {
      pixels[i] = colorB;
    } else {
      pixels[i] = colorA;
    }

    fsDither(i, error);
  }

  updatePixels();
}

color duotone(color pixel, color colorA, color colorB) {

  float tone = brightness(pixel);

  float amount = norm(tone, 0, 255);

  return lerpColor(colorA, colorB, amount);
}

void fsDither(int i, float error) {

  int[] offsets = {
    1,
    width - 1,
    width,
    width + 1
  };

  float[] ratios = {
    7/16.0,
    3/16.0,
    5/16.0,
    1/16.0
  };

  for (int j = 0; j < offsets.length; j++) {

    int neighbour = i + offsets[j];

    if (neighbour >= 0 && neighbour < pixels.length) {

      float value = brightness(pixels[neighbour]);

      value += error * ratios[j];

      value = constrain(value, 0, 255);

      pixels[neighbour] = color(value);
    }
  }
}

void keyPressed() {

  // Spacebar cycles colour palettes
  if (key == ' ') {

    palette = (palette + 1) % 4;

    if (palette == 0) {
      colorA = color(2, 65, 166);      // Blue
      colorB = color(250, 182, 47);    // Yellow
    }

    if (palette == 1) {
      colorA = color(120, 0, 255);     // Purple
      colorB = color(255, 100, 0);     // Orange
    }

    if (palette == 2) {
      colorA = color(0, 80, 30);       // Dark Green
      colorB = color(180, 255, 120);   // Light Green
    }

    if (palette == 3) {
      colorA = color(0, 0, 0);         // Black
      colorB = color(255, 0, 100);     // Pink
    }
  }

  // Save screenshot
  if (key == 's' || key == 'S') {
    saveFrame("portfolio-######.png");
  }
}
