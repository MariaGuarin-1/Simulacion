float x = 100;
float y = 50;
float xv = 3;
float yv = 4;

void setup() {
  size(250, 250);
}

void draw() {
  background(64);
  ellipse(x, y, 20, 20);

  x += xv;
  y += yv;
  
  if (x < 0 || x > width) {
    xv *= -1;
  }

  if (y < 0  || y > height) {
    yv *= -1;
  }
}
