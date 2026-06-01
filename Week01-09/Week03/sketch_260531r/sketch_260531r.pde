float angle = 0;

void setup() {
  size(1000, 800);

  smooth(); // Anti-aliasing ON
  rectMode(CENTER);
  ellipseMode(CENTER);
}

void draw() {

  background(10, 15, 25);

  blendMode(ADD);

  translate(width/2, height/2);

  for (int i = 0; i < 40; i++) {

    pushMatrix();

    rotate(radians(angle + i * 9));

    float radius = 80 + sin(radians(frameCount + i * 15)) * 40;

    translate(radius * 3, 0);

    // Animated abstract colours
    float r = 128 + 127 * sin(radians(frameCount + i * 10));
    float g = 128 + 127 * sin(radians(frameCount + i * 10 + 120));
    float b = 128 + 127 * sin(radians(frameCount + i * 10 + 240));

    fill(r, g, b, 120);
    noStroke();

    // Modulo pattern alternates shapes
    if (i % 4 == 0) {

      ellipse(0, 0, 80, 80);

    } else if (i % 4 == 1) {

      rect(0, 0, 70, 70);

    } else if (i % 4 == 2) {

      triangle(
        -35, 35,
        35, 35,
        0, -35
      );

    } else {

      // Diamond shape
      beginShape();
      vertex(0, -40);
      vertex(40, 0);
      vertex(0, 40);
      vertex(-40, 0);
      endShape(CLOSE);
    }

    popMatrix();
  }

  angle += 0.5;
}
