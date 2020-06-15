import processing.video.*;
Movie video_clip;

// VARIABLE PARA LOS FOTOGRAMAS DEL VIDEO
PGraphics fotograma_original;
PGraphics fotograma_grises;
PGraphics fotograma_convolucion; 

// FOCUS
float[][] enfoque = {{  0, -1,  0},
                     { -1,  5, -1},
                     {  0, -1,  0}};

// EMBOSSMENT
float[][] realce = {{ -2, -1,  0},
                    { -1,  1,  1},
                    {  0,  1,  2}};

// SHARPEN
float[][] pulir = {{ -1, -1, -1},
                   { -1,  9, -1},
                   { -1, -1, -1}};

// EDGE ENHANCEMEN
float[][] realce_borde = {{  1,  1,  1},
                          {  1, -2,  1},
                          { -1, -1, -1}};

// EDGE DETECTION 
float[][] deteccion_borde = {{ -1, -1, -1},
                             { -1,  8, -1},
                             { -1, -1, -1}};


// VARIABLES GLOBALES
boolean bandera = false;
int opcion = 1;
String nombre_archivo = "video_prueba_02.mp4";

void setup() {
    size(1310, 380);
    fotograma_original    = createGraphics(640, 360);
    fotograma_grises      = createGraphics(640, 360);
    fotograma_convolucion = createGraphics(640, 360);
    video_clip = new Movie(this, nombre_archivo);
    video_clip.loop();
}

void draw() {

    video_original();
    
    if(!bandera){
        if(opcion == 1){
            escala_grises(fotograma_original, fotograma_grises, opcion);
        }
        if(opcion == 2) {
            escala_grises(fotograma_original, fotograma_grises, opcion);
        }
        if(opcion == 3) {
            escala_grises(fotograma_original, fotograma_grises, opcion);
        }
        if(opcion == 4) {
            escala_grises(fotograma_original, fotograma_grises, opcion);
        }
        if(opcion == 5) {
            escala_grises(fotograma_original, fotograma_grises, opcion);
        }
    } else {
        if(opcion == 1){
            video_convolucion(fotograma_original, fotograma_convolucion, enfoque);
        }
        if(opcion == 2) {
            video_convolucion(fotograma_original, fotograma_convolucion, realce);
        }
        if(opcion == 3) {
            video_convolucion(fotograma_original, fotograma_convolucion, pulir);
        }
        if(opcion == 4) {
            video_convolucion(fotograma_original, fotograma_convolucion, realce_borde);
        }
        if(opcion == 5) {
            video_convolucion(fotograma_original, fotograma_convolucion, deteccion_borde);
        }
    }
}

void mouseClicked() {
  if(bandera){
    bandera = false;
  }else{
    bandera = true;
  }
}

// CONTROLAR LOS TIPOS DE CAMBIOS DE TIPOS DE GRISES
// POR MEDIO DEL TECLADO
void keyPressed() {
    // False --> PROMEDIO RGB
    // True  --> ENFOQUE
    if(key == 'q'){
        opcion = 1;
    }
    // False --> LUMA
    // True --> REALCE
    if(key == 'w'){
        opcion = 2;
    }
    // False --> RGB-ROJO
    // True --> PULIR
    if(key == 'e'){
        opcion = 3;
    }
    // False --> RGB-VERDE
    // True --> REALCE BORDE
    if(key == 'r'){
        opcion = 4;
    }
    // False --> RGB-AZUL
    // True --> DETECCION BORDE
    if(key == 't'){
        opcion = 5;
    }
}

// PERMITE CORRER(LEER) EL VIDEO
void movieEvent(Movie m) {
    m.read();
}

// PINTA EL VIDEO ORIGINAL EN LA PARTE IZQUIERZA DEL CANVAS
void video_original(){
    fotograma_original.beginDraw();
    fotograma_original.image(video_clip, 0, 0);
    fotograma_original.endDraw();
    image(fotograma_original, 10, 10);
}

// PINTA EL VIDEO CONVERTIDO EN ESCALA DE GRISES EN LA PARTE DERECHA DEL CANVAS
void escala_grises(PGraphics fotograma, PGraphics grises, int opcion){
    fotograma_grises.beginDraw();
    fotograma_grises.image(video_clip, 0, 0);
    fotograma_grises.loadPixels();
    fotograma_grises = opcion_convertir_escala_grises(fotograma, opcion);
    fotograma_grises.updatePixels();
    fotograma_grises.endDraw();
    image(grises, 660, 10);

}

