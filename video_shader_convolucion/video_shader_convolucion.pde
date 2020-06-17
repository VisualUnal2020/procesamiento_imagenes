import processing.video.*; 
PImage img;
PShape can;
PShader texShader;
PGraphics fotograma_original;
float angle;
int value = 0;

Movie colorMovie;

void setup() {
  size(640, 360, P3D);
  colorMovie = new Movie(this, "video_prueba_02.mp4");
  colorMovie.loop();
  img = colorMovie;
  can = createCan(100, 200, 128, img);
}

void draw() {   
  texShader = loadShader("matrix.glsl");
  camera(width/2, height/2, 300, width/2, height/2, 0, 0, 1, 0);
  background(0);
  shader(texShader);
  
  //Matrices de convolución
  //Identity
  if(value==0){
  texShader.set("c0",0);
  texShader.set("c1",0);
  texShader.set("c2",0);
  texShader.set("c3",0);
  texShader.set("c4",1.0);
  texShader.set("c5",0);
  texShader.set("c6",0);
  texShader.set("c7",0);
  texShader.set("c8",0);
  println("Identity: "+ frameRate + ":fps");
  }
  //Enfoque
  if(value==1){
  texShader.set("c0", 0.0);
  texShader.set("c1",-1.0);
  texShader.set("c2", 0.0);
  texShader.set("c3",-1.0);
  texShader.set("c4", 5.0);
  texShader.set("c5",-1.0);
  texShader.set("c6", 0.0);
  texShader.set("c7",-1.0);
  texShader.set("c8", 0.0);
  println("Enfoque: "+ frameRate + ":fps");
  }
  //Realce
  if(value==2){
  texShader.set("c0",-2.0);
  texShader.set("c1",-1.0);
  texShader.set("c2", 0.0);
  texShader.set("c3",-1.0);
  texShader.set("c4", 1.0);
  texShader.set("c5", 1.0);
  texShader.set("c6", 0.0);
  texShader.set("c7", 1.0);
  texShader.set("c8", 2.0);
  println("Realce: "+ frameRate + ":fps");
  }
  //Pulir
  if(value==3){
  texShader.set("c0", -1.0);
  texShader.set("c1",-1.0);
  texShader.set("c2", -1.0);
  texShader.set("c3",-1.0);
  texShader.set("c4", 9.0);
  texShader.set("c5",-1.0);
  texShader.set("c6", -1.0);
  texShader.set("c7",-1.0);
  texShader.set("c8", -1.0);
  println("Pulir: "+ frameRate + ":fps");
  }
  //Realce de bordes
  if(value==4){
  texShader.set("c0", 1.0);
  texShader.set("c1", 1.0);
  texShader.set("c2", 1.0);
  texShader.set("c3", 1.0);
  texShader.set("c4", -2.0);
  texShader.set("c5", 1.0);
  texShader.set("c6", -1.0);
  texShader.set("c7", -1.0);
  texShader.set("c8", -1.0);
  println("Realce de bordes: "+ frameRate + ":fps");
  }
  //Deteccion_borde
  if(value==5){
  texShader.set("c0", -1.0);
  texShader.set("c1", -1.0);
  texShader.set("c2", -1.0);
  texShader.set("c3", -1.0);
  texShader.set("c4", 8.0);
  texShader.set("c5", -1.0);
  texShader.set("c6", -1.0);
  texShader.set("c7", -1.0);
  texShader.set("c8", -1.0);
  println("Deteccion Borde: "+ frameRate + ":fps");
  }
  
  translate(width/2, height/2);
  rotateY(angle);  
  shape(can);  
  angle += 0.01;
  
}

PShape createCan(float r, float h, int detail, PImage tex) {
  textureMode(NORMAL);
  PShape sh = createShape();
  sh.beginShape(QUAD_STRIP);
  sh.noStroke();
  sh.texture(tex);
  for (int i = 0; i <= detail; i++) {
    float angle = TWO_PI / detail;
    float x = sin(i * angle);
    float z = cos(i * angle);
    float u = float(i) / detail;
    sh.normal(x, 0, z);
    sh.vertex(x * r, -h/2, z * r, u, 0);
    sh.vertex(x * r, +h/2, z * r, u, 1);    
  }
  sh.endShape();
 
  return sh;
}

void movieEvent(Movie m) {
  m.read();
}

void keyPressed() {
  
    //Identity
    if(key == '0'){
        value = 0;
    }
    //Enfoque
    if(key == '1'){
        value = 1;
    }
    //Realce
    if(key == '2'){
        value = 2;
    }
    //Pulir
    if(key == '3'){
        value = 3;
    }
    //Realce de bordes
    if(key == '4'){
        value = 4;
    }
    //Deteccion_borde
    if(key == '5'){
        value = 5;
    }
}
