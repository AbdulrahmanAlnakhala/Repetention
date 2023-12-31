// Calendar Algorithm that calculates where all the days are placed in the calender
int weekMonthStarter(int year, int month) { //Finds what day of the week a month in a year starts on
  int daysSinceStartingYear = 0;
  boolean leapYear; 

  for (int i = startingYear; i < year; i++) {
    leapYear = (i % 4 == 0) && !(i % 100 == 0);

    if (leapYear)
      daysSinceStartingYear += 2; // If a leap year    
    
    else
      daysSinceStartingYear += 1;    
  }

  for(int i = 0; i < 12; i++) {
    if(month > i + 1)
      daysSinceStartingYear += monthLengths[i];
  }

  if ((year % 4 == 0) && !(year % 100 == 0) && (month > 2))
    daysSinceStartingYear += 1;

  int dayOfTheWeek = ((daysSinceStartingYear + dayConstant) % 7); //This constant is found via a function near the bottom, it saves computing power :)

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
// Does the math for flipping through months, forwards and backwards, if the arrows are clicked
void mousePressed() {
  boolean firstJan = (year == startingYear) && (month == 1);
  boolean lastDay = (year == startingYear + yearAmt - 1) && (month == 12); //Prevents calendar from going out of bounds
  
  if ((dist(mouseX, mouseY, width - paddingX - imageSize/2.0, textHeight - imageSize/2.0) <= imageSize/2.0) && (drawDayScreen == false) && !lastDay) {    
    month += 1;    
    if(month == 13) {
      month = 1;
      year += 1;
    }      
  } 
  
  else if ((dist(mouseX, mouseY, paddingX + imageSize/2.0, textHeight - imageSize/2.0) <= imageSize/2.0) && (drawDayScreen == false) && !firstJan) {       
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
      
      daysizeX = (width-2*paddingX)/days;
      daysizeY = (height-2*paddingY)/weeks;
    
      int topLeftText = 1; //Number in the top left of each box when making calendar      
      int dayStarter = weekMonthStarter(i, j);      
      float y = paddingY;
    
      for (int w = 0; w < weeks; w++) {       
        float x = paddingX;      
        for (int d = 0; d < days; d++) {                
          if((lengthOfMonth(year, month) >= topLeftText - dayStarter) && (topLeftText - dayStarter > 0))
            Days[i - startingYear][j - 1][7*w + d - dayStarter] = new Day(x, y + calDownShift, daysizeX, daysizeY, topLeftText - dayStarter);                         
          
          topLeftText += 1;
          x += daysizeX;                
        }      
        y += daysizeY;
      }
    }
  }
}
// The amount of weeks that need to be drawn in the calender depending on the amount of days and where the last & first days are
int amtOfWeeks(int y, int m) {
  if (weekMonthStarter(y, m) + lengthOfMonth(y, m) > 35)
    return 6;
    
  else if (weekMonthStarter(y, m) + lengthOfMonth(y, m) > 28)
    return 5;
    
  else
    return 4;
}
// Draws the Calender that is shown at the beggining of the program
void drawCalendar() {    
  // Makes GUI elements disappear 
  button1.setVisible(false);
  custom_slider1.setVisible(false);
  textfield1.setVisible(false);
      
  stroke(255);
  textSize(18);
  fill(0, 129, 201);
  text(topScreenText, width/2.0, 30);
  textSize(60);
  fill(255);
  // Says what the current month is
  text(nameOfMonth(month) + " " + year, width/2.0, textHeight+10);
  // Adds arrow to go forwards in months
  rightArrow = loadImage("right-arrow-for-next-month.png");
  image(rightArrow, width - paddingX - imageSize, textHeight-imageSize/2.0 - 10, imageSize, imageSize);
  // Adds arrow to go backwards in mmonths
  leftArrow = loadImage("left-arrow-for-previous-month.png");
  image(leftArrow, paddingX, textHeight - imageSize/2.0 - 10, imageSize, imageSize);        
  
  textSize(10);
  stroke(0);
  fill(0);
  
  int weekAmt = amtOfWeeks(year, month);
  daysizeX = (width-2*paddingX)/days;
  daysizeY = (height-2*paddingY)/weekAmt;
  
  //Draws white squares before first day of month
  for(int i = 0; i < weekMonthStarter(year, month); i++) {
    fill(255);
    rectMode(CORNERS);      
    rect(paddingX + i*daysizeX, paddingY + calDownShift, paddingX + (i + 1)*daysizeX, paddingY + daysizeY + calDownShift);
  }
  
  //Draws white squares after first day of month
  for(int i = 7*weekAmt - lengthOfMonth(year, month); i < 7*weekAmt; i++) {
    int xPos = i % 7;
    fill(255);
    rectMode(CORNERS);      
    rect(paddingX + xPos*daysizeX, paddingY + (weekAmt - 1)*daysizeY + calDownShift, paddingX + (xPos + 1)*daysizeX, paddingY + weekAmt*daysizeY + calDownShift);
  }
  
  //Draws calendar days
  for(int i = 0; i < lengthOfMonth(year, month); i++)  
    Days[year - startingYear][month - 1][i].DrawMe();  

  for (int i=0; i < 7; i++) {
    textSize(18);
    text(daysOfWeek[i], paddingX + daysizeX * (i + 0.5), 165);
  }
}

