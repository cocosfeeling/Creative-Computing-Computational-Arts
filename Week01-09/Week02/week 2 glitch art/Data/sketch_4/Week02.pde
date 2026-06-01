PImage img;

void setup() {

  size(500, 500);

  img = loadImage("IMG_0071.jpeg");

  img.resize(width, height);

  img.loadPixels();

  for (int x = 0; x < img.width; x++) {

    color[] column = new color[img.height];

    for (int y = 0; y < img.height; y++) {
      column[y] = img.pixels[y * img.width + x];
    }

    for (int i = 0; i < column.length - 1; i++) {
      for (int j = i + 1; j < column.length; j++) {

        if (red(column[i]) > red(column[j])) {

          color temp = column[i];
          column[i] = column[j];
          column[j] = temp;
        }
      }
    }

    for (int y = 0; y < img.height; y++) {
      img.pixels[y * img.width + x] = column[y];
    }
  }

  img.updatePixels();

  image(img, 0, 0);

  save("vertical_sort.png");
}

void draw() {
}
