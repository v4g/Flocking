Flock f;
float prevTime = 0f,curTime;
float dir = 1f;
float wRadG = 1.2f;float wVm = 1.1f;
float wfc = -50.f; float MAX_WANDER = 600.0f;

boolean showRadii = false;
boolean showCenters = false;
boolean attraction = true;
boolean showPath = false;
boolean fCenter = true;
boolean fCollision = true;
boolean fVelocity = true;
boolean fWandering = true;
boolean clearScreen = true;
int len = 16;
void setup()
{
   size(850,850);
   f = new Flock();
}

void draw()
{
  curTime = millis();
  
  if(clearScreen)background(100,0,0);
  f.update();
  f.drawFlock();
  prevTime = curTime;
  footer();
  
}

void footer(){
  textSize(16);
  fill(255,255,255);
  String instructions1 = "<Change weights> ,/.: Flock Center "+String.format("%.2f", wRadG)+" ;/': Velocity Matching "+String.format("%.2f", wVm)+", [/]: Collision "+String.format("%.2f", wfc)+", k/l: Wandering "+MAX_WANDER;
  String instructions2 = "p/P: Toggle clear, o/O: Show Trail, f/F: Show Flock Centers, v/V: Show Flock Radius, c/C: Clear Screen";
  String footerText = "Flock centering : "+fCenter+" Velocity Matching: "+fVelocity+" Collision Avoidance : "+fCollision+" Wandering: "+fWandering;
  textSize(14);
  text(instructions1, 10, 790);
  textSize(16);
  text(instructions2, 10, 810);
  text(footerText, 10, 830);
}
