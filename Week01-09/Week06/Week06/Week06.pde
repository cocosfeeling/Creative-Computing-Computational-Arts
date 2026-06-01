import processing.video.*;

Capture cam;

int filterMode = 0;

void setup() {
  pixelDensity(1);
  size(600,600);

  String[] cameras = Capture.list();

  if (cameras.length == 0) {
    println("No camera found");
    exit();
  }

  cam = new Capture(this, width, height, cameras[0], 30);
  cam.start();
}

void draw() {

  if (cam.available()) {
    cam.read();
  }

  cam.loadPixels();
  loadPixels();

  // Copy webcam image with colour filter
  int totalPixels = min(pixels.length, cam.pixels.length);

  for (int i = 0; i < totalPixels; i++) {

    color c = cam.pixels[i];

    float r = red(c);
    float g = green(c);
    float b = blue(c);

    // SPACEBAR cycles through these filters
    switch(filterMode) {

    case 0: // Normal colour
      break;

    case 1: // Red tint
      g *= 0.4;
      b *= 0.4;
      break;

    case 2: // Green tint
      r *= 0.4;
      b *= 0.4;
      break;

    case 3: // Blue tint
      r *= 0.4;
      g *= 0.4;
      break;
    }

    pixels[i] = color(r, g, b);
  }

  // Colour dithering
  for (int i = 0; i < pixels.length; i++) {

    float r = red(pixels[i]);
    float g = green(pixels[i]);
    float b = blue(pixels[i]);

    float newR = (r > 127) ? 255 : 0;
    float newG = (g > 127) ? 255 : 0;
    float newB = (b > 127) ? 255 : 0;

    float errR = r - newR;
    float errG = g - newG;
    float errB = b - newB;

    pixels[i] = color(newR, newG, newB);

    fsDitherColour(i, errR, errG, errB);
  }

  updatePixels();
}

void fsDitherColour(int i, float errR, float errG, float errB) {

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

    int n = i + offsets[j];

    if (n >= 0 && n < pixels.length) {

      float r = red(pixels[n]);
      float g = green(pixels[n]);
      float b = blue(pixels[n]);

      r += errR * ratios[j];
      g += errG * ratios[j];
      b += errB * ratios[j];

      pixels[n] = color(
        constrain(r, 0, 255),
        constrain(g, 0, 255),
        constrain(b, 0, 255)
      );
    }
  }
}

void keyPressed() {

  if (key == ' ') {
    filterMode++;
    filterMode %= 4;
  }

  if (key == 's' || key == 'S') {
    saveFrame("portfolio-######.png");
  }
}
