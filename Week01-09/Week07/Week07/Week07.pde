import processing.sound.*;

SawOsc saw;
TriOsc tri;
SinOsc sin;

LowPass filter;

float freqMod;

void setup() {

  size(600,400);

  saw = new SawOsc(this);
  tri = new TriOsc(this);
  sin = new SinOsc(this);

  filter = new LowPass(this);

  filter.process(saw);

  saw.amp(0.3);
  tri.amp(0.2);
  sin.amp(0.1);

  saw.play();
  tri.play();
  sin.play();
}

void draw() {

  background(0);

  // frequency mod
  freqMod = sin(frameCount * 0.02);

  saw.freq(80 + freqMod * 30);
  tri.freq(220 + freqMod * 50);
  sin.freq(800 + freqMod * 100);

  // slow filter change
  float cutoff =
    map(
      sin(frameCount * 0.005),
      -1,
      1,
      300,
      5000
      );

  filter.freq(cutoff);

  fill(255);
  text("ominous....landing",20,20);
}