// A function to check whether a value is located within an array or not
boolean isValueInArray(int value, int[] array) {
    for (int i = 0; i < array.length; i++) {
        if (array[i] == value) {
            return true;
        }
    }
    return false;
}

// Fuction to remove and event
void removeEvent(String eventName, Day day){
  for(int i = 0; i < day.events.size(); i++){
    if(day.events.get(i).name == eventName)
      day.events.remove(i);
  }
}
// Adds random affirmations to the top of the screen when used
void randomizeAffirmation(){
  topScreenText = affirmations[floor(random(0, affirmations.length))];
}
// Checks if there is a textfile located within files and if not, it creates a textfile
void addTXTEvents(){
  String[] eventsMemory = loadStrings("events.txt");
  if (eventsMemory == null){
    createWriter("events.txt");
  }
  // Makes all the events that are saved on the textfile and adds them to the calender
  else {
    for (int i = 0 ; i < eventsMemory.length; i++) {
      String[] eventInfo = split(eventsMemory[i], " "); //(eventName + " " + custom_slider1.getValueI() + " " + year + " " + month + " " + dayBeingShown);
      
      String eventName = eventInfo[0];
      int eventDifficulty = int(eventInfo[1]);
      int eventYear = int(eventInfo[2]);
      int eventMonth = int(eventInfo[3]);
      int eventDay = int(eventInfo[4]);
      boolean eventBucket = boolean(eventInfo[5]);
      
      int pseudoEventYear = int(eventInfo[2]);
      int pseudoEventMonth = int(eventInfo[3]);
      
      boolean newMonth = false;
     
      if(0 <= eventYear - startingYear && eventYear - startingYear < yearAmt){
        Event newEvent = new Event(eventName, eventDifficulty, eventYear, eventMonth, eventDay, eventBucket); //create new event
        
        Days[eventYear - startingYear][eventMonth - 1][eventDay - 1].events.add(newEvent); //add event to the particular day
        
        for (int n = 0; n < lengthOfMonth(eventYear, eventMonth); n++){
          try{  
            if (isValueInArray(n+1, difficulties[eventDifficulty - 1])){
              if (eventDay - 1 + n < lengthOfMonth(pseudoEventYear, pseudoEventMonth)){
                Days[eventYear - startingYear][eventMonth - 1][eventDay - 1 + n].events.add(newEvent);
              }
              
              else if ((eventDay - 1) + (n+1)> lengthOfMonth(pseudoEventYear, pseudoEventMonth) && newMonth == false){ 
                newMonth = true;
                startOfnewMonth = ((eventDay - 1) + (n+1)) - lengthOfMonth(pseudoEventYear, pseudoEventMonth) - 1;
                pseudoEventMonth = pseudoEventMonth + 1;
                if (pseudoEventMonth == 13){
                  pseudoEventMonth = 1;
                  pseudoEventYear += 1;  
                }
                Days[pseudoEventYear-startingYear][pseudoEventMonth - 1][startOfnewMonth].events.add(newEvent);
                addedIncriments = n - startOfnewMonth;
              }
              
              else if (newMonth == true){
                addedIncriments = n - startOfnewMonth - (lengthOfMonth(pseudoEventYear, pseudoEventMonth)- newEvent.firstDay);
                Days[pseudoEventYear-startingYear][pseudoEventMonth - 1][startOfnewMonth + addedIncriments - 1].events.add(newEvent);
              }
            }
          }
          catch(Exception e){}
        }  
      }
    }
  }
}
// Removes events that were previously added onto a textfile, in accordance with the user's changes
void removeEventFromTXT(Event e){
  String[] eventsMemory = loadStrings("events.txt");
  ArrayList<String> newEventsTXTFile = new ArrayList<String>();
  
  for (int i = 0 ; i < eventsMemory.length; i++) {
    String[] eventInfo = split(eventsMemory[i], " "); //(eventName + " " + custom_slider1.getValueI() + " " + year + " " + month + " " + dayBeingShown + " " + bucketList_YorN);
    boolean nameEqual = e.name.equals(eventInfo[0]);
    boolean difficultyEqual = e.difficulty == int(eventInfo[1]);
    boolean yearEqual = e.firstYear == int(eventInfo[2]);
    boolean monthEqual = e.firstMonth == int(eventInfo[3]);
    boolean dayEqual = e.firstDay == int(eventInfo[4]);
    boolean bucketEqual = e.bucketList_YorN == boolean(eventInfo[5]);
    
    if(nameEqual && difficultyEqual && yearEqual && monthEqual && dayEqual && bucketEqual){}
    
    else
      newEventsTXTFile.add(eventsMemory[i]);
  }
  
  eventsTxt = createWriter("events.txt");
  
  for(int i = 0; i < newEventsTXTFile.size(); i ++)
    eventsTxt.println(newEventsTXTFile.get(i));
  eventsTxt.flush();
}


