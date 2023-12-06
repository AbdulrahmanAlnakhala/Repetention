// Calendar Algorithm 
int weekMonthStarter(int year, int month) {
  int daysSincestartingYear = 0;
  boolean leapYear; 

  for (int i = 0; i < year; i++) {
    leapYear = (i % 4 == 0) && !(i % 100 == 0);

    if (leapYear)
      daysSincestartingYear += 2; // If a leap year    
    
    else
      daysSincestartingYear += 1;    
  }

  for(int i = 0; i < 12; i++) {
    if(month > i + 1)
      daysSincestartingYear += monthLengths[i];
  }

  if ((year % 4 == 0) && !(year % 100 == 0) && (month > 2))
    daysSincestartingYear += 1;

  int dayOfTheWeek = ((daysSincestartingYear + 5) % 7);

  return dayOfTheWeek;
}

// Returns length of month
int lengthOfMonth(int year, int month) {
  int monthLength = 0;
  boolean leapYear = (year % 4 == 0) && !(year % 100 == 0);

  monthLength = monthLengths[month - 1];

  if (leapYear && (month == 2))
      monthLength += 1;

  return monthLength;
}

// Returns name of month
String nameOfMonth(int month) {    
  return months[month - 1];
}

void mousePressed() {
  boolean firstJan = (year == startingYear) && (month == 1);
  boolean lastDay = (year == startingYear + yearAmt - 1) && (month == 12); //Prevents calendar from going out of bounds
  
  if ((dist(mouseX, mouseY, width - paddingX - imageSize/2.0, textHeight - imageSize/2.0) <= imageSize/2.0) && (DrawDayScreen == false) && !lastDay) {    
    month += 1;    
    if(month == 13) {
      month = 1;
      year += 1;
    }      
  } 
  
  else if ((dist(mouseX, mouseY, paddingX + imageSize/2.0, textHeight - imageSize/2.0) <= imageSize/2.0) && (DrawDayScreen == false) && !firstJan) {       
    month -= 1;
    if(month == 0) {
      month = 12;
      year -= 1;
    }    
  } 
}

void setupCalendar() { //This adds the proper days to all days
  for(int i = startingYear; i < startingYear + yearAmt; i++) {       //Goes through years after startingYear
    for(int j = 1; j <= 12; j++) {                                   //Goes through all months
      int weeks = amtOfWeeks(i, j);    
      
      daySizeX = (width-2*paddingX)/days;
      daySizeY = (height-2*paddingY)/weeks;
    
      int topLeftText = 1; //Number in the top left of each box when making calendar      
      int dayStarter = weekMonthStarter(i, j);      
      float y = paddingY;
    
      for (int w = 0; w < weeks; w++) {       
        float x = paddingX;      
        for (int d = 0; d < days; d++) {                
          if((lengthOfMonth(year, month) >= topLeftText - dayStarter) && (topLeftText - dayStarter > 0))
            Days[i - startingYear][j - 1][7*w + d - dayStarter] = new Day(x, y + calDownShift, daySizeX, daySizeY, topLeftText - dayStarter);                         
          
          topLeftText += 1;
          x += daySizeX;                
        }      
        y += daySizeY;
      }
    }
  }
}

int amtOfWeeks(int y, int m) {
  if (weekMonthStarter(y, m) + lengthOfMonth(y, m) > 35)
    return 6;
    
  else if (weekMonthStarter(y, m) + lengthOfMonth(y, m) > 28)
    return 5;
    
  else
    return 4;
}

void drawCalendar() {    
  button1.setVisible(false);
  custom_slider1.setVisible(false);
  textfield1.setVisible(false);
      
  stroke(255);
  textSize(18);
  fill(0, 129, 201);
  text(topScreenText, width/2.0, 30);
  
  textSize(60);
  fill(255);
  text(nameOfMonth(month) + " " + year, width/2.0, textHeight+10);
  
  rightArrow = loadImage("right-arrow-for-next-month.png");
  image(rightArrow, width - paddingX - imageSize, textHeight-imageSize/2.0 - 10, imageSize, imageSize);
  
  leftArrow = loadImage("left-arrow-for-previous-month.png");
  image(leftArrow, paddingX, textHeight - imageSize/2.0 - 10, imageSize, imageSize);        
  
  textSize(10);
  stroke(0);
  fill(0);
  
  int weekAmt = amtOfWeeks(year, month);
  daySizeX = (width-2*paddingX)/days;
  daySizeY = (height-2*paddingY)/weekAmt;
  
  //Draws white squares before first day of month
  for(int i = 0; i < weekMonthStarter(year, month); i++) {
    fill(255);
    rectMode(CORNERS);      
    rect(paddingX + i*daySizeX, paddingY + calDownShift, paddingX + (i + 1)*daySizeX, paddingY + daySizeY + calDownShift);
  }
  
  //Draws white squares after first day of month
  for(int i = 7*weekAmt - lengthOfMonth(year, month); i < 7*weekAmt; i++) {
    int xPos = i % 7;
    fill(255);
    rectMode(CORNERS);      
    rect(paddingX + xPos*daySizeX, paddingY + (weekAmt - 1)*daySizeY + calDownShift, paddingX + (xPos + 1)*daySizeX, paddingY + weekAmt*daySizeY + calDownShift);
  }
  
  //Draws calendar days
  for(int i = 0; i < lengthOfMonth(year, month); i++)  
    Days[year - startingYear][month - 1][i].DrawMe();  

  for (int i=0; i < 7; i++) {
    textSize(18);
    text(daysOfWeek[i], paddingX + daySizeX * (i + 0.5), 165);
  }
}


boolean isValueInArray(int value, int[] array) {
    for (int i = 0; i < array.length; i++) {
        if (array[i] == value) {
            return true;
        }
    }
    return false;
}


void removeEvent(String eventName, Day day){
  for(int i = 0; i < day.events.size(); i++){
    if(day.events.get(i).name == eventName)
      day.events.remove(i);
  }
}

void randomizeAffirmation(){
  topScreenText = affirmations[floor(random(0, affirmations.length))];
}
