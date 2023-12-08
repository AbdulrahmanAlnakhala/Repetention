import g4p_controls.*;
// Images and image information
PImage rightArrow, leftArrow, checkmark, xMark, emptyBucket, fullBucket;
int imageSize = 50;
int textHeight = 100;
// Spacing for everything 
float daySizeX, daySizeY;
float paddingX = 50;
float paddingY = 100;
int calDownShift = 80; //This pushes all of the calendar to be underneath the weekends/days texts

int days = 7;
int month = month();          // Makes month and year the current date
int year = year();            //For max efficiency, you can see up to 3 years in the future.
int startingYear = year;
int yearAmt = 10;           //This is why you can see three years into the future! Change if you want
int dayBeingShown = 1;

boolean DrawDayScreen = false;
boolean DrawOnce = true;

String[] months = {"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"};
int[] monthLengths = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
String[] daysOfWeek = {"Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"};

color circleCol = color(0, 129, 201);
color BucketListCircleCol = color(164,174,191);
color todayCol = color (200, 0, 50);
int circleSize = 20;
 // Difficulties for tasks and how many days they are repeated across
int[] easyDifficulty = {2,5,9,14};
int[] mediumDifficulty = {2,4,6,9,11,14};
int[] hardDifficulty = {2,4,6,8,10,14,16,20,24};

int[][] difficulties = {easyDifficulty, mediumDifficulty, hardDifficulty};

String[] affirmations = {"I'm Happy. Unbothered. Disciplined. Glowing.", "I am EXCITED about today.", "I am deliberate and afraid of nothing.", "Progress is never linear."}; 
String topScreenText = "Repetention 1.0: The Calendar You'll Never Forget.";

Day[][][] Days;

PrintWriter eventsTxt;

void setup() {
  size(1000, 600);
  createGUI();
  Days = new Day[yearAmt][12][31]; //Day class[years][months][days]
  textAlign(CENTER);
  setupCalendar();  
  addTXTEvents();
}


void draw() {
  background(204);
  if (!DrawDayScreen)
    drawCalendar();
    
  else  
    drawDayScreen(month, dayBeingShown);  //month, day  
}
