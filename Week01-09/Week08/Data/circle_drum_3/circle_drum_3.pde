import processing.sound.*;

SoundFile kick;
SoundFile snare;
SoundFile hihat;
SoundFile clap;

float x = 300;
float y = 300;

float speedX = 5;
float speedY = 4;

float circleSize = 80;

void setup() {
  size(600, 600);
  frameRate(60);

  kick = new SoundFile(this, "kick.wav");
  snare = new SoundFile(this, "snare.wav");
  hihat = new SoundFile(this, "hihat.wav");
  clap = new SoundFile(this, "clap.wav");
}

void draw() {

  background(20);

  // Move circle
  x += speedX;
  y += speedY;

  // Bounce off walls
  if (x > width || x < 0) {
    speedX *= -1;
  }

  if (y > height || y < 0) {
    speedY *= -1;
  }

  // Drum pattern
  if (frameCount % 30 == 0) {

    int beat = (frameCount / 30) % 16;

    // Kick
    if (beat == 0 || beat == 4 || beat == 8 || beat == 12) {
      kick.play();
      circleSize = 120;
    }

    // Snare
    if (beat == 4 || beat == 12) {
      snare.play();
    }

    // Random hi-hat
    if (random(1) > 0.3) {
      hihat.play();
    }

    // Pattern changes every few bars
    if ((frameCount / 480) % 2 == 0) {

      if (beat == 10) {
        clap.play();
      }

    } else {

      if (beat == 2 || beat == 6 || beat == 10 || beat == 14) {
        clap.play();
      }
    }
  }

  // Circle slowly shrinks after kick
  circleSize *= 0.97;

  if (circleSize < 80) {
    circleSize = 80;
  }

  // Random colour
  fill(
    random(255),
    random(255),
    random(255)
  );

  noStroke();
  circle(x, y, circleSize);

  fill(255);
  text("Boom boom clap boom clap", 20, 30);
}
