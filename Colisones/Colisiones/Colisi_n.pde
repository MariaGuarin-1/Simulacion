// colisión circuferencias
 
cir[] Cir =  { 
  new cir(150, 420, 40), 
  new cir(500, 200, 60) 
};

void setup() {
  size(640, 360);
}

void draw() {
  background(51);

  for (cir b : Cir) {
    b.update();
    b.display();
    b.checkBoundaryCollision();
  }
  
  Cir[0].checkCollision(Cir[1]);
}