// CARGA EL FOTOGRAMA, RECORRE CADA PIXEL Y REALIZA LA CONVERSION A ESCALA DE GRIS
// SEGUN LA OPCION DIGITA EN EL TECLADO
PGraphics opcion_convertir_escala_grises(PGraphics fotograma, int metodo) {
    PGraphics fotograma_grises = fotograma;
    fotograma.loadPixels();
    for (int y = 0; y < fotograma.height; y++) {  
        for (int x = 0; x < fotograma.width; x++) {
            int recuperar_posicion = x + (y * fotograma.width);
            float color_gris = 0;
            if(metodo == 1) {
                color_gris = (red(fotograma.pixels[recuperar_posicion]) + green(fotograma.pixels[recuperar_posicion]) + blue(fotograma.pixels[recuperar_posicion])) / 3;
            }
            if(metodo == 2) {
                color_gris = ((0.21)*(red(fotograma.pixels[recuperar_posicion])) + ((0.72)*green(fotograma.pixels[recuperar_posicion])) + ((0.07)*blue(fotograma.pixels[recuperar_posicion])));
            }
            if(metodo == 3){
                color_gris = red(fotograma.pixels[recuperar_posicion]); 
            }
            if(metodo == 4){
                color_gris = green(fotograma.pixels[recuperar_posicion]); 
            }
            if(metodo == 5){
                color_gris = blue(fotograma.pixels[recuperar_posicion]); 
            }
            fotograma_grises.pixels[recuperar_posicion] = color(color_gris, color_gris, color_gris);
        }
    }
    fotograma_grises.updatePixels();
    return fotograma_grises;
}

// PINTA EL VIDEO CONVERTIDO EN ESCALA DE GRISES EN LA PARTE DERECHA DEL CANVAS
void video_convolucion(PGraphics fotograma_original, PGraphics fotograma_convolucion, float[][] m_filtro_1) {
    fotograma_convolucion.beginDraw();
    fotograma_convolucion.image(video_clip, 0, 0);
    fotograma_convolucion.loadPixels();
    fotograma_convolucion.pixels = convolucion(fotograma_original, fotograma_convolucion, m_filtro_1);
    fotograma_convolucion.updatePixels();
    fotograma_convolucion.endDraw();
    image(fotograma_convolucion, 660, 10);
}

// CARGA EL FOTOGRAMA Y PARA CADA PIXEL DEL FOTOGRAMA Y HACE LA CONVOLUCION SEGUN LA OPCION TECLEADA 
color[] convolucion(PGraphics ft_original, PGraphics ft_convolucion,   float[][] filtro) {
    color[] tmp = new color[ft_convolucion.pixels.length];
    for (int x = 0; x < ft_original.width; x++) {
        for (int y = 0; y < ft_convolucion.height; y++) {
            int rec_pos = x + (y*ft_original.width);
            tmp[rec_pos] = calcular_convolucion(ft_original, filtro, 3, x, y);
        }        
    }
    return tmp;
}

// REALIZA LA CONVOLUCION DADA LA MATRIZ FILTRO
color calcular_convolucion(PImage imagen, float[][] filtro, int size_filtro_matriz, int pix_x, int pix_y) {
    float rgb_red   = 0;
    float rgb_green = 0;
    float rgb_blue  = 0;
    int compensacion = size_filtro_matriz / 2;
    for (int i = 0; i < size_filtro_matriz; i++) {
        for (int j = 0; j < size_filtro_matriz; j++) {
            int tmp_x = pix_x + i - compensacion;   
            int tmp_y = pix_y + i - compensacion;
            int tmp = tmp_x + (tmp_y * imagen.width);
            
            tmp = constrain(tmp, 0, imagen.pixels.length - 1);
            
            rgb_red   += (red(imagen.pixels[tmp])   * filtro[i][j]);
            rgb_green += (green(imagen.pixels[tmp]) * filtro[i][j]);
            rgb_blue  += (blue(imagen.pixels[tmp])  * filtro[i][j]);
        }
    }
    rgb_red   = constrain(rgb_red,   0, 255);
    rgb_green = constrain(rgb_green, 0, 255);
    rgb_blue  = constrain(rgb_blue,  0, 255);

    return color(rgb_red, rgb_green, rgb_blue);
}