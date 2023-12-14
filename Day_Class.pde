class Day {
  float x, y, sizeX, sizeY;
  int dayNum;
  color colour;
  boolean selectedOnce;
  ArrayList<Event> events = new ArrayList<Event>();
  
  Day(float x, float y, float sizeX, float sizeY, int dayN) {
    this.x = x;
    this.y = y;
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    this.colour = color(255);
    this.dayNum = dayN;
  }
  
  void mouseClicked() { 
    if (mouseX >= this.x && mouseX <= this.x + this.sizeX && mouseY >= this.y && mouseY <= this.y + this.sizeY) {
      this.colour = color(255, 0, 0);     
    }
  }
  
  void DrawMe() {    
    //Detects if a day is clicked and opens the corresponding Day Screen to add, change, and look at events 
    if (drawDayScreen == false) {
      if (mousePressed == true) {         
        for (int i = 0; i < lengthOfMonth(year, month); i++) {
          if (mouseX >= Days[year - startingYear][month - 1][i].x && mouseX <= Days[year - startingYear][month - 1][i].x + Days[year - startingYear][month - 1][i].sizeX ) {
            if (mouseY + calDownShift >= Days[year - startingYear][month - 1][i].y + Days[year - startingYear][month - 1][i].sizeY && mouseY + calDownShift <= Days[year - startingYear][month - 1][i].y + Days[year - startingYear][month - 1][i].sizeY*2) {                
              if (selectedOnce == false && (Days[year - startingYear][month - 1][i].dayNum != 0)) {
                drawDayScreen = true;                                    
                dayBeingShown = Days[year - startingYear][month - 1][i].dayNum;                
              }
              
              else if (selectedOnce == true) {
                Days[year - startingYear][month - 1][i].colour = color(255);
              }
            }
          }
        }        
      }
    }
    
    else
    // Makes the days white
      this.colour = color(255);
    //Draws the individual days in the opening calender
    fill(this.colour);
    rectMode(CORNERS);    
    rect(this.x, this.y, this.x+this.sizeX, this.y + this.sizeY);    
    
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
      if(this.events.get(i).bucketList_YorN && !bucketDot)          
        bucketDot = true;
      
      else if(!this.events.get(i).bucketList_YorN && !taskDot)        
        taskDot = true;      
      
      if(taskDot && bucketDot)
        i = this.events.size();
    }
    // Makes it so that the dots are side by side if there are both normal tasks and bucketlist tasks
    if(taskDot && bucketDot){
      noStroke();
      fill(circleCol);
      circle(this.x + this.sizeX/1.5, this.y + this.sizeY/2.0, circleSize);      
      fill(bucketListCircleCol);
      circle(this.x + this.sizeX/3.0, this.y + this.sizeY/2.0, circleSize);              
      stroke(1);    
      fill(0);
    }
    // Draws it in the middle if it is only a normal task
    else if(taskDot){
      fill(circleCol);
      noStroke();
      circle(this.x + this.sizeX/2.0, this.y + this.sizeY/2.0, circleSize);
      stroke(1);     
      fill(0);
    }
    // Draws it in the middle if it is only a bucketlist task
    else if(bucketDot){
      fill(bucketListCircleCol);
      noStroke();
      circle(this.x + this.sizeX/2.0, this.y + this.sizeY/2.0, circleSize);
      stroke(1);
      fill(0);
    }
  }
}
