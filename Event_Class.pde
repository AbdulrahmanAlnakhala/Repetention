class Event{ 
  // Fields
  String name; // Name of a task
  int difficulty; // Difficulty of a task
  int firstYear, firstMonth, firstDay; // The time of the first day of an event
  boolean bucketList_YorN; // If task is a bucketlist
  // Constructor
  Event(String n, int d, int y, int m, int day, boolean bucket) {
  this.name = n;
  this.difficulty = d;
  this.firstYear = y;
  this.firstMonth = m;
  this.firstDay = day;
  this.bucketList_YorN = bucket;
  }
}
