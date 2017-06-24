class team{
  float top_score[]={0,0,0,0,0,0};
  int team[]={0,1,2,3,4,5};
  boolean new_best[] = {false,false,false,false,false,false};
  //String[] team_name={"0.1%","0.2%","0.5%","1%","2%","5%"};
  String[] team_name={"White","Yellow","Green","Blue","Purple","Red"};
  team()
  {
    

  }
  
  //update(team, score) update final_pixel here
  //int update_pixel(team) return pixel para ir
  void reset()
  {
    for(int i=0; i<6; i++)
      top_score[i]=0;
  }
  
  void update(float new_score, int t)
  {
      for(int i=0; i<6; i++)
      {
         if(new_score>top_score[i])
         {
           for(int j=5; j>i; j--)
           {
             top_score[j]=top_score[j-1];
             team[j]=team[j-1];
           }
           top_score[i]=new_score;
           team[i]=t;
           return;
         }
      }
  }
  
  int get_position(int t)
  {
    for(int i=0; i<6; i++)
    {
      if(team[i]==t)
        return i;
    }
    return -1;
  }
  
  
  String get_name(int t)
  {
    return team_name[t];
  }
  
  void reset_new_score()
  {
     for(int i=0; i<6; i++)
       new_best[i]=false;
  }
  
  boolean get_new_state(int i)
  {
      return new_best[i];
  }
  
  void set_new_true(int i)
  {
     new_best[i]=true;
  }
}