/* =========================================================
 * ====                   WARNING                        ===
 * =========================================================
 * The code in this tab has been generated from the GUI form
 * designer and care should be taken when editing this file.
 * Only add/edit code inside the event handlers i.e. only
 * use lines between the matching comment tags. e.g.

 void myBtnEvents(GButton button) { //_CODE_:button1:12356:
     // It is safe to enter your event code here  
 } //_CODE_:button1:12356:
 
 * Do not rename this tab!
 * =========================================================
 */
// Textfield to add the name of the event
public void textfield1_change1(GTextField source, GEvent event) { //CODE:textfield1:905434:

} //CODE:textfield1:905434:
// Slider to change the difficulty of an event
public void custom_slider1_change1(GCustomSlider source, GEvent event) { //CODE:custom_slider1:398991:

} //CODE:custom_slider1:398991:
// The button to add the events onto the calender
public int startOfnewMonth, addedIncriments; // Variables that needed to be public to be used by all functions
public void button1_click1(GButton source, GEvent event) { //CODE:button1:825285:
  // Adds events onto the calender and repeats them across several days
  String eventName = textfield1.getText(); //get text in textfield1    
    
  boolean newMonth = false;
  // Does not count if a day is blank 
  if(eventName != ""){
    int CurrentMonth = month;
    int CurrentYear = year;
    Event newEvent = new Event(eventName, custom_slider1.getValueI(), year, month, dayBeingShown, false); //create new event
    
    addEventToTXT(newEvent);
    
    Days[year-startingYear][month-1][dayBeingShown - 1].events.add(newEvent); //add event to the particular day
    for (int n = 0; n < lengthOfMonth(year, CurrentMonth); n++){ // The math for repeating events across days
      try{
        if (isValueInArray(n+1, difficulties[custom_slider1.getValueI() - 1])){
          if (dayBeingShown - 1 + n < lengthOfMonth(CurrentYear, CurrentMonth)){
            Days[year-startingYear][CurrentMonth - 1][dayBeingShown - 1 + n].events.add(newEvent);
          }
          else if ((dayBeingShown - 1) + (n+1)> lengthOfMonth(CurrentYear, CurrentMonth) && newMonth == false){ 
            newMonth = true;
            startOfnewMonth = ((dayBeingShown - 1) + (n+1)) - lengthOfMonth(CurrentYear, CurrentMonth) - 1;
            CurrentMonth = CurrentMonth + 1;
            if (CurrentMonth == 13){
              CurrentMonth = 1;
              CurrentYear += 1;  
            }
            Days[CurrentYear-startingYear][CurrentMonth - 1][startOfnewMonth].events.add(newEvent);
            addedIncriments = n - startOfnewMonth;
          }
          else if (newMonth == true){
            addedIncriments = n - startOfnewMonth - (lengthOfMonth(CurrentYear, CurrentMonth)- newEvent.firstDay);
            Days[CurrentYear-startingYear][CurrentMonth - 1][startOfnewMonth + addedIncriments - 1].events.add(newEvent);
          }
        }
      }
      catch(Exception e){}
    }
  }
  textfield1.setText(""); //reset text in textfield1
} //CODE:button1:825285:



// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI() {
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setMouseOverEnabled(false);
  surface.setTitle("Sketch Window");
  textfield1 = new GTextField(this, 100, 490, 450, 30, G4P.SCROLLBARS_NONE);
  textfield1.setPromptText("Enter event");
  textfield1.setOpaque(false);
  textfield1.addEventHandler(this, "textfield1_change1");
  custom_slider1 = new GCustomSlider(this, 600, 491, 120, 40, "grey_blue");
  custom_slider1.setShowValue(true);
  custom_slider1.setLimits(2, 1, 3);
  custom_slider1.setNbrTicks(3);
  custom_slider1.setStickToTicks(true);
  custom_slider1.setShowTicks(true);
  custom_slider1.setNumberFormat(G4P.INTEGER, 0);
  custom_slider1.setOpaque(false);
  custom_slider1.addEventHandler(this, "custom_slider1_change1");

  button1 = new GButton(this, 780, 480, 78, 40);
  button1.setText("Add");
  button1.setLocalColorScheme(GCScheme.GOLD_SCHEME);
  button1.addEventHandler(this, "button1_click1");
}


// Variable declarations 
// autogenerated do not edit
GTextField textfield1; 
GCustomSlider custom_slider1; 
GButton button1;
