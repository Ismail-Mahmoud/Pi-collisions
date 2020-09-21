int W = 1000, H = 600;
int x_axis = H - 20, y_axis = 20;
int collisions = 0;
Square sq1, sq2;

class Square{
  int L;
  double M;
  double V;
  double X, Y;
  double displayX;
  int R, G, B;
  
  Square(int sideLength, double mass, double velocity, double x, double y){
    L = sideLength;
    M = mass;
    V = velocity;
    X = x;
    Y = y;
    R = (int)random(255);
    G = (int)random(255);
    B = (int)random(255);
    
    displayX = X;
  }
  
  void Draw(){
    adjustDisplay();    
    fill(R, G, B);
    rect((float)displayX, (float)Y, (float)L, (float)L, 10, 10, 10, 10);
  }
  
  void updatePosition(){
    X += V;
    displayX = X;
    if(X < 0) displayX /= 5;
  }
}

void updateVelocities(){
  double m1 = sq1.M, v1 = sq1.V, _v1;
  double m2 = sq2.M, v2 = sq2.V, _v2;
  _v2 = (m1 * (2*v1 - v2) + m2 * v2) / (m1 + m2);
  _v1 = v2 - v1 + _v2;
  sq1.V = _v1;
  sq2.V = _v2;
}

void checkCollision(){
  double x1 = sq1.X, l1 = sq1.L, v1 = sq1.V;
  double x2 = sq2.X;
  if(x1 + l1 + v1 >= x2){
    updateVelocities();
    ++collisions;
  }
  else if(x1 + v1 <= y_axis){
    sq1.V *= -1;
    ++collisions;
  }
}

void adjustDisplay(){
  double x1 = sq1.X, l1 = sq1.L;
  double x2 = sq2.X;
  //if(x1 <= y_axis) sq1.displayX = y_axis;
  //if(x2 <= y_axis + l1) sq2.displayX = y_axis + l1; 
  if(x1 + l1 > x2 || x1 < y_axis){
    sq1.displayX = y_axis + 200 / collisions;
    sq2.displayX = y_axis + l1 + 200 / collisions;
  }
}

void setup(){
  size(1000, 600);
  int ratio = 10000;
  sq1 = new Square(100, 1, 0, W/4, x_axis-100-1);
  sq2 = new Square(200, ratio, -1, W/2, x_axis-200-1);
}

//double min1 = 999, min2 = 999;
void draw(){
  background(0);
  stroke(255);
  line(y_axis, 0, y_axis, H);
  line(0, x_axis, W, x_axis);
  sq1.Draw();
  sq2.Draw();
  checkCollision();
  sq1.updatePosition();
  sq2.updatePosition();
  fill(255);
  textFont(createFont("Arial",32,true));
  text("#Collisions: " + collisions, W - 270, 90);
  //println(sq1.X, sq2.X);
  //if(sq1.X < min1) min1 = sq1.X;
  //if(sq2.X < min2) min2 = sq2.X;
  //text("v1: " + nf((float)sq1.V, 0, 3) + ", v2: " + nf((float)sq2.V, 0, 3), W - 400, 100);
  //text("x1: " + nf((float)min1, 0, 3) + ", x2: " + nf((float)min2, 0, 3), W - 400, 150);
  smooth();
}
