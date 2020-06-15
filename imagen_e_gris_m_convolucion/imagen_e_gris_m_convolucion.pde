// VARIABLE PARA MANEJAR LOS GRAFICOS
PGraphics pg;

// VARIABLE PARA LAS IMAGENES
PImage imagen_original;
PImage imagen_convertir_escala_grises;
PImage imagen_convolucion;

// --- MATRICES DE CONVOLUCION ---
// FOCUS
float[][] enfoque = {{  0, -1,  0},
                     { -1,  5, -1},
                     {  0, -1,  0}};
// EMBOSSMENT
float[][] realce  = {{ -2, -1,  0},
                     { -1,  1,  1},
                     {  0,  1,  2}};
// SHARPEN
float[][] pulir   = {{ -1, -1, -1},
                     { -1,  9, -1},
                     { -1, -1, -1}};
// EDGE ENHANCEMEN
float[][] realce_borde   = {{  1,  1,  1},
                            {  1, -2,  1},
                            { -1, -1, -1}};
// EDGE DETECTION 
float[][] deteccion_borde = {{ -1, -1, -1},
                             { -1,  8, -1},
                             { -1, -1, -1}};
// ---   ---

// INICIALIZACION DE LA VARIABLE OPCION CON LA CUAL
// SELECCIONA LA DIFERENTE CONVERSION A ESCALA DE GRISES
int opcion = 1;
boolean bandera = false;

// --- CONFIGURACION DE LAS VARIABLES INICIALES ---
// NOMBRE DEL ARCHIVO DE LA IMAGEN
String nombre_imagen = "imagen_prueba_02.jpg";
// TAMANO DE LA IMAGEN
int tamano_horizontal = 300;
int tamano_vertical = 300;
//ESPACIADO DEL DEL BORDE DE LA VENTANA CON RESPECTO A LA IMAGEN
int espacio_borde = 10;
// ---   --- 

void setup() {
    // TAMA#O DEL CANVAS
    size(630, 350);

    // CONFIGURACION DE LA VARIABLE (pg)
    pg = createGraphics(630, 350);

    // CARGAMOS LA IMAGEN ORIGINAL
    imagen_original = loadImage(nombre_imagen);

    // CARGAMOS UNA COPIA DE LA IMAGEN ORIGINAL
    imagen_convertir_escala_grises = loadImage(nombre_imagen);

    // CARGAMOS UNA COPIA DE LA IMAGEN ORIGINAL
    imagen_convolucion = loadImage(nombre_imagen);
}

