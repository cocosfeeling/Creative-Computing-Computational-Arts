float t = 0;

void setup() {
  size(600, 600);
  smooth();
}

void draw() {

  // gradient based on week 1
  for (int y = 0; y < height; y++) {
    float n = map(y, 0, height, 0, 1);

    color top = color(255, 190, 210);    // pastel pink
    color bottom = color(255, 230, 180); // pastel peach

    stroke(lerpColor(top, bottom, n));
    line(0, y, width, y);
  }

  // Sun
  noStroke();
  fill(255, 220, 170);
  ellipse(width/2, height/2 - 40, 140, 140);

  // noise on the sea
  fill(170, 220, 235);

  beginShape();
  vertex(0, height);

  for (int x = 0; x <= width; x += 10) {
    float y = height/2
      + map(noise(x * 0.01, t), 0, 1, -15, 15);

    vertex(x, y);
  }

  vertex(width, height);
  endShape(CLOSE);

  t += 0.01;
}
