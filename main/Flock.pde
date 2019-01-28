class Flock{
  int MAX_SIZE=100;
  Creature[] creatures = new Creature[MAX_SIZE];
  float dist[][] = new float[MAX_SIZE][MAX_SIZE];
  float fcRadius = 150; float fvRadius = 150;
  float faRadius = 10; float REPULSION = -1000f;
  
  float CHASE_DISTANCE = 50f;
            
  Flock()
  {
    for (int i = 0 ; i < MAX_SIZE; i++) creatures[i] = new Creature();
  }
  void update()
  {
    //update every creature
    for (int i = 0 ; i < len; i++)
    {  
      creatures[i].clearForce();
      if(fWandering)creatures[i].addForce(wandering());
    }
    updateDistances();
    if(mousePressed)if(attraction) attract(); else repel();
    if(fCenter)flockCentering();
    if(fVelocity)velocityMatching();
    if(fCollision)collisionAvoidance();
    for (int i = 0 ; i < len; i++)
      creatures[i].update();
    dir = dir * -1;
  }
  void drawFlock()
  {
    //draw every creature
    for (int i = 0 ; i < len; i++)
    { 
      if(showRadii){drawRadii(creatures[i].position);}
      creatures[i].drawCreature();
    }
  }
  void drawRadii(PVector pos)
  {
    noFill();stroke(0,200,0);
    ellipse(pos.x,pos.y,fcRadius,fcRadius);
    noFill();stroke(0,0,200);
    ellipse(pos.x,pos.y,faRadius,faRadius);
  }
  void updateDistances()
  {
    for (int i = 0; i< len; i++)
    {
      for (int j = i+1; j<len; j++)
      {
        dist[i][j] = creatures[i].position.dist(creatures[j].position);
        dist[j][i] = dist[i][j];
      }
    }
  }
  void flockCentering()
  {
    float wRad = wRadG;
    for (int i = 0; i< len; i++)
    {
      float n = 0;
      PVector centroid = new PVector(0,0,0);
      
      for (int j = 0; j<len; j++)
      {
        if(i == j) continue;
        if(dist[i][j]<fcRadius){
          n += fcRadius/dist[i][j];
          PVector p = PVector.sub(creatures[j].position,creatures[i].position);
          centroid.add(p.mult(fcRadius/dist[i][j]));  
        }
      }
      if(n>0)centroid.mult(1./n);
      if(showCenters){
      fill(0,0,255);ellipse(creatures[i].position.x+centroid.x,creatures[i].position.y+centroid.y,5,5);}
      creatures[i].addForce(PVector.mult(centroid,wRad));
    }
  }
  void attract()
  {
    float wRad = wRadG/2;
    for (int i = 0; i< len; i++)
    {
      PVector centroid = new PVector(mouseX-creatures[i].position.x,mouseY-creatures[i].position.y,0);
      creatures[i].addForce(PVector.mult(centroid,wRad));
    }
  }
  void velocityMatching()
  {
    for (int i = 0; i< len; i++)
    {
      float n = 0;
      PVector vDiff = new PVector(0,0,0);
        for (int j = 0; j<len; j++)
        {
          if(i == j) continue;
          if(dist[i][j]<fvRadius){
            n += fvRadius/dist[i][j];
            PVector p = PVector.sub(creatures[j].position,creatures[i].position);
            vDiff.add(p.mult(fvRadius/dist[i][j]));  
          }
        }
      
      if(n>0)vDiff.mult(1./n);
      creatures[i].addForce(vDiff.mult(wVm));
    }
  }
  void collisionAvoidance()
  {
    for(int i = 0; i < len; i++)
    {  
      for(int j = 0; j< len; j++)
      {
        if(i == j) continue;
        //use the orientation to form a semi-circle to check against
        if(dist[i][j] < faRadius){
          PVector p = PVector.sub(creatures[j].position, creatures[i].position);
          if(PVector.dot(creatures[i].velocity,p)>0){
            creatures[i].addForce(PVector.mult(p,wfc));
          }
        }
      }
      if(mousePressed && !attraction){
        PVector mousePos = new PVector(mouseX,mouseY,0f);
        PVector p = PVector.sub(mousePos,creatures[i].position);
        if(showCenters){noFill();  ellipse(mousePos.x,mousePos.y,2*CHASE_DISTANCE,2*CHASE_DISTANCE);}
        if(p.mag() < CHASE_DISTANCE)
        {
          creatures[i].addForce(PVector.mult(p,REPULSION));
        }
      }
    }
  }
  void repel()
  {
    for(int i = 0; i < len; i++)
    {  
      PVector mousePos = new PVector(mouseX,mouseY,0f);
      PVector p = PVector.sub(mousePos,creatures[i].position);
      if(showCenters){noFill();  ellipse(mousePos.x,mousePos.y,2*CHASE_DISTANCE,2*CHASE_DISTANCE);}
      if(p.mag() < CHASE_DISTANCE)
      {
        creatures[i].addForce(PVector.mult(p,REPULSION));
      }
    }
  }
  PVector wandering()
  {
    //float ranX = dir*10;
    //float ranY = dir*10;
    float ranX = -MAX_WANDER/2+random(MAX_WANDER);
    float ranY = -MAX_WANDER/2+random(MAX_WANDER);
    PVector wanderForce = new PVector(ranX,ranY,0);
    return wanderForce;
  }
  
  void randomize()
  {
    for(int i = 0; i < len; i++)
    {
      int x = 10+int(random(width-10));
      int y = 10+int(random(height-10));
      creatures[i].position.set(x,y,0);
    }
  }
  
}
