// VARIABLE PARA MANEJAR LOS GRAFICOS
PGraphics pg;

// VARIABLE PARA LAS IMAGENES
PImage imagen_original;
PImage imagen_escala_grises;
PImage histograma;
PImage segmento_histograma;
PImage imagen_segmentada_grises;

// VARIABLE PARA LOS TEXTOS DE LAS IMAGENES
PFont texto_imagen;

// --- CONFIGURACION DE LAS VARIABLES INICIALES ---
// NOMBRE DEL ARCHIVO DE LA IMAGEN
String nombre_imagen = "imagen_prueba_02.jpg";
// TAMANO DE LA IMAGEN
int tamano_horizontal = 300;
int tamano_vertical = 300;
//ESPACIADO DEL DEL BORDE DE LA VENTANA CON RESPECTO A LA IMAGEN
int espacio_borde = 10;
// ---   --- 

// INICIALIZACION DE LA VARIABLE OPCION CON LA CUAL
// SELECCIONA LA DIFERENTE CONVERSION A ESCALA DE GRISES
int opcion = 1;

int valor_maximo_histograma;
int[] valores_histograma = new int[256];
int valor_posicion_mouse;
int inicio_segmento;
int fin_segmento;

void setup() {
    // TAMA#O DEL CANVAS
    size(940, 350);

    // CONFIGURACION DE LA VARIABLE (pg)
    pg = createGraphics(630, 350);

    // CARGAMOS LA IMAGEN ORIGINAL
    imagen_original = loadImage(nombre_imagen);

    // CARGAMOS UNA COPIA DE LA IMAGEN ORIGINAL
    imagen_escala_grises = loadImage(nombre_imagen);

    histograma = createImage(300, 300, RGB);

    segmento_histograma = createImage(300, 300, RGB);

}

void draw() {

    pintar_imagen_original();

    convertir_escala_grises(imagen_escala_grises, 2);

    valor_posicion_mouse = int(map(mouseX, 630, 920, 0, 255));
    inicio_segmento = valor_posicion_mouse;
    fin_segmento = valor_posicion_mouse + 20;

    dibujar_histograma();
    
    segmentar_imagen_grises();
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

            if(metodo_conversion == 2){
                // LUMA
                color_gris = ((0.21) * red(imagen_original.pixels[posicion_arreglo])) + ((0.72) * green(imagen_original.pixels[posicion_arreglo])) + ((0.07) * blue(imagen_original.pixels[posicion_arreglo]));
            }

            // SE ALMACENA EL COLOR GRIS RESULTANTE DEL METODO DE CONVERSION
            // EN LA POSICION DEL ARREGLO DE LA IMAGEN A MODIFICAR
            imagen_modificar.pixels[posicion_arreglo] = color(color_gris, color_gris, color_gris);
        }
    }

    imagen_modificar.updatePixels();
    pg.image(imagen_modificar, 0, 0);
    pg.endDraw();
    image(pg, (tamano_horizontal+ (espacio_borde*2)), espacio_borde);
}

void dibujar_histograma(){
    pg.beginDraw();
    histograma.loadPixels();

    for (int pisicion = 0; pisicion < histograma.pixels.length; pisicion++) {
        histograma.pixels[pisicion] = color(255, 255, 255);
    }

    histograma.updatePixels();
    pg.image(histograma, 0, 0);

    for (int i = 0; i < imagen_escala_grises.width; i++) {
        for (int j = 0; j < imagen_escala_grises.width; j++) {
            int brillo = int(brightness(imagen_escala_grises.get(i,j)));
            valores_histograma[brillo]++;
        }
    }

    valor_maximo_histograma = max(valores_histograma);
    pg.stroke(0);

    // for (int i = 0; i < histograma.width; i++) {
    //     int which = int(map(i, 0, histograma.width, 0, 255));
    //     int y = int(map(valores_histograma[which], 0, valor_maximo_histograma, histograma.height, 0));
    //     pg.line(i, histograma.height, i, y);
    // }

    for (int i = 0; i < histograma.width; i++) {
        int which = int(map(i, 0, histograma.width, 0, 255));
        int y = int(map(valores_histograma[which], 0, valor_maximo_histograma, histograma.height, 0));
        if(which > inicio_segmento && which < fin_segmento) {
            pg.stroke(0, 255, 0);
            pg.line(i, histograma.height, i, y);
        } else {
            pg.stroke(0);
            pg.line(i, histograma.height, i, y);
        }
    }

    pg.endDraw();
    image(pg, 630, 10);

}


void segmentar_imagen_grises(){
    // int valor_posicion_mouse = int(map(mouseX, 10, 920, 0, 255));
    // int inicio_segmento = valor_posicion_mouse;
    // int fin_segmento = valor_posicion_mouse + 40;
    
    pg.beginDraw();
    imagen_segmentada_grises = imagen_escala_grises;
    imagen_segmentada_grises.loadPixels();
    
    for (int i = 0; i < imagen_escala_grises.width; i++) {
        for (int j = 0; j < imagen_escala_grises.height; j++) {
            int posicion = i + (j * imagen_escala_grises.width);
            int brillo = int(brightness(imagen_escala_grises.get(i, j)));
            if(brillo > inicio_segmento && brillo < fin_segmento){
                imagen_segmentada_grises.pixels[posicion] = color(0, 255, 0);
            }
        }
    }

    imagen_segmentada_grises.updatePixels();
    pg.image(imagen_escala_grises, 0, 0);
    pg.endDraw();
    image(pg, (tamano_horizontal+ (espacio_borde*2)), espacio_borde);
}