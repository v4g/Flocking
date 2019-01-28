void keyPressed()
{
  if(key == 'v' || key == 'V')    showRadii = !showRadii;
  if(key == 'f' || key == 'F')    showCenters = !showCenters;
  if(key == 'a' || key == 'A')    attraction = true;
  if(key == 'r' || key == 'R')    attraction = false;
  if(key == 'p' || key == 'P')    clearScreen = !clearScreen;
  if(key == 'o' || key == 'O')    showPath = !showPath;
  if(key == 'c' || key == 'C')    background(100,0,0);
  if(key == 's' || key == 'S')    f.randomize();
  if(key == '.' )    wRadG += 0.1f;
  if(key == ',' )    wRadG -= 0.1f;
  if(key == ']')    wfc += 1f;
  if(key == '[' )    wfc -= 1f;
  if(key == '\'' )    wVm += 0.1f;
  if(key == ';' )    wVm -= 0.1f;
  if(key == 'l' )    MAX_WANDER += 1f;
  if(key == 'k' )    MAX_WANDER -= 1f;
  if(key == '1' )    fCenter = !fCenter;
  if(key == '2' )    fVelocity = !fVelocity;
  if(key == '3' )    fCollision = !fCollision;
  if(key == '4' )    fWandering = !fWandering;
  if(key == '+' || key == '=')    len= min(len+1,100);
  if(key == '-')    len = max(len-1,0);
  if(key == ' ')    simulate = !simulate;
}
void mousePressed()
{
  float w = float(mouseX)/width;
  float h = float(mouseY)/height;
}