// Adds events that were previously added onto a textfile, in accordance with the user's changes
void addEventToTXT(Event e){
  String[] eventsMemory = loadStrings("events.txt");
  ArrayList<String> newEventsTXTFile = new ArrayList<String>();
  
  for (int i = 0 ; i < eventsMemory.length; i++) 
    newEventsTXTFile.add(eventsMemory[i]);
  
  newEventsTXTFile.add(e.name + " " + e.difficulty + " " + e.firstYear + " " + e.firstMonth + " " + e.firstDay + " " + e.bucketList_YorN);
  
  eventsTxt = createWriter("events.txt");
  
  for(int i = 0; i < newEventsTXTFile.size(); i++)
    eventsTxt.println(newEventsTXTFile.get(i));
  eventsTxt.flush();
}


//Changes the event from a normal event to a bucketlist event in the textfile and saves it as so, in accordance to the user's changes
void changeBucketBoolean(Event e){
    String[] eventsMemory = loadStrings("events.txt");
  ArrayList<String> newEventsTXTFile = new ArrayList<String>();
  
  for (int i = 0 ; i < eventsMemory.length; i++) {
    String[] eventInfo = split(eventsMemory[i], " "); //(eventName + " " + custom_slider1.getValueI() + " " + year + " " + month + " " + dayBeingShown + " " + bucketList_YorN);
    boolean nameEqual = e.name.equals(eventInfo[0]);
    boolean difficultyEqual = e.difficulty == int(eventInfo[1]);
    boolean yearEqual = e.firstYear == int(eventInfo[2]);
    boolean monthEqual = e.firstMonth == int(eventInfo[3]);
    boolean dayEqual = e.firstDay == int(eventInfo[4]);
    boolean bucketEqual = e.bucketList_YorN == boolean(eventInfo[5]);
    
    if(nameEqual && difficultyEqual && yearEqual && monthEqual && dayEqual && bucketEqual){
      bucketEqual = !bucketEqual;
      
      if(bucketEqual)      
        newEventsTXTFile.add(eventInfo[0] + " " + eventInfo[1] + " " + eventInfo[2] + " " + eventInfo[3] + " " + eventInfo[4] + " " + "false");

      else
        newEventsTXTFile.add(eventInfo[0] + " " + eventInfo[1] + " " + eventInfo[2] + " " + eventInfo[3] + " " + eventInfo[4] + " " + "true");
    }
    
    else
      newEventsTXTFile.add(eventsMemory[i]);
  }
  
  eventsTxt = createWriter("events.txt");
  
  for(int i = 0; i < newEventsTXTFile.size(); i ++)
    eventsTxt.println(newEventsTXTFile.get(i));
  eventsTxt.flush();
}

int calcDayConstant(){ //This just calculates the day constant that will be added in the original weekMonthStarter function
  int daysSinceStartingYear = 0;
  boolean leapYear; 

  for (int i = 0; i < startingYear; i++) {
    leapYear = (i % 4 == 0) && !(i % 100 == 0);

    if (leapYear)
      daysSinceStartingYear += 2; // If a leap year    
    
    else
      daysSinceStartingYear += 1;    
  }

  for(int i = 0; i < 12; i++) {
    if(month > i + 1)
      daysSinceStartingYear += monthLengths[i];
  }

  if ((year % 4 == 0) && !(year % 100 == 0) && (month > 2))
    daysSinceStartingYear += 1;

  int dayOfTheWeek = (daysSinceStartingYear % 7);

  return dayOfTheWeek;
}
