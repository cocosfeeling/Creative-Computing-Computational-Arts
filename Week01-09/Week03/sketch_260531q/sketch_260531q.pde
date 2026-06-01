float angle = 0;

void setup() {
  size(1000, 800);

  smooth();        // Anti-aliasing ON
  rectMode(CENTER);
  ellipseMode(CENTER);
}

void draw() {

  background(240);

  blendMode(ADD);

  translate(width/2, height/2);

  for (int i = 0; i < 30; i++) {

    pushMatrix();

    rotate(radians(angle + i * 12));

    float radius = 50 + sin(radians(frameCount + i * 10)) * 30;

    translate(radius * 4, 0);

    // Modulo creates repeating pattern
    if (i % 3 == 0) {

      fill(255, 100, 150, 100);
      noStroke();

      ellipse(0, 0, 80, 80);

    } else if (i % 3 == 1) {

      fill(100, 200, 255, 100);
      noStroke();

      rect(0, 0, 70, 70);

    } else {

      fill(180, 255, 120, 100);
      noStroke();

      triangle(
        -35, 35,
        35, 35,
        0, -35
      );
    }

    popMatrix();
  }

  angle += 0.5;
}
