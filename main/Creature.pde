class Creature{
  PVector position = new PVector();
  PVector velocity = new PVector();
  PVector totalForce = new PVector();
  PVector oldPos[] = new PVector[50]; int o_index; float oldUpdateTime = 0;
  PVector boidColor = new PVector(random(255),random(255),random(255));
  float mass;
  float size = 10f;
  float MAX_SPEED = 100f,MIN_SPEED = 50f;
  
  Creature(){
    float randX = -50+random(100); float randY = -50+random(100);
    position.set(400+randX,400+randY,0);
    velocity.set(1,0,0);
    totalForce.set(0,0,0);
    for(int o_index = 0; o_index< 50; o_index++)
      oldPos[o_index] = new PVector(position.x,position.y,position.z);
    o_index = o_index%50;
    mass = 1.0f;
  }
  
  void drawCreature()
  {
    //Draw a triangle
    fill(0,0,0); stroke(0,0,0);
    //ellipse(position.x,position.y,5,5);
    PVector orientation = velocity.copy().normalize();
    PVector e1 = PVector.add(position,PVector.mult(orientation,size));
    PVector e2 = PVector.add(position,(PVector.mult(orientation,size/2)).rotate(TWO_PI/3));
    PVector e3 = PVector.add(position,(PVector.mult(orientation,size/2)).rotate(2*TWO_PI/3));
    triangle(e1.x,e1.y,e2.x,e2.y,e3.x,e3.y);
    if(showPath){ 
      for(int i = o_index; i != ((50+o_index-1)%50) ;){
        fill(boidColor.x,boidColor.y,boidColor.z); stroke(boidColor.x,boidColor.y,boidColor.z);
        line(oldPos[i].x,oldPos[i].y,oldPos[(i+1)%50].x,oldPos[(i+1)%50].y);
        i = (i+1)%50;
      }
    }
  }
  
  void update()
  {
    float deltaT =(curTime - prevTime)/1000; 
    //float deltaT =0.1; 
    PVector a = PVector.mult(totalForce,1/mass);
    PVector newVelocity = PVector.add(velocity,PVector.mult(a,deltaT));
    if(newVelocity.mag() > MAX_SPEED) newVelocity = newVelocity.mult(MAX_SPEED/newVelocity.mag());
    if(newVelocity.mag() < MIN_SPEED) newVelocity = newVelocity.mult(MIN_SPEED/newVelocity.mag());
    PVector p_ = PVector.mult(PVector.mult(PVector.add(newVelocity,velocity),0.5),deltaT);
    PVector tempPos = PVector.add(position,p_);
    if(tempPos.x > width || tempPos.x < 0){  p_.x = -p_.x; newVelocity.x = -newVelocity.x; }
    if(tempPos.y > height || tempPos.y < 0){  p_.y = -p_.y; newVelocity.y = -newVelocity.y; }
    if((curTime - oldUpdateTime) > 100)
    {
      oldPos[o_index] = position.copy();
      oldUpdateTime = curTime;
      o_index = (o_index+1)%50;
    }
    position.add(p_);
    velocity = newVelocity;
  }
  
  void addForce(PVector f){ totalForce.add(f);}
  
  void clearForce()  {totalForce.set(0,0,0);}
}
