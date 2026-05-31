void setup() {
  size(400, 300);
}

void draw() {

  loadPixels();

  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {

      float blend = map(x + y, 0, width + height, 0, 1);

      int red = 10;
      int green = int(40 + (100 * blend));
      int blue = int(80 + (80 * blend));

      color c = color(red, green, blue);

      pixels[x + y * width] = c;
    }
  }

  updatePixels();
}
