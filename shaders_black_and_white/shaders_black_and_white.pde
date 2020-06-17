PImage label;
PShape can;
float angle;

PShader bwShader;
PShader bwShader_lum;

PShader selShader;

void setup() {
  //size(640, 360, P3D);
  size(300, 300, P3D);
  label = loadImage("chrome.jpeg");
  can = createShape(RECT, 0, 0, 300, 300);
  can.beginShape(RECT);
  can.texture(label);
  can.endShape();
  
  bwShader = loadShader("texlightfrag.glsl");
  bwShader_lum = loadShader("texlightfragluma.glsl");
  
  selShader = bwShader;
}

void draw() {
  background(0);
  shader(selShader);
  shape(can);
}

void keyPressed() {
  //RGB
  if (key == '1') {
    selShader = bwShader;
  }
  //LUMA
  if (key == '2') {
    selShader = bwShader_lum;
  }
}
