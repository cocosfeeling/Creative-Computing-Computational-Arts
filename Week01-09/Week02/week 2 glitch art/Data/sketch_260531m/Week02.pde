PImage img;

void setup() {

  size(500, 500);

  img = loadImage("IMG_0071.jpeg");

  img.resize(width, height);

  img.loadPixels();

  for (int y = 0; y < img.height; y++) {

    color[] row = new color[img.width];

    for (int x = 0; x < img.width; x++) {
      row[x] = img.pixels[y * img.width + x];
    }

    for (int i = 0; i < row.length - 1; i++) {
      for (int j = i + 1; j < row.length; j++) {

        if (red(row[i]) > red(row[j])) {

          color temp = row[i];
          row[i] = row[j];
          row[j] = temp;
        }
      }
    }

    for (int x = 0; x < img.width; x++) {
      img.pixels[y * img.width + x] = row[x];
    }
  }

  img.updatePixels();

  image(img, 0, 0);

  save("red_sort.png");
}

void draw() {
}
