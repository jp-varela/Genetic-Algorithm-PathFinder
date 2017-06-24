//Teams Version of the PathFinder AI
//6 Teams
//Red, Green, Blue, Purple, Yellow, 

organism[][] generation = new organism[50][6]; 
int[][] goal_turn = new int[50][6];
float[][] goal_closest = new float[50][6];
float[][] top2_score = new float[2][6];
float[][] top1 = new float[6][1000];
float[][] top2 = new float[6][1000];
//IntList line[] = new IntList(); //graph line
ArrayList<IntList> line = new ArrayList<IntList>();
team leaderboard = new team();
float top_fitness[] = {0, 0, 0, 0, 0, 0};
int turn = 1;
int gen = 1;
int deads = 0;
int div = 0;

void setup() {
  size(1000, 650);
  for (int t=0; t<6; t++)
  {
    line.add(new IntList());
    top2_score[0][t]=0;
    top2_score[1][t]=0;
    for (int i = 0; i<50; i++) //NUM ORGANISMS
    {
      generation[i][t]= new organism();
      generation[i][t].random_genome();
      goal_turn[i][t]=1000;
      goal_closest[i][t]=1500;
    }
  }
}

void draw() {
  if (turn==1)
    println("-----Generation: "+gen+"-----");
  if(turn==200)
    leaderboard.reset_new_score();
    
  if (turn<1000) //MAX TURNS
  {
    background(150);
    noFill();
    rect(3, 3, 800, 494);

    //draw obstacles
    fill(#4D4C4B);
    //rect(300,100,100,300);
    //level1
    //level2
    //ellipse(300,150,250,400);
    //ellipse(600,450,250,400);
    //level3
    ellipse(180, 250, 30, 110);
    ellipse(220, 100, 30, 200);
    ellipse(220, 400, 30, 200);
    triangle(250, 247, 350, 247, 350, 150);
    triangle(250, 253, 350, 253, 350, 350);
    triangle(250+111, 250+160, 350+111, 150+160, 350+111, 350+160);
    triangle(250+111, 250-160, 350+111, 150-160, 350+111, 350-160);
    ellipse(420, 250, 70, 70);
    rect(500, 225, 200, 50);
    triangle(530, 220, 735, 250-120, 700, 220);
    triangle(530, 280, 735, 250+120, 700, 280);
    ellipse(420+140, 250-170, 80, 80);
    ellipse(420+140, 250+170, 80, 80);
    fill(150);


    //level 4
    //rect(3,5,800,225);
    //rect(3,270,800,225);
    
    //level5
    /*
    for(int x=0; x<20; x++)
    {
       rect(100,5+25*x,150,6);
       rect(260,20+25*x,150,6);
       rect(420,5+25*x,150,10);
       rect(580,20+25*x,150,10);
    }
*/
    //draw goal
    noStroke();
    fill(#FCBA00);
    ellipse(760, 250, 20, 20);
    stroke(0);

    //POSITION UPDATES
    for (int t=0; t<6; t++)
      for (int g = 0; g<50; g++) //NUM ORGANISMS
      {
        if (generation[g][t].get_state()==0)
        {
          generation[g][t].handle_mov(turn-1); 

          float dist;
          dist = dist(generation[g][t].get_X(), generation[g][t].get_Y(), 760, 250);
          if (dist<goal_closest[g][t])
            goal_closest[g][t]=dist;

          if (generation[g][t].get_X()>800 || generation[g][t].get_X()<3 || generation[g][t].get_Y()>494 || generation[g][t].get_Y()<3 || get(generation[g][t].get_X(), generation[g][t].get_Y())==#4D4C4B)
          {
            generation[g][t].set_state(-1);
            deads++;
            goal_turn[g][t]=turn;
          } else
          {
            if (get(generation[g][t].get_X(), generation[g][t].get_Y())==#FCBA00)
            {
              generation[g][t].set_state(1);
              goal_turn[g][t]=turn;
              deads++;
              println("goal in turn: "+turn);
            }
          }
        }
      }

    //DRAW ORGANISMS
    for (int t=0; t<6; t++)
      for (int g = 49; g>=0; g--) //NUM ORGANISMS
      {
        pushMatrix();
        translate(generation[g][t].get_X(), generation[g][t].get_Y());
        rotate(generation[g][t].get_angle()-PI/2);
        //switch(generation[g][t].get_state())
        switch(t) //change here team colors
        {
        case 0: //TEAM WHITE
          if (g<2) //1st 
            fill(#FCFCFC);
          else
            fill(#CBCBCB);
          break;
        case 1: //TEAM YELLOW
          if (g<2) //1st 
            fill(#FFFA6A);
          else
            fill(#FFEB08);
          break;
        case 2: //TEAM GREEN
          if (g<2) //1st
            fill(#7AFF71);
          else
            fill(#0DD300);
          break;
        case 3: //TEAM BLUE
          if (g<2) //1st 
            fill(#00E8FF);
          else
            fill(#0060E3);
          break;
        case 4: //TEAM PURPLE
          if (g<2) //1st 
            fill(#E98BFF);
          else
            fill(#C100ED);
          break;
        case 5: //TEAM RED
          if (g<2) //1st 
            fill(#FF6F6F);
          else
            fill(#FF0808);
          break;
        }
        triangle(-4, -8, +4, -8, 0, 8);
        popMatrix();
      }


    //draw data
    fill(0);
    noStroke();
    textSize(22);
    text("Generation: "+gen, 810, 30);
    //text("Fitness: "+top_fitness, 810, 60);
    text("Time Left: "+(1000-turn), 810, 60);
    text("Alive: "+(300-deads), 810, 90);
    text("--Leaderboard--", 810, 140);
    for (int t=0; t<6; t++)
    {
      fill(0);
      text("#"+(t+1), 810, (180+t*30));
      switch(t)
      {
      case 0: 
        fill(#CBCBCB); stroke(#CBCBCB); break;
      case 1: 
        fill(#FFEB08); stroke(#FFEB08); break;
      case 2: 
        fill(#0DD300); stroke(#0DD300); break;
      case 3: 
        fill(#0060E3); stroke(#0060E3);break;
      case 4: 
        fill(#C100ED); stroke(#C100ED); break;
      case 5: 
        fill(#FF0808); stroke(#FF0808); break;
      }
      text(leaderboard.get_name(t), 850, (180+leaderboard.get_position(t)*30));
      noFill();
      //draw graph
      beginShape();
      if(gen>3)
      {
        div=1000/(line.get(t).size()-1);
        curveVertex(-div,650-((line.get(t).get(0)-1600)/5));
        for(int j = 0; j < line.get(t).size(); j++)
        {
          curveVertex(div*(j),650-((line.get(t).get(j)-1600)/5));
        }
        curveVertex(1000+div,650-((line.get(t).get(line.get(t).size()-1)-1600)/5));
        endShape();
      }
  
      if(leaderboard.get_new_state(t))
        fill(#FA0000);
      else
        fill(0);
      text(int(top2_score[0][t]), 930, (180+leaderboard.get_position(t)*30));
    }
    //text("#1   5%   "+Math.round(top2_score[0][0]*100) / 100.0,810,170);

    /*
    text("Evolution:", 810, 150);
     //draw graph
     for(int t=0; t<6; t++)
     for (int j = 1; j <= line.get(t).size(); j++)
     {
     rect((180/line.get(t).size())*(j-1)+810,300,int(180/line.get(t).size()), -((line.get(t).get(j-1))));
     }
     */
    
    stroke(0);
    //check if last turn
    if (turn==999 || deads==300)
    {
      for (int t=0; t<6; t++)
      {
        for (int j=0; j<50; j++)  //fitness
        {
          //score = 1*(1500-final_dist)+0.5*(1500-closest_dist)+1*(1000-goal_turn)+0.5*(1000-lastmove_turn)
          float score;
          float final_dist = dist(generation[j][t].get_X(), generation[j][t].get_Y(), 760, 250);
          if (generation[j][t].get_state()==1) //got gold
          score = 1*(1500-final_dist)+0.5*(1500-final_dist)+1*(1000-goal_turn[j][t])+0.3*(1000-goal_turn[j][t]);
          else
            score = 1*(1500-final_dist)+0.5*(1500-goal_closest[j][t])+1*(1000-1000)+0.3*(1000-goal_turn[j][t]);
          //println(j+"-"+score+" (best:"+top2_score[0][t]);

          //if new top2
          if (score>top2_score[0][t]) //1st
          {
            top2_score[1][t]=top2_score[0][t];
            top2[t]=copy_genome(top1[t]);
            top2_score[0][t]=score;
            top1[t]=copy_genome(generation[j][t].get_genome());
            leaderboard.set_new_true(t);
          } else
            if (score>top2_score[1][t] && j!=0) //2nd
          {
            top2_score[1][t]=score;
            top2[t]=copy_genome(generation[j][t].get_genome());
          }
        }

        //update graph
        line.get(t).append((int(top2_score[0][t])));
        
        //top_fitness=top2_score[0];
        leaderboard.reset();
        for(int x=0; x<6; x++)
          leaderboard.update(top2_score[0][x],x);

        //new genome     
        generation[0][t].set_genome(top1[t]);
        generation[1][t].set_genome(top2[t]);
        for (int n=2; n<50; n++)
        {
          generation[n][t].child(generation[0][t], generation[1][t], 3); //change mutation of teams
        }

        //top2_score[0]=0;
        //top2_score[1]=0;
        for (int j=0; j<50; j++)
        {
          generation[j][t].reset();
          goal_turn[j][t]=1000;
          goal_closest[j][t]=1500;
        }
      }
      //reset things
      turn=0;
      deads=0;
      gen++;
    }
    //println("top1 score: "+top2_score[0]);
    //println("top2 score: "+top2_score[1]);

    turn++;
  }
}

float[] copy_genome(float[] old)
{
  float[] new_ = new float[1000];
  for (int i=0; i<1000; i++)
  new_[i]=old[i];
  return new_;
}