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
    if (DrawDayScreen == false) {
      if (mousePressed == true) {         
        for (int i = 0; i < lengthOfMonth(year, month); i++) {
          if (mouseX >= Days[year - startingYear][month - 1][i].x && mouseX <= Days[year - startingYear][month - 1][i].x + Days[year - startingYear][month - 1][i].SizeX ) {
            if (mouseY + calDownShift >= Days[year - startingYear][month - 1][i].y + Days[year - startingYear][month - 1][i].SizeY && mouseY + calDownShift <= Days[year - startingYear][month - 1][i].y + Days[year - startingYear][month - 1][i].SizeY*2) {                
              if (SelectedOnce == false && (Days[year - startingYear][month - 1][i].dayNum != 0)) {
                //Days[year - startingYear][month - 1][i].Colour = color(255,0,0);
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
      this.Colour = color(255);
    
    fill(this.Colour);
    rectMode(CORNERS);
    rect(this.x, this.y, this.x+this.SizeX, this.y + this.SizeY);    
    
    fill(0);
    textSize(15);
    stroke(0);
    if(this.dayNum > 0){
      text(this.dayNum, this.x + 5, this.y + 20);      
    }
    
    for(int i = 0; i < this.events.size(); i++){
      if(!this.events.get(i).bucketList_YorN){  
        fill(circleCol);
        noStroke();
        circle(this.x + this.SizeX/2.0, this.y + this.SizeY/2.0, circleSize);
        stroke(1);
        i = this.events.size();
      }
    }
  }
}
