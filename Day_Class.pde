class Day {
  float x, y, SizeX, SizeY;
  int dayNum;
  color Colour;
  boolean SelectedOnce;
  ArrayList<Event> events = new ArrayList<Event>();
  
  Day(float x, float y, float SizeX, float SizeY, int dayN) {
    this.x = x;
    this.y = y;
    this.SizeX = SizeX;
    this.SizeY = SizeY;
    this.Colour = color(255);
    this.dayNum = dayN;
  }
  
  void mouseClicked() { 
    if (mouseX >= this.x && mouseX <= this.x + this.SizeX && mouseY >= this.y && mouseY <= this.y + this.SizeY) {
      this.Colour = color(255, 0, 0);     
    }
  }
  
  void DrawMe() {    
    //Detects if a day is clicked and opens the corresponding Day Screen to add, change, and look at events 
    if (DrawDayScreen == false) {
      if (mousePressed == true) {         
        for (int i = 0; i < lengthOfMonth(year, month); i++) {
          if (mouseX >= Days[year - startingYear][month - 1][i].x && mouseX <= Days[year - startingYear][month - 1][i].x + Days[year - startingYear][month - 1][i].SizeX ) {
            if (mouseY + calDownShift >= Days[year - startingYear][month - 1][i].y + Days[year - startingYear][month - 1][i].SizeY && mouseY + calDownShift <= Days[year - startingYear][month - 1][i].y + Days[year - startingYear][month - 1][i].SizeY*2) {                
              if (SelectedOnce == false && (Days[year - startingYear][month - 1][i].dayNum != 0)) {
                DrawDayScreen = true;                                    
                dayBeingShown = Days[year - startingYear][month - 1][i].dayNum;                
              }
              
              else if (SelectedOnce == true) {
                Days[year - startingYear][month - 1][i].Colour = color(255);
              }
            }
          }
        }        
      }
    }
    
    else
    // Makes the days white
      this.Colour = color(255);
    //Draws the individual days in the opening calender
    fill(this.Colour);
    rectMode(CORNERS);    
    rect(this.x, this.y, this.x+this.SizeX, this.y + this.SizeY);    
    
    // Draws a dot around the number of the current day
    fill(0);
    textSize(15);
    stroke(0);
    if(this.dayNum > 0){
      if((this.dayNum == day()) && (month == month()) && (year == year())  ){        
        noStroke();
        fill(todayCol);
        circle(this.x + 15, this.y + 15, 23);                        
        textSize(18);                
        fill(255);
        text(this.dayNum, this.x + 15, this.y + 20);
        fill(0);
        textSize(15);
        stroke(1);
      }
      
      else
      // Everyday other than the current day
        text(this.dayNum, this.x + 15, this.y + 20);             
    }
    // Draws a dot to indicate if there is an event on that day, normal or bucketlist
    boolean taskDot = false;
    boolean bucketDot = false;
    
    for(int i = 0; i < this.events.size(); i++){
      if(!this.events.get(i).bucketList_YorN && !bucketDot)          
        bucketDot = true;
      
      else if(this.events.get(i).bucketList_YorN && !taskDot)        
        taskDot = true;      
      
      if(taskDot && bucketDot)
        i = this.events.size();
    }
    // Makes it so that the dots are side by side if there are both normal tasks and bucketlist tasks
    if(taskDot && bucketDot){
      noStroke();
      fill(circleCol);
      circle(this.x + this.SizeX/1.5, this.y + this.SizeY/2.0, circleSize);      
      fill(BucketListCircleCol);
      circle(this.x + this.SizeX/3.0, this.y + this.SizeY/2.0, circleSize);              
      stroke(1);      
    }
    // Draws it in the middle if it is only a normal task
    else if(taskDot){
      fill(circleCol);
      noStroke();
      circle(this.x + this.SizeX/2.0, this.y + this.SizeY/2.0, circleSize);
      stroke(1);      
    }
    // Draws it in the middle if it is only a bucketlist task
    else if(bucketDot){
      fill(BucketListCircleCol);
      noStroke();
      circle(this.x + this.SizeX/2.0, this.y + this.SizeY/2.0, circleSize);
      stroke(1);
    }
  }
}
