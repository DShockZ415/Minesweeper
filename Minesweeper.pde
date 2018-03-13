import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
private MSButton[][] buttons; //2d array of minesweeper buttons
public final static int NUM_ROWS=20;
public final static int NUM_COLS=20;
public final static int NUM_BOMBS=40;
private ArrayList <MSButton> bombs=new ArrayList<MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to declare and initialize buttons goes here
    buttons=new MSButton[20][20];
    for(int i=0;i<NUM_ROWS;i++){
      for(int k=0;k<NUM_COLS;k++)
        {
          buttons[i][k]=new MSButton(i,k);
        }
    }
    setBombs();
}
public void setBombs()
{
  while(bombs.size()<NUM_BOMBS)
  {
    int r=(int)(Math.random()*(NUM_ROWS-1));
    int c=(int)(Math.random()*(NUM_COLS-1));
    if(!bombs.contains(buttons[r][c])){
      bombs.add(buttons[r][c]);
      System.out.println(r+","+c);
    }
    }
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
 for(int r = 0; r < NUM_ROWS; r++)
   {
 for(int c = 0; c < NUM_COLS; c++)
   {
    if(!buttons[r][c].isClicked() == true && !bombs.contains(buttons[r][c]))
     {
      return false;
     }
   }
  }
  return true;
}
public void displayLosingMessage()
{
  for(int r = 0; r < NUM_ROWS; r++)
    {
     for(int c = 0; c < NUM_COLS; c++)
      {
       if(buttons[r][c].isClicked() && bombs.contains(buttons[r][c]))
         {
          buttons[r][c].marked = false;
          buttons[r][c].clicked = true;
          buttons[11][7].setLabel("L");
          buttons[11][8].setLabel("o");
          buttons[11][9].setLabel("s");
          buttons[11][10].setLabel("e");
          buttons[11][11].setLabel("r");
          buttons[11][12].setLabel("!");
         }
      }
 }
}
public void displayWinningMessage()
{
  text("Congrats!",200,200);
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
         width = 400/NUM_COLS;
         height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        clicked = true;
        if(keyPressed==true)
        {
          marked=!marked;
          if(marked==false)
          {
            clicked=false;
          }
        }
        else if(bombs.contains(this))
          displayLosingMessage();
        else if(countBombs(r,c)>0)
          setLabel("" + countBombs(r,c));
        else{
            if(isValid(r,c-1) && buttons[r][c-1].clicked == false)
                buttons[r][c-1].mousePressed();
            if(isValid(r,c+1) && buttons[r][c+1].clicked == false)
                buttons[r][c+1].mousePressed();
            if(isValid(r-1,c) && buttons[r-1][c].clicked == false)
                buttons[r-1][c].mousePressed();  
            if(isValid(r+1,c) && buttons[r+1][c].clicked == false)
                buttons[r+1][c].mousePressed();
            if(isValid(r+1,c+1) && buttons[r+1][c+1].clicked == false)
                buttons[r+1][c+1].mousePressed();
            if(isValid(r+1,c-1) && buttons[r+1][c-1].clicked == false)
                buttons[r+1][c-1].mousePressed();
            if(isValid(r-1,c-1) && buttons[r-1][c-1].clicked == false)
                buttons[r-1][c-1].mousePressed();    
            if(isValid(r-1,c+1) && buttons[r-1][c+1].clicked == false)
                buttons[r-1][c+1].mousePressed();
        }
    }

    public void draw () 
    {    
        if (marked)
            fill(0);
         else if( clicked && bombs.contains(this) ) 
             fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        if(r>=0&&r<NUM_ROWS&&c>=0&&c<NUM_COLS)
        return true;
        else
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        if(bombs.contains(buttons[row][col+1])&&isValid(row,col+1))
        numBombs++;
        if(bombs.contains(buttons[row+1][col+1])&&isValid(row+1,col+1))
        numBombs++;
        if(bombs.contains(buttons[row+1][col])&&isValid(row+1,col))
        numBombs++;
        if(bombs.contains(buttons[row][col-1])&&isValid(row,col-1))
        numBombs++;
        if(bombs.contains(buttons[row-1][col-1])&&isValid(row-1,col-1))
        numBombs++;
        if(bombs.contains(buttons[row-1][col])&&isValid(row-1,col))
        numBombs++;
        if(bombs.contains(buttons[row+1][col-1])&&isValid(row+1,col-1))
        numBombs++;
        if(bombs.contains(buttons[row-1][col+1])&&isValid(row-1,col+1))
        numBombs++;
        return numBombs;
    }
}