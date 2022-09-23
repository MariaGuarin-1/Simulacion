class cir {
  PVector pos;
  PVector v;

  float rad, m;

  cir(float x, float y, float r_) {
    pos = new PVector(x, y);
    v = PVector.random2D();
    v.mult(3);
    rad = r_;
    m = rad*.1;
  }

  void update() {
    pos.add(v);
  }

  void checkBoundaryCollision() {
    if (pos.x > width-rad) {
      pos.x = width-rad;
      v.x *= -1;
    } else if (pos.x < rad) {
      pos.x = rad;
      v.x *= -1;
    } else if (pos.y > height-rad) {
      pos.y = height-rad;
      v.y *= -1;
    } else if (pos.y < rad) {
      pos.y = rad;
      v.y *= -1;
    }
  }

  void checkCollision(cir otro) {

    
    PVector distanVect = PVector.sub(otro.pos, pos);

    // Magnitud
    float distanVectMag = distanVect.mag();

   // Distancia minimima
    float minDistance = rad + otro.rad;

    if (distanVectMag < minDistance) {
      float distanceCorrection = (minDistance-distanVectMag)/2.0;
      PVector d = distanVect.copy();
      PVector correctionVector = d.normalize().mult(distanceCorrection);
      otro.pos.add(correctionVector);
      pos.sub(correctionVector);

      // angulo
      float theta  = distanVect.heading();
      // precalculate trig values
      float sine = sin(theta);
      float cosine = cos(theta);

      PVector[] bTemp = {
        new PVector(), new PVector()
      };

      bTemp[1].x  = cosine * distanVect.x + sine * distanVect.y;
      bTemp[1].y  = cosine * distanVect.y - sine * distanVect.x;

      // Rotación de velocidad
      PVector[] vTemp = {
        new PVector(), new PVector()
      };

      vTemp[0].x  = cosine * v.x + sine * v.y;
      vTemp[0].y  = cosine * v.y - sine * v.x;
      vTemp[1].x  = cosine * otro.v.x + sine * otro.v.y;
      vTemp[1].y  = cosine * otro.v.y - sine * otro.v.x;

  
      PVector[] vFinal = {  
        new PVector(), new PVector()
      };

      // Rotación de la velocidad final
      vFinal[0].x = ((m - otro.m) * vTemp[0].x + 2 * otro.m * vTemp[1].x) / (m + otro.m);
      vFinal[0].y = vTemp[0].y;

      // Rotación de la velocidad final
      vFinal[1].x = ((otro.m - m) * vTemp[1].x + 2 * m * vTemp[0].x) / (m + otro.m);
      vFinal[1].y = vTemp[1].y;

      
      bTemp[0].x += vFinal[0].x;
      bTemp[1].x += vFinal[1].x;

 
      PVector[] bFinal = { 
        new PVector(), new PVector()
      };

      bFinal[0].x = cosine * bTemp[0].x - sine * bTemp[0].y;
      bFinal[0].y = cosine * bTemp[0].y + sine * bTemp[0].x;
      bFinal[1].x = cosine * bTemp[1].x - sine * bTemp[1].y;
      bFinal[1].y = cosine * bTemp[1].y + sine * bTemp[1].x;

      otro.pos.x = pos.x + bFinal[1].x;
      otro.pos.y = pos.y + bFinal[1].y;

      pos.add(bFinal[0]);

      v.x = cosine * vFinal[0].x - sine * vFinal[0].y;
      v.y = cosine * vFinal[0].y + sine * vFinal[0].x;
      otro.v.x = cosine * vFinal[1].x - sine * vFinal[1].y;
      otro.v.y = cosine * vFinal[1].y + sine * vFinal[1].x;
    }
  }

  void display() {
    noStroke();
    fill(204);
    ellipse(pos.x, pos.y, rad*2, rad*2);
  }
}
