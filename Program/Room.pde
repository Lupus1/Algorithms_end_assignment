
/*  -- Room Class --
 *  this class handels all objects inside the room and the interactions between them 
 */

class Room {

  Plant plants[] = new Plant[3];
  WaterSystem waterSystem;
  WateringCan wateringCan;
  Glass glass;
  Windows windows;

  PVector position;
  PImage[] flowerImages = new PImage[5];
  PImage tulipImage;

  float windowSillHeight;
  PImage wateringCanImage;

  Room(PVector position) {
    this.position = position;

    windowSillHeight = height*7/8 + 30;
    for (int i = 0; i < flowerImages.length; i ++) {
      flowerImages[i] = loadImage("Flowers/flower" + i + ".png");
      flowerImages[i].resize(100, 0);
    }

    tulipImage = loadImage("tulip.png");
    tulipImage.resize(0, 300);

    windows = new Windows(new PVector(-width/4 - 20, 0), position);
    plants[0] = new Plant(width/2, height*3/4 + 60, 1, flowerImages, windows);
    plants[1] = new Plant(width/3, height*3/4 + 60, 1, flowerImages, windows);
    plants[2] = new Plant(width/3*2, height*3/4 + 60, 1, flowerImages, windows);

    glass = new Glass(new PVector(width*2/14, windowSillHeight), tulipImage);
    waterSystem = new WaterSystem(new PVector(position.x, windowSillHeight), width*3/4 + 150);

    wateringCanImage = loadImage("wateringCan.png");
    wateringCanImage.resize(0, 160);

    wateringCan = new WateringCan(new PVector(width*7/8 + wateringCanImage.height/2, windowSillHeight - wateringCanImage.height/2 - 60), waterSystem, wateringCanImage, windows);
  }

  void display() { //displays everything that is inside the room

    if (wateringCan.isOutside()) wateringCan.display(); //if the watering can is outside it will be displayed behind the background
    drawBackground();
    windows.display();

    for (Plant plant : plants) {
      plant.display();
    }
    waterSystem.display();
    glass.display();
    if (!wateringCan.isOutside()) wateringCan.display(); //if the watering can is inside it will be displayed in front of everything
  }

  void update() { //updates everything
    for (Plant plant : plants) {
      plant.update();
    }
    waterSystem.update(plants, glass);
    wateringCan.update();
    glass.update();
  }

  void clicked(float x, float y) { //manages if the user clicked
    windows.selectWindow(x, y);
    wateringCan.selectWateringCan(x, y);
  }

  void dragged(float x, float px, float y, float py) { //manages if the user dragged
    windows.moveWindow(x - px);
    wateringCan.moveWateringCan(x - px, y - py);
  }

  void released() { //manages if the user released
    windows.releaseWindow();
    wateringCan.releaseWateringCan();
  }

  void scroll(float scroll) {
    wateringCan.rotateWateringCanScroll(scroll);
  }

  void drawBackground() { //draws the background (the wall);
    pushMatrix();
    translate(position.x, position.y);
    rectMode(CENTER);

    //wall
    strokeWeight(width/8);
    stroke(195, 166, 142);
    fill(0, 0);
    rect(0, 0, width*7/8 + 100, height*7/8 + 135);

    //frame
    strokeWeight(20);
    stroke(255);
    fill(0, 0);
    rect(0, 0, width*3/4 + 80, height*3/4 + 40);

    //windowsill
    strokeWeight(20);
    stroke(191);
    rect(0, height*3/8 + 50, width*3/4 + 150, 20);    

    //reset strokeWeight
    strokeWeight(1);
    popMatrix();
  }
}
