import de.bezier.guido.*;
private static final int NUM_ROWS=25;
private static final int NUM_COLS=25;
private static final int NUM_MINES=16;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines= new ArrayList <MSButton>();

void setup ()
{
  size(500, 500);
  textAlign(CENTER, CENTER);

  // make the manager
  Interactive.make( this );
  buttons=new MSButton[NUM_ROWS][NUM_COLS];



  for (int i=0; i<NUM_ROWS; i++) {
    for (int j=0; j<NUM_COLS; j++) {
      buttons[i][j]=new MSButton(i, j);
    }
  }
  
   for (int i=0; i<NUM_MINES; i++) {
      setMines();
    }


}
public void setMines()
{
  //Go to line 26 and write the setMines() function. 
  //It should generate a random row and column number. 
  //Use the contains() function to check to see if the button
  //at that random row and col is already in mines. If it isn't then add it

  int r = (int)(Math.random()*NUM_ROWS);
  int c = (int)(Math.random()*NUM_COLS);
  if (!mines.contains(buttons[r][c])) {
    mines.add(buttons[r][c]);
  } else {
    setMines();
  }
}

public void draw ()
{
  background( 0 );
  if (isWon() == true)
    displayWinningMessage();
}
public boolean isWon()
{
  //your code here
  return false;
}
public void displayLosingMessage()
{
  //your code here
}
public void displayWinningMessage()
{
  //your code here
}
public boolean isValid(int r, int c)
{
  return !(r>=NUM_ROWS || c>=NUM_COLS || r <0 || c<0);
}
public int countMines(int row, int col)
{
  int numMines = 0;
  if (isValid(row-1, col-1) && mines.contains(buttons[row-1][col-1])) 
    numMines++;
  if (isValid(row-1, col) && mines.contains(buttons[row-1][col]))
    numMines++;
  if (isValid(row-1, col+1) && mines.contains(buttons[row-1][col+1]))
    numMines++;
  if (isValid(row, col-1) && mines.contains(buttons[row][col-1]))
    numMines++;
  if (isValid(row, col+1) && mines.contains(buttons[row][col+1]))
    numMines++;
  if (isValid(row+1, col-1) && mines.contains(buttons[row+1][col-1]))
    numMines++;
  if (isValid(row+1, col) && mines.contains(buttons[row+1][col]))
    numMines++;
  if (isValid(row+1, col+1) && mines.contains(buttons[row+1][col+1]))
    numMines++;    
    
    return numMines;
}
public class MSButton
{
  private int myRow, myCol;
  private float x, y, width, height;
  private boolean clicked, flagged;
  private String myLabel;

  public MSButton ( int row, int col )
  {
    width = 500/NUM_COLS;
    height = 500/NUM_ROWS;
    myRow = row;
    myCol = col; 
    x = myCol*width;
    y = myRow*height;
    myLabel = "";
    flagged = clicked = false;
    Interactive.add( this ); // register it with the manager
  }

  // called by manager
   public void mousePressed () 
  {
    clicked = true;
    if (mouseButton == RIGHT){
      flagged=!flagged;
   
      clicked=false;}
     else if (mines.contains(this)) {
      displayLosingMessage();
    } else if (countMines(myRow, myCol)>0) {
      setLabel(str(countMines(myRow, myCol)));
    }
    else{
   if(isValid(myRow,myCol-1) && !buttons[myRow][myCol-1].clicked)
                buttons[myRow][myCol-1].mousePressed();
            if(isValid(myRow,myCol+1) && !buttons[myRow][myCol+1].clicked)
                buttons[myRow][myCol+1].mousePressed();
            if(isValid(myRow-1,myCol) && !buttons[myRow-1][myCol].clicked)
                buttons[myRow-1][myCol].mousePressed();
            if(isValid(myRow+1,myCol) && !buttons[myRow+1][myCol].clicked)
                buttons[myRow+1][myCol].mousePressed();
            if(isValid(myRow+1,myCol-1) && !buttons[myRow+1][myCol-1].clicked)
                buttons[myRow+1][myCol-1].mousePressed();
            if(isValid(myRow+1,myCol+1) && !buttons[myRow+1][myCol+1].clicked)
                buttons[myRow+1][myCol+1].mousePressed();
            if(isValid(myRow-1,myCol+1) && !buttons[myRow-1][myCol+1].clicked)
                buttons[myRow-1][myCol+1].mousePressed();
            if(isValid(myRow-1,myCol-1) && !buttons[myRow-1][myCol-1].clicked)
                buttons[myRow-1][myCol-1].mousePressed();    }
  }
  public void draw () 
  {    
    if (flagged)
      fill(0);
    else if ( clicked && mines.contains(this) ) 
      fill(255, 0, 0);
    else if (clicked)
      fill( 200 );
    else 
    fill( 100 );

    rect(x, y, width, height);
    fill(0);
    text(myLabel, x+width/2, y+height/2);
  }
  public void setLabel(String newLabel)
  {
    myLabel = newLabel;
  }
  public void setLabel(int newLabel)
  {
    myLabel = ""+ newLabel;
  }
  public boolean isFlagged()
  {
    return flagged;
  }
}
