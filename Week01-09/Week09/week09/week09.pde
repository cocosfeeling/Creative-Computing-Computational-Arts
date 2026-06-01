

// the player
float snakeX = 250;
float snakeY = 250;

float speed = 4;

// snake body
ArrayList<PVector> trail;

// food to eat
float foodX;
float foodY;
float foodSize = 25;

// Obstacles
float obstacleX;
float obstacleY;
float obstacleSize = 35;

// Score
int score = 0;
int foodEaten = 0;
int multiplier = 1;

// Timer
int gameTime = 45;
int startTime;

// Movement
boolean up, down, left, right;

// setup of the canvas
void setup()
{
  size(500, 500);
  smooth();

  trail = new ArrayList<PVector>();

  spawnFood();
  spawnObstacle();

  startTime = millis();
}

// gradient from week 1 and time
void draw()
{
  drawGradient();

  int elapsed = (millis() - startTime) / 1000;
  int timeLeft = gameTime - elapsed;

  if (timeLeft <= 0)
  {
    gameOver();
    return;
  }

  updatePlayer();
  drawTrail();
  drawPlayer();

  drawFood();
  drawObstacle();

  checkFoodCollision();
  checkObstacleCollision();

  drawUI(timeLeft);
}

// gradient from week 1
void drawGradient()
{
  for (int y = 0; y < height; y++)
  {
    float inter = map(y, 0, height, 0, 1);

    color c = lerpColor(
      color(30, 30, 70),
      color(0, 180, 180),
      inter);

    stroke(c);
    line(0, y, width, y);
  }
}

// player ai disclaimer
void updatePlayer()
{
  if (up) snakeY -= speed;
  if (down) snakeY += speed;
  if (left) snakeX -= speed;
  if (right) snakeX += speed;

  snakeX = constrain(snakeX, 0, width);
  snakeY = constrain(snakeY, 0, height);

  trail.add(new PVector(snakeX, snakeY));

  int maxTrail = foodEaten * 3 + 10;

  if (trail.size() > maxTrail)
  {
    trail.remove(0);
  }
}

// tail - ai disclaimer
void drawTrail()
{
  noStroke();

  for (int i = 0; i < trail.size(); i++)
  {
    PVector p = trail.get(i);

    float s = map(i, 0, trail.size(), 4, 16);

    fill(0, 200, 100, 150);
    ellipse(p.x, p.y, s, s);
  }
}

// player setup
void drawPlayer()
{
  fill(50, 255, 100);
  stroke(255);
  strokeWeight(2);

  ellipse(snakeX, snakeY, 20, 20);
}

// food
void drawFood()
{
  float pulse =
    foodSize +
    sin(frameCount * 0.1) * 6;

  noStroke();
  fill(0, 255, 0);

  ellipse(foodX, foodY, pulse, pulse);
}

// obstacles drawing
void drawObstacle()
{
  float pulse =
    obstacleSize +
    sin(frameCount * 0.08) * 3;

  noStroke();
  fill(255, 50, 50);

  ellipse(
    obstacleX,
    obstacleY,
    pulse + 10,
    pulse
    );
}

// section for checking the food 
void checkFoodCollision()
{
  float d =
    dist(snakeX, snakeY,
      foodX, foodY);

  if (d < 20)
  {
    score += 5 * multiplier;

    foodEaten++;

    if (foodEaten % 5 == 0)
    {
      multiplier *= 2;
    }

    spawnFood();
  }
}

// obstacle check
void checkObstacleCollision()
{
  float d =
    dist(
    snakeX,
    snakeY,
    obstacleX,
    obstacleY);

  if (d < 25)
  {
    score -= 10;

    spawnObstacle();
  }
}

// spawning food
void spawnFood()
{
  foodX = random(40, width - 40);
  foodY = random(40, height - 40);
}

// obstacles spawning
void spawnObstacle()
{
  obstacleX = random(40, width - 40);
  obstacleY = random(40, height - 40);
}

// score and multiplyer
void drawUI(int timeLeft)
{
  fill(255);

  textSize(18);

  text("Score: " + score, 20, 30);

  text("Multiplier: x" + multiplier, 20, 60);

  text("Time: " + timeLeft, 20, 90);

  text("Food: " + foodEaten, 20, 120);
}

// game over background
void gameOver()
{
  background(0);

  fill(255);

  textAlign(CENTER);

  textSize(36);
  text("GAME OVER", width/2, 180);

  textSize(24);
  text("Final Score: " + score,
    width/2,
    240);

  textSize(20);
  text("Food Eaten: " + foodEaten,
    width/2,
    280);
}

// arrow keys
void keyPressed()
{
  if (keyCode == UP)
    up = true;

  if (keyCode == DOWN)
    down = true;

  if (keyCode == LEFT)
    left = true;

  if (keyCode == RIGHT)
    right = true;
}

// for the arrow keys
void keyReleased()
{
  if (keyCode == UP)
    up = false;

  if (keyCode == DOWN)
    down = false;

  if (keyCode == LEFT)
    left = false;

  if (keyCode == RIGHT)
    right = false;
}
