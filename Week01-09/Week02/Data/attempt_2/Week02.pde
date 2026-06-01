PImage sample;

void setup() {
  size(517, 606);
  sample = loadImage("sample.jpg");
  sample.loadPixels();
}

void draw() {

  loadPixels();

  int[] redHist = new int[256];
  int[] greenHist = new int[256];
  int[] blueHist = new int[256];

  for (int i = 0; i < sample.pixels.length; i++) {

    color c = sample.pixels[i];

    pixels[i] = c;

    int r = int(red(c));
    int g = int(green(c));
    int b = int(blue(c));

    redHist[r]++;
    greenHist[g]++;
    blueHist[b]++;
  }

  updatePixels();

  for (int i = 0; i < 256; i++) {

    stroke(255, 0, 0);

    float h = map(
      redHist[i],
      0,
      max(redHist),
      height,
      height-(height/3)
      );

    line(i, h, i, height);
  }
}
