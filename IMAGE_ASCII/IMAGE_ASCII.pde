PGraphics pg;
// Clase img para manejo de imagen
PImage img;
PImage imagen_original;

// Tipo de dato primitivo para manejo de resolución
int resolucion = 3;

int ancho = 640;
int espacio = 10;
String nombre_imagen = "imagen_prueba_01.jpg";

// Arreglo para contener caracteres con el proposito de remplazamiento de pixeles
char[] ascii; 

void setup(){

    // Cargar imagen de prueba
    img = loadImage(nombre_imagen);
    imagen_original = loadImage(nombre_imagen);


    size(1310, 390);


    pg = createGraphics(1310, 390);
    
    // Establecer color de fondo y forma sin linea de contorno 
     background(255);
     fill(0);

    // Tamaño arreglo de caracteres que corresponde a valores de brillo
    ascii = new char[256];

    // Establecer cadena de caracteres
    String caracteres = "ª╔º¹╚³²-¤.¸',¬·*^`°+";
    // String caracteres = "nT#JCwfy325Fp6mqSghVd4EgXPGZbYkOA&8U$@KHDBWNMR0Q";
    

    // Asignacion de caracteres en cada posision del arreglo ascii
    for(int i=0; i<255; i++){        
        int indice = int(map(i, 0, 255 , 0, caracteres.length()));// Redimension de un rango de indices        
        ascii[i] = caracteres.charAt(indice);// Reasigna un caracter al areglo ascii dependiendo del indice
    }

    // Funcion para transformar imagen a codigo ascii
    
}


void draw() {

    pintar_imagen_original();
    
    asciify();
}

//==================================================================================================
void asciify(){
    //conversion a scala de grises
    img.filter(GRAY);
    img.loadPixels();

    //grabar el color de cada pixel en la imagen y remplazar esto con el caracter similar de brillo
    for(int y=0 + espacio; y < img.height + espacio; y += resolucion){
        for(int x=0 + ancho + espacio; x < img.width + + ancho + espacio; x += resolucion){
            color pixel = img.pixels[ (y-espacio) * img.width + (x-+ ancho - espacio)];
            text(ascii[int(brightness(pixel))], x, y);
        }
    } 
}

void pintar_imagen_original(){
    pg.beginDraw();
    pg.image(imagen_original, 0, 0);
    pg.endDraw();
    image(pg, espacio,espacio);
}

/*
REFERENCIAS

https://forum.processing.org/two/discussion/6830/interpret-image-as-ascii-text
https://forum.processing.org/two/discussion/14089/how-can-i-convert-an-image-into-text-instead-of-pixels

**/
