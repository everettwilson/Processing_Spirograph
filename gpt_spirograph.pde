float R1 = 167  ;
float R2 = 123;
float d = 15;
float theta = 2;
//int w = 1200;
//int h = 1000;

int maxElements = 50000;  // Maximum number of elements to display
PVector[] elements = new PVector[maxElements];  // Circular buffer
int nextElementIndex = 0;  // Index to add the next element


void setup() {
  size(1000, 1000);
  background(255);
  noFill();
  frameRate(30000);
}

void draw() {
  float x1 = width / 2 + R1 * cos(theta);
  float y1 = height / 2 + R1 * sin(theta);
  float x2 = x1 + R2 * cos(theta * d / R1);
  float y2 = y1 + R2 * sin(theta * d / R1);
  
  elements[nextElementIndex] = new PVector(x2, y2);  // Add the new element to the circular buffer

  nextElementIndex = (nextElementIndex + 1) % maxElements;  // Move to the next index in a circular manner

  background(255);

  // Draw the elements
  int startIndex = (nextElementIndex + 1) % maxElements;  // Start from the next element
  for (int i = 0; i < maxElements - 1; i++) {
    int index = (startIndex + i) % maxElements;
    if (elements[index] != null && elements[(index + 1) % maxElements] != null) {
      float hu = map(i, 0, maxElements - 1, 0, 255);
      stroke(hu, 150, 255);
      line(elements[index].x, elements[index].y, elements[(index + 1) % maxElements].x, elements[(index + 1) % maxElements].y);
    }
  }

  theta += 0.01;
}


void keyPressed() {
  if (keyCode == 32) {  // Check if the space bar is pressed
    // Generate new random R1 and R2 values
    R1 = random(50, 200);  // Adjust the range as needed
    R2 = random(30, 100);  // Adjust the range as needed
    d = random(10,100);
    theta = random(TWO_PI);
    background(255);  // Clear the canvas
  }
}
