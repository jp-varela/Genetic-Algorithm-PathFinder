class organism{
int x, y;
float angle;
float[] genome;
int state; //0-Alive (-1)-Dead 1-Finish

organism()
{
 x = 50;
 y = 250;
 angle = 0;
 state = 0;
 genome = new float[1000];
}

int get_X()
{
  return x;
}

int get_Y()
{
  return y;
}

float get_angle()
{
  return angle;
}

void set_X(int xx)
{
  x = xx;
}

void set_Y(int yy)
{
  y = yy;
}

void set_angle(float ang)
{
  angle = ang;
}

void set_state(int state1)
{
  state = state1;
}

int get_state()
{
  return state;
}

void reset()
{
  x = 50;
  y = 250;
  state = 0;
  angle=0;
}


void handle_mov(int turn)
{
  angle = angle + genome[turn];
  x = x + int(2*cos(angle));
  y = y + int(2*sin(angle));
}


void random_genome()
{
  for(int i=0; i<1000; i++)
  {
     genome[i]=random(-0.2,0.2);
  }
}

float get_genome_index(int index)
{
    return genome[index];
}

float[] get_genome()
{
  return genome;
}

void set_genome(float[] g)
{
  for(int i=0; i<1000; i++)
    genome[i]=g[i];
}
    
void child(organism mom, organism dad, int team)
{
  float random1, random2;
  for(int i=0; i<1000; i++) //parents code
  {
    random1=random(0,1);
    if(random1<0.5)
      genome[i]=mom.get_genome_index(i);
    else
      genome[i]=dad.get_genome_index(i);
    random2=random(0,1);
    
    switch(team)
    {
      case 0:
        if(random2<0.001) //mutations
          genome[i]=random(-0.2,0.2);
          break;
      case 1:
        if(random2<0.002) //mutations
          genome[i]=random(-0.2,0.2);
          break;
      case 2:
        if(random2<0.005) //mutations
          genome[i]=random(-0.2,0.2);
          break;
      case 3:
        if(random2<0.01) //mutations
          genome[i]=random(-0.2,0.2);
          break;
      case 4:
        if(random2<0.02) //mutations
          genome[i]=random(-0.2,0.2);
          break;
      case 5:
        if(random2<0.05) //mutations
          genome[i]=random(-0.2,0.2);
          break;
      default:  //all the same tests
        if(random2<0.20) //mutations
          genome[i]=random(-0.2,0.2);
          break;
    }

  }
}

float compareTo(organism o)
{
     return(angle - o.angle);
}
    
    
}