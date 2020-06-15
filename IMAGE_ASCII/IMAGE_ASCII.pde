//==================================================================================================
// Clase img para manejo de imagen
PImage img;

// Tipo de dato primitivo para manejo de resolución
int resolucion = 9;

// Arreglo para contener caracteres con el proposito de remplazamiento de pixeles
char[] ascii; 

//==================================================================================================
void setup(){

    // Cargar imagen de prueba
    img = loadImage("img3.jpg");

    // size(img.width, img.height) - Establecer el tamaño de la ventana
    size(1082, 624);
    // size(400, 400);

    // Establecer color de fondo y forma sin linea de contorno 
    background(255);
    fill(0);
    noStroke();

    // Tamaño arreglo de caracteres que corresponde a valores de brillo
    ascii = new char[256];

    // Establecer cadena de caracteres
    String caracteres = "MN@#$o;:,. ";
    // String caracteres = "nT#JCwfy325Fp6mqSghVd4EgXPGZbYkOA&8U$@KHDBWNMR0Q";
    

    // Asignacion de caracteres en cada posision del arreglo ascii
    for(int i=0; i<256; i++){        
        int indice = int(map(i, 0, 256, 0, caracteres.length()));// Redimension de un rango de indices        
        ascii[i] = caracteres.charAt(indice);// Reasigna un caracter al areglo ascii dependiendo del indice
    }

    // Utilizar tipo de fuente para los caracteres
    PFont fuente = createFont("Arial", resolucion + 2);
    textFont(fuente);

    // Funcion para transformar imagen a codigo ascii
    asciify();
}

//==================================================================================================
void asciify(){
    //conversion a scala de grises
    //img.filter(GRAY);
    img.loadPixels();

    //grabar el color de cada pixel en la imagen y remplazar esto con el caracter similar de brillo
    for(int y=0; y < img.height; y += resolucion){
        for(int x=0; x < img.width; x += resolucion){
            color pixel = img.pixels[ y * img.width + x];
            text(ascii[int(brightness(pixel))], x, y);
        }
    } 
}

/*
REFERENCIAS

https://forum.processing.org/two/discussion/6830/interpret-image-as-ascii-text
https://forum.processing.org/two/discussion/14089/how-can-i-convert-an-image-into-text-instead-of-pixels

**/