void draw() {

    pintar_imagen_original();
    
    if(!bandera){
        if(opcion == 1){
            convertir_escala_grises(imagen_convertir_escala_grises, opcion);
        }
        if(opcion == 2){
            convertir_escala_grises(imagen_convertir_escala_grises, opcion);
        }
        if(opcion == 3){
            convertir_escala_grises(imagen_convertir_escala_grises, opcion);
        }
        if(opcion == 4){
            convertir_escala_grises(imagen_convertir_escala_grises, opcion);
        }
        if(opcion == 5){
            convertir_escala_grises(imagen_convertir_escala_grises, opcion);
        }
    } else {
        if(opcion == 1){
            convolucion(enfoque);
        }
        if(opcion == 2){
            convolucion(realce);
        }
        if(opcion == 3){
            convolucion(pulir);
        }
        if(opcion == 4){
            convolucion(realce_borde);
        }
        if(opcion == 5){
            convolucion(deteccion_borde);
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

void pintar_imagen_original(){
    pg.beginDraw();
    pg.image(imagen_original, 0, 0);
    pg.endDraw();
    image(pg, espacio_borde, espacio_borde);
}

void convertir_escala_grises(PImage imagen_modificar, int metodo_conversion){
    pg.beginDraw();
    // SE CARGAN LOS PIXELES DE LA IMAGEN ORIGINAL EN UN ARREGLO DE TAMA#O (ANCHO x ALTO) DE LA IMAGEN
    imagen_original.loadPixels();

    for (int y = 0; y < imagen_original.height; y++) {
        
        for (int x = 0; x < imagen_original.width; x++) {
            
            // SE CONVIERTE LA POSICION DEL PIXEL A MODIFICAR EN POSICION UN ARREGLO
            int posicion_arreglo = x + (y * imagen_original.width);

            float color_gris = 0;

            // METODOS DE CONVERSION A DIFERENTES ESCALAS DE GRISES SEGUN LA OPCION INGRESADA

            if(metodo_conversion == 1){
                // PROMEDIO RGB
                color_gris = ((red(imagen_original.pixels[posicion_arreglo]) + green(imagen_original.pixels[posicion_arreglo]) + blue(imagen_original.pixels[posicion_arreglo])) / 3);
            }

            if(metodo_conversion == 2){
                // LUMA
                color_gris = ((0.21) * red(imagen_original.pixels[posicion_arreglo])) + ((0.72) * green(imagen_original.pixels[posicion_arreglo])) + ((0.07) * blue(imagen_original.pixels[posicion_arreglo]));
            }

            if(metodo_conversion == 3){
                // RGB - ROJO
                color_gris = red(imagen_original.pixels[posicion_arreglo]);
            }

            if(metodo_conversion == 4){
                // RGB - VERDE
                color_gris = green(imagen_original.pixels[posicion_arreglo]);;
            }

            if(metodo_conversion == 5){
                // RGB - AZUL
                color_gris = blue(imagen_original.pixels[posicion_arreglo]);
            }

            // SE ALMACENA EL COLOR GRIS RESULTANTE DEL METODO DE CONVERSION
            // EN LA POSICION DEL ARREGLO DE LA IMAGEN A MODIFICAR
            imagen_modificar.pixels[posicion_arreglo] = color(color_gris, color_gris, color_gris);
        }
    }

    imagen_modificar.updatePixels();
    pg.image(imagen_modificar, 0, 0);
    pg.endDraw();
    image(pg, (tamano_horizontal + (espacio_borde*2)), espacio_borde);
}

void convolucion(float[][] matriz_filtro){
    pg.beginDraw();
    imagen_original.loadPixels();
    for (int x = 0; x < imagen_original.width; x++) {
        for (int y = 0; y < imagen_original.height; y++) {
            int posicion_arreglo = x + (y * imagen_original.width);
            color color_convolucion = calcular_convolucion(imagen_original, matriz_filtro, matriz_filtro.length, x, y);
            imagen_convolucion.pixels[posicion_arreglo] = color_convolucion;
        }
    }
    imagen_convolucion.updatePixels();
    pg.image(imagen_convolucion, 0, 0);
    pg.endDraw();
    image(pg, (tamano_horizontal + (2*espacio_borde)), espacio_borde);
}

color calcular_convolucion(PImage imagen, float[][] matriz_filtro, int tamano_matriz, int posicion_pinxel_x, int posicion_pinxel_y){
    float rgb_rojo  = 0;
    float rgb_verde = 0;
    float rgb_azul  = 0;

    int compensacion = tamano_matriz / 2;

    for (int i = 0; i < tamano_matriz; i++) {
        for (int j = 0; j < tamano_matriz; j++) {
            int tmp_x = posicion_pinxel_x + i - compensacion;
            int tmp_y = posicion_pinxel_y + j - compensacion;

            int posicion = tmp_x + (tmp_y * imagen.width);
            posicion = constrain(posicion, 0, imagen.pixels.length - 1);

            rgb_rojo  += (red(imagen.pixels[posicion])   * matriz_filtro[i][j]);
            rgb_verde += (green(imagen.pixels[posicion]) * matriz_filtro[i][j]);
            rgb_azul  += (blue(imagen.pixels[posicion])  * matriz_filtro[i][j]);
        }
    }

    rgb_rojo  = constrain(rgb_rojo,  0, 255);
    rgb_verde = constrain(rgb_verde, 0, 255);
    rgb_azul  = constrain(rgb_azul,  0, 255); 
    
    return color(rgb_rojo, rgb_verde, rgb_azul);
}
