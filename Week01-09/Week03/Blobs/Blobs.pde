float noiseOffset = 0;

void setup() {
  size(1200, 800);
  smooth();
}

void draw() {

  background(240, 220, 230);

  blendMode(ADD);

  noiseOffset += 0.01;

  for (int i = 0; i < 8; i++) {

    float x = width/2 + sin(radians(frameCount + i*45)) * 250;
    float y = height/2 + cos(radians(frameCount + i*45)) * 150;

    pushMatrix();
    translate(x, y);

    // Colour shifts over time
    float r = 128 + 127 * sin(radians(frameCount + i*30));
    float g = 128 + 127 * sin(radians(frameCount + i*30 + 120));
    float b = 128 + 127 * sin(radians(frameCount + i*30 + 240));

    fill(r, g, b, 90);
    stroke(255);
    strokeWeight(4);

    // Blob shape
    beginShape();

    for (float a = 0; a < TWO_PI; a += 0.25) {

      float n = noise(
        cos(a) + i,
        sin(a) + noiseOffset
      );

      float radius = 80 + n * 60;

      float px = cos(a) * radius;
      float py = sin(a) * radius;

      vertex(px, py);
    }

    endShape(CLOSE);

    // Modulo pattern with primitives
    if (i % 3 == 0) {

      fill(255, 255, 255, 120);
      ellipse(0, 0, 40, 40);

    } else if (i % 3 == 1) {

      fill(255, 255, 255, 120);
      rectMode(CENTER);
      rect(0, 0, 40, 40);

    } else {

      fill(255, 255, 255, 120);
      triangle(
        -20, 20,
        20, 20,
        0, -20
      );
    }

    popMatrix();
  }
}
