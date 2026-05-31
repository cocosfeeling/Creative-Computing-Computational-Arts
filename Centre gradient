void setup() {
  size(400, 300);
}

void draw() {

  loadPixels();

  float maxDistance = dist(width/2, height/2, 0, 0);

  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {

      float distanceFromCentre =
        dist(x, y, width/2, height/2);

      float blend =
        map(distanceFromCentre, 0, maxDistance, 0, 1);

      int red = int(255 - (240 * blend));
      int green = int(220 - (190 * blend));
      int blue = int(230 - (140 * blend));

      color c = color(red, green, blue);

      pixels[x + y * width] = c;
    }
  }

  updatePixels();
}
