import processing.sound.*;

SoundFile kick;
SoundFile snare;
SoundFile hihat;
SoundFile clap;

float blobSize = 100;

void setup() {
  size(600, 600);

  frameRate(60);

  kick = new SoundFile(this, "kick.wav");
  snare = new SoundFile(this, "snare.wav");
  hihat = new SoundFile(this, "hihat.wav");
  clap = new SoundFile(this, "clap.wav");
}

void draw() {

  background(20, 20, 40);

  // 120 BPM = 2 beats per second
  // every 30 frames = 1 beat AI Disclaimer, used for the fps 

  if (frameCount % 30 == 0) {

    int beat = (frameCount / 30) % 16;

    // Kick
    if (beat == 0 || beat == 4 || beat == 8 || beat == 12) {
      kick.play();
      blobSize = 250;
    }

    // Snare
    if (beat == 4 || beat == 12) {
      snare.play();
    }

    // Hi-hat with randomness
    if (random(1) > 0.3) {
      hihat.play();
    }

    // Clap pattern changes over time
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

  // Blob shrinking and expanding
  blobSize *= 0.95;

  // Blob visual, AI used to help form the shape and the random effect
  fill(random(100, 255), random(100, 255), random(100, 255), 180);
  noStroke();

  beginShape();
  for (int a = 0; a < 360; a += 10) {

    float r = blobSize + random(-20, 20);

    float x = width/2 + cos(radians(a)) * r;
    float y = height/2 + sin(radians(a)) * r;

    curveVertex(x, y);
  }
  endShape(CLOSE);

  fill(255);
  textSize(20);
  text("blob blob", 20, 30);
}
