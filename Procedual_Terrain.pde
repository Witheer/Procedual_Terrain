int columns, rows;
int scale = 5;
int w = 1600;
int h = 1600;
float flyY = 0;
float flyX = 0;


float[][] grid;
int[][] gColor;

void setup() {

  size(900, 900, P3D);

  columns = w / scale;
  rows = h / scale;

  grid = new float[columns][rows];
  gColor = new int[columns][rows];
  

}

void draw() {

  //Sets up the scene
  background(80, 200, 220);
  noStroke();

  //Rotates the mesh to to be at an angle/floor
  translate(width/2, height/2);
  rotateX(2*PI/5);

  translate(-w/2, -h/2 + 40);

  //Creates noise for terrain height
  float noiseY = flyY;
  for (int y = 0; y < rows; y++) {
    float noiseX = flyX;
    for (int x = 0; x < columns; x++) {

      grid[x][y] = map(noise(noiseX, noiseY), 0, 1, -120, 120);
      noiseX += 0.025;
    }
    noiseY += 0.025;
  }

  //Check for what direction to move terrain
  if (keyCode == UP) {
    flyY += -0.1;
  } else if (keyCode == DOWN) {
    flyY += 0.1;
  } else if (keyCode == RIGHT) {
    flyX += 0.1;
  } else if (keyCode == LEFT) {
    flyX += -0.1;
  }



  //generate terrain
  for (int y = 0; y < rows - 1; y++) {
    beginShape(TRIANGLE_STRIP);

    for (int x = 0; x < columns; x++) {
      fill(color(30, 120 + (grid[x][y] * 2), 20));
      vertex(x*scale, y*scale, grid[x][y]);
      vertex(x*scale, (y + 1)*scale, grid[x][y + 1]);
    }

    endShape(CLOSE);
  }


  //Generate Lakes
  for (int y = 0; y < rows - 1; y++) {
    beginShape(TRIANGLE_STRIP);

    for (int x = 0; x < columns; x++) {
      fill(color(30, 70, 300 + (grid[x][y] * 1.2)));
      vertex(x*scale, y*scale, -40);
      vertex(x*scale, (y + 1)*scale, -40);
    }

    endShape(CLOSE);
  }




}
