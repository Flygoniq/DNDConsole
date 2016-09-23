int redBalls = 0;
int yellowBalls = 0;
int grayBalls = 0;
int blooBalls = 0;
int brownBalls = 0;
void updateStaminaBalls () {
  if (currentStam < 0) {
    redBalls -= currentStam;
    grayBalls = maxStam - redBalls;
  } else {
    yellowBalls = currentStam;
    grayBalls = maxStam - yellowBalls;
  }
  blooBalls = overStam;
  brownBalls = lockedStam;
}

void drawStaminaBalls() {
  int r = redBalls;
  int y = yellowBalls;
  int g = grayBalls;
  int bl = blooBalls;
  int br = brownBalls;
  int total = maxStam + overStam; // change later
  for (int i = 0, c = 0; i < 10; i++) {
    for (int j = 0; j < 3 && c < total; j++, c++) {
      if (r > 0) {
        fill(#FF0000);
        r--;
      } else if (y > 0) {
        fill(#FFFF00);
        y--;
      } else if (g > 0) {
        fill(#7C7C7C);
        g--;
      } else if (bl > 0) {
        fill(#0000FF);
        bl--;
      } else {
        fill(#A56969);
        br--;
      }
      ellipse(90 + i * 20, 130 + j * 20, 15, 15);
    }
  }
}