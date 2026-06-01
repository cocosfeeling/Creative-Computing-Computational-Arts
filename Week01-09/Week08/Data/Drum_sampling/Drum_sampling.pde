import processing.sound.*;

// Drum samples
SoundFile kick;
SoundFile snare;
SoundFile hihat;
SoundFile clap;

// Tempo
float bpm = 120;

// 120 BPM = 2 beats per second
// 60 FPS gives 30 frames per beat  AI used to help with the fps and beats
int fps = 60;
int framesPerBeat;

int beatCount = 0;

void setup() {
  size(800, 400);

  frameRate(fps);

  framesPerBeat = int(fps / (bpm / 60.0));

  // Load samples from data folder
  kick = new SoundFile(this, "kick.wav");
  snare = new SoundFile(this, "snare.wav");
  hihat = new SoundFile(this, "hihat.wav");
  clap = new SoundFile(this, "clap.wav");

  background(0);
}

void draw() {

  // Trigger sounds every beat
  if (frameCount % framesPerBeat == 0) {

    int step = beatCount % 16;     // 16-step pattern
    int bar = (beatCount / 16) % 8; // count bars

    // ---------- KICK ----------
    if (step == 0 || step == 4 || step == 8 || step == 12) {
      kick.play();
    }

    // ---------- SNARE ----------
    if (step == 4 || step == 12) {
      snare.play();
    }

    // ---------- HIHAT ----------
    if (random(1) > 0.2) {   // 80% chance
      hihat.play();
    }

    // ---------- PATTERN CHANGE ----------
    // First 4 bars
    if (bar < 4) {

      if (step == 10) {
        clap.play();
      }

      // Second 4 bars
    } else {

      if (step == 2 || step == 6 || step == 10 || step == 14) {
        clap.play();
      }

      // Extra kick variation
      if (step == 14) {
        kick.play();
      }
    }

    beatCount++;
  }

  // ---------- VISUALS ----------
  background(
    (beatCount * 15) % 255,
    (beatCount * 8) % 255,
    (beatCount * 20) % 255
    );

  fill(255);
  textSize(20);
  text("Beat: " + beatCount, 20, 30);

  // Circle pulse
  float size = 50 + sin(frameCount * 0.15) * 100;

  fill(
    random(255),
    random(255),
    random(255),
    150
    );

  circle(width/2, height/2, size);
}
