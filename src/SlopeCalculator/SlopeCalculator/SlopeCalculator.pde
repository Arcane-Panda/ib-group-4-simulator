Button[] numButtons = new Button[10];
Button[] opButtons = new Button[3];

String angle, friction, rampLength;
float ans;
char op;
boolean left, equal;
int whichNumber;
int lDisplayText = 90;
int rDisplayText = 90;
boolean full = false;
boolean answerFound = false;
 Visualizer visualizer = new Visualizer(800,800);
void setup()
{
  size(1600, 900);
  background(#DAEBF2);
  ans = 0.0;
  angle =  "";
  friction = "";
  rampLength = "";
  op = ' ';
  left = true;
  equal = false;
  whichNumber = 1;
  
  numButtons[0] = new Button(20, 600, 97, 97).asNumber(0);
  numButtons[1] = new Button(20, 480, 97, 97).asNumber(1);
  numButtons[2] = new Button(150, 480, 97, 97).asNumber(2);
  numButtons[3] = new Button(270, 480, 97, 97).asNumber(3);
  numButtons[4] = new Button(20, 360, 97, 97).asNumber(4);
  numButtons[5] = new Button(150, 360, 97, 97).asNumber(5);
  numButtons[6] = new Button(270, 360, 97, 97).asNumber(6);
  numButtons[7] = new Button(20, 240, 97, 97).asNumber(7);
  numButtons[8] = new Button(150, 240, 97, 97).asNumber(8);
  numButtons[9] = new Button(270, 240, 97, 97).asNumber(9);
  
  opButtons[0] = new Button(150, 600, 97, 97).asOperator('.');
  opButtons[1] = new Button(390, 200, 97, 97).asOperator('c');
  opButtons[2] = new Button(270, 600, 97, 97).asOperator('=');
  
 
  
  text(ans, 20, 65);
}

void draw()
{
  background(#DAEBF2);
  for (int i = 0; i < numButtons.length; i++)
  {
    numButtons[i].display();
    numButtons[i].hover();
  }

  for (int i = 0; i < opButtons.length; i++)
  {
    opButtons[i].display();
    opButtons[i].hover();
  } 
  
  updateDisplay();
  fill(0);
  
  visualizer.display();
  
  textAlign(LEFT);
  textSize(15);
  if(answerFound)
  {
    text("Time to Reach the Bottom: " + angle + " seconds", 520, 50);
    visualizer.update();
  } else
  {
    text("Angle of Inclination: " + angle + "°", 520, 50);
  }
  
  if(whichNumber != 1)
  {
    text("Coefficient of Friction: " + friction, 520, 100);
  }
  if(whichNumber == 3)
  {
    text("Length of the ramp: " + rampLength + "m", 520, 150);
  }
  
  textAlign(RIGHT);
  
}

void mouseReleased()
{
  for (int i = 0; i < numButtons.length; i++)
  {
    if (!full)
    {
      if (numButtons[i].hov && whichNumber == 1)
      {
        angle += numButtons[i].value;
      } else if (numButtons[i].hov &&  whichNumber == 2)
      {
        friction += numButtons[i].value;
      } else if (numButtons[i].hov &&  whichNumber == 3)
      {
        rampLength += numButtons[i].value;
      }
    }
  }

  for (int i = 0; i < opButtons.length; i++)
  {
    if (opButtons[i].hov && opButtons[i].o == 'c')
    {
      clearCalc();
    } else if (opButtons[i].hov && opButtons[i].o == '=')
    {
      performCalc();
      full = false;
    } else if (opButtons[i].hov && opButtons[i].o == '.')
    {
      switch(whichNumber)
      {
        case 1:
          angle += opButtons[i].o;
          break;
          
        case 2:
          friction += opButtons[i].o;
          break;
        
        case 3:
          rampLength += opButtons[i].o;
          break;
      }
    }
  }
}

void updateDisplay()
{
  fill(#1CA5B8);
  stroke(1);
  rect(10, 10, 487, 150, 20);
  fill(255);
  textAlign(RIGHT);
  if (equal)
  {
    textSize(60);
    text((float) ans, 487, 130);
  } else
  {
    if (whichNumber == 1)
    {
      if (angle.length() >=  8)
      {
        lDisplayText = 60;
      }
      if (angle.length() >= 12)
      {
        lDisplayText = 30;
      }
      if (angle.length() >= 24 )
      {
        full = true;
      }
      textSize(lDisplayText);
      text(angle, 487, 130);
    } else if(whichNumber == 2)
    {
      if (friction.length() >=  8)
      {
        rDisplayText = 60;
      }
      if (friction.length() >= 12)
      {
        rDisplayText = 30;
      }
      if (friction.length() == 24 )
      {
        full = true;
      }
      textSize(rDisplayText);
      text(friction, 487, 130);
    } else
    {
      if (rampLength.length() >=  8)
      {
        rDisplayText = 60;
      }
      if (rampLength.length() >= 12)
      {
        rDisplayText = 30;
      }
      if (rampLength.length() == 24 )
      {
        full = true;
      }
      textSize(rDisplayText);
      text(rampLength, 487, 130);
    }
  }
}

void clearCalc()
{
  angle =  "";
  friction = "";
  rampLength = "";
  ans = 0.0;
  op = ' ';
  left = true;
  equal = false;
  full = false;
  answerFound = false;
  visualizer.reset();
}

void performCalc()
{
  
  if(whichNumber == 1)
  {
    whichNumber = 2;
  } else if (whichNumber == 2)
  {
    whichNumber = 3;
  } else
  {
    
   
   //ans = sqrt( (9.81 * (sin(float(angle)*(PI/180)) - (float(friction) * cos(float(angle)*(PI/180)))))/(2 * float(rampLength)));
   ans = sqrt( (2 * float(rampLength))/(9.81 * (sin(float(angle)*(PI/180)) - (float(friction) * cos(float(angle)*(PI/180))))));
   
   visualizer.calculateVelocity(ans);
   
     angle = str((float)ans);
     answerFound = true;
   
   whichNumber = 1;
  }
  /*
  switch(op)
  {
  case '+':
    ans = float(ls) + float(rs);
    ls = str((float)ans);
    left = true;
    break;

  case '/':
    ans = float(ls) / float(rs);
    ls = str((float)ans);
    left = true;
    break;

  case '*':
    ans = float(ls) * float(rs);
    ls = str((float)ans);
    left = true;
    break;

  case '-':
    ans = float(ls) - float(rs);
    ls = str((float)ans);
    left = true;

  case '^':
    ans = pow(float(ls), float(rs));
    ls = str((float)ans);
    left = true;

    break;
    
  }
  */
}
