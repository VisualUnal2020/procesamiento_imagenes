# Procesamiento De Imagenes

En este taller se desarrollan diferentes formas de procesamiento de imagenes, tanto por software (Processing) como por hardware (OpenGL Shading Language). En la parte de software (archivo.pde) se desarrollaran en varias fases, como lo son diferentes métodos de convertir imagenes a varias escalas de grises como tambien aplicando varias matrices de convolución las cuales dan dieferentes efectos a las imágenes como por ejemplo enfoque, realce, entre otros. Tambien se implementaran estos mismos métodos pero ahora con un pequeño video en el cual se tomara cada fotograma y realizaran las diferentes converciones y se podra observar los resultados. Ahora en la parte de hadware se haran las mismas pruebas tanto con imágenes como con videos pero en este caso se implementaran SHADERS (archivo.glsl), para hacer la comparación en rendimiento entre los recursos usados tanto por la CPU como por la GPU.

<br>
<br>

## Objetivos  

* Observar la diferencia entre las converciones a escalas de grises por el método **promedio RGB** y el método **LUMA**, para determinar cual es más fiel con la conservación de la luminosidad y detalles con respecto a la imagen o video original.  

* Obervar los efectos obtenidos al aplicar los filtros (matrices de convolución) tanto a las imagenes como al video y como estos pueden ser comparados con algunos efectos que emplean programas de edición y/o cámaras con diferentes lentes.  

* Por medio de un histrograma observar la cantidad (porcentaje) de los diferentes valores de grises luego de realizar la conversión de una imagen a escala de grises mediante el método **LUMA** y como estos se ven reflejados en la imagen convertida.  

* Observar la conversión de imagenes por medio de **codigo ASCII** y usando el filtro de escala de grises, y cuanto se conserva de la imagen original.

* Realizar la comparación entre el rendimiento entre la CPU y la GPU al ejecutar los ejercicios solo con **Processing** como con **OpenGL Shading Language**.

<br>
<br>

## Comenzando 🚀

Antes de ejecutar los ejercicios debemos tener tener las siguientes herramientas y algunas librerias instaladas (_dependiendo del sistema operativo_), las cuales mencionaremos a continuación al igual que su instalación.


### Pre-requisitos 📋

* **Processing**:  
    Es un lenguaje de programación y entorno de desarrollo integrado de código abierto basado en Java, de fácil utilización, y que sirve como medio para la enseñanza y producción de proyectos multimedia e interactivos de diseño digital.  
    
    Se puede descargar de su página oficial en el siguiente link:  
    [**DESCARGAR PROCESSING**](https://processing.org/download/)  
    
    Debemos elegir el archivo a descargar según las especificaciones de la arquitecura del procesador (32-bit ó 64-bit) y el sistema operativo instalado (Windows ,GNU/Linux).  

    **[WINDOWS]**  
    Luego de descargar el archivo (.zip), vamos a la carpeta donde se descargo, hacer click derecho sobre el archivo y descomprimirlo, lo cual nos generara una carpeta llamada ***processing-3.5.4***, ingresamos a esta carpeta y ejecutamos el archivo ***processing.exe*** haciendo doble clic sobre el mismo, esperamos un momento mientras carga y listo ya tenemos **Processing** funcionando en Windows.  
  

    **[GNU/Linux]**  
    Luego de descargar el archivo (.tgz), vamos a la carpeta donde se encuentra la descarga, hacemos clic derecho sobre el archivo y le damos extraer lo cual nos genera una carpeta llamada ***processing-3.5.4***, ingresamos a esta carpeta y dentro de la misma hacemos clic derecho y elegimos la opcion ***Abrir Terminal***, luego se nos abre la terminal la cual ya en la ruta de la carpeta en la que estamos en el modo grafico ejecutamos el siguiente comando:  


```  
    sudo sh install.sh 
````  

   Ahora buscamos en nuestro lanzador de aplicaciones o menu desplegable la aplicacion **Processing** y la abrimos. Ahora ya tenemos instalado **Processing** en GNU/Linux.

<br>
    
### Instalación de librería [video] 🔧

Para la instalación de la librería **video** seguimos las siguientes instrucciones (tanto para Windows como para GNU/Linux): abrimos la aplicación **Processing**, vamos a la barra de menu y damos clic en la opción **Tools** la cual nos abre un menu desplegable y damos clic en la opcion **Add Tool...**, posteriormente nos abre una nueva ventana con cuatro pestañas y vamos a la pestaña de **Libraries**, en el campo de busqueda (filtro) escribimos **video**, en los resultados buscamos la opción que dice **Video | GStreamer-based video library for Processing.**, la seleccionamos y en la parte inferior derecha damos clic en el botón **install**, esperamos un momento mientras instala la librería, luego reiniciamos la aplicación (cerramos y volvemos a abrir la aplicación).

***[Problemas instalación en GNU/Linux]***  
Distribuciones recientes GNU/Linux que emplean  **[gstreamer >= 1]**, requieren [**ESTA!!!**](https://github.com/gohai/processing-video/releases/tag/v1.0.2) versión alternativa de la librería de video. Descomprimir el archivo ***(.zip)*** en la carpeta de **libraries** del sketbook **(e.g., $HOME/sketchbook/libraries)**.  

<br>
<br>
  
## Ejecutando los ejercicios ⚙️

### Promedio RGB
Mediante el promedio RGB tomamos las componentes RED, GREEN y BLUE, se suman y se dividen entre 3 y este nuevo valor es el que reemplaza a todas las componentes con el mismo valor obteniendo asi una escala de gris.  

```
    color_gris = ((RED + GREEN + BLUE) / 3)  

    pixel = color(color_gris, color_gris, color_gris)
```
![Imagen_promedio_rgb](/imagenes/promedio_rgb.png)  

<br>

### LUMA
Este metodo de conversion a escala de grises nos permite conservar la luminosidad de la imagen, es decir conservar mas la fidelidad de la imagen original, en este caso teniendo en cuenta la proporcionalidad de las 3 componentes de RGB.

```
    color_gris = ((0.21 * RED) + (0.72 * GREEN) + (0.07 * BLUE))  

    pixel = color(color_gris, color_gris, color_gris)
```
![Imagen_LUMA](/imagenes/luma.png)  

<br>

### Histograma
Por medio del histograma se puede observar la cantidad de los diferentes rangos de la escala de grises que contiene una imagen. Cuando se desplaza el cursor dentro del histograma moviendolo horizontalmente, se observa gráficamente en la imagen de escala de grises en color verde donde se encuentran concentrados estos rangos. 

![Imagen_histograma](/imagenes/histograma.png)

<br>

### Conversion a ASCII  

![Imagen_ascii](/imagenes/imagen_ascii.png)

<br>

### Matrices de Convolución
A continuación vemos diferentes ejemplos de aplicar filtros a una imagen mediante las matrices de convolución:  

* **Enfoque**  
```
float[][] focus  = {{  0, -1,  0},
                    { -1,  5, -1},
                    {  0, -1,  0}};
```
![Imagen_enfoque](/imagenes/enfoque.png)  

<br>

* **Realce**  
```
float[][] embossment = {{ -2, -1,  0},
                        { -1,  1,  1},
                        {  0,  1,  2}};
```
![Imagen_realce](/imagenes/realce.png)  

<br>

* **Pulir**  
```
float[][] sharpen = {{ -2, -1,  0},
                     { -1,  1,  1},
                     {  0,  1,  2}};
```
![Imagen_pulir](/imagenes/pulir.png)  

<br>

* **Realce de bordes**  
```
float[][] edge_enhancement = {{  1,  1,  1},
                              {  1, -2,  1},
                              { -1, -1, -1}};
```
![Imagen_realce borde](/imagenes/realce_borde.png)  

<br>

* **Detectar bordes**  
```
float[][] edge_detection = {{ -1, -1, -1},
                            { -1,  8, -1},
                            { -1, -1, -1}};
```
![Imagen_detectar_borde](/imagenes/detectar_borde.png)

<br>
<br>

### Rendimiento  

Para realizar el análisis de el uso de la CPU y la GPU, se uso una computadora con las siguientes especificaciones:  

* Procesador: Intel Core i7-8790H
* Mem. RAM: 8GB
* Tarj. Gráfica: Nvidia 1050 Ti  
* Tarj. Integrada: Intel HUD Graphics 630

El video usado:

* Tamaño: 640x360 px 
* FPS: 60  

<br>
<br>  

Orden de los proesadores:  
```
    ||==========||==========||==========||==========||
    ||  CPU_00  ||  CPU_01  ||  CPU_02  ||  CPU_03  ||
    ||==========||==========||==========||==========||
    ||  CPU_04  ||  CPU_05  ||  CPU_06  ||  CPU_07  ||
    ||==========||==========||==========||==========||
    ||  CPU_08  ||  CPU_09  ||  CPU_10  ||  CPU_11  ||
    ||==========||==========||==========||==========||
```
<br>  

Condiciones iniciales del sistema antes de correr el video con las diferentes conversiones y convoluciones:  

![codiciones_iniciales](/imagenes/procesador_inicio.png)

<br>  

Rendimiento del procesador mientras se ejecuta con la imagen y convoluciones:  
![procesador_video_grises](/imagenes/procesador_imagen_gris_con.png)

<br>  

Ejecutando el video con la conversión a escala de grises (LUMA):  
![video_escala_grises](/imagenes/video_grises.png)  

<br>  

Rendimiento del procesador mientras se ejecuta el video:  
![procesador_video_grises](/imagenes/procesador_corriendo_video_grises.png)

<br>  


Ejecutando el video con matrices de convolución:
![video_convoluciones](/imagenes/video_convoluciones.png)  

<br>  

Rendimiento del procesador mientras se ejecuta el video:  
![procesador_video_convoluciones](/imagenes/procesador_corriendo_convoluciones.png)  

<br>

Ejecutando **SHADERS** y conversión escala de grises de una imagen:  
![video_convoluciones](/imagenes/shaders_imagen.png)  

<br>

Rendimiento del procesador mientras se ejecuta:  
![procesador_video_convoluciones](/imagenes/procesador_shaders_imagen.png)  

<br>

Ejecutando el video con **SHADERS** y matrices de convolución:  
![video_convoluciones](/imagenes/shaders_video.png)  

<br>

Rendimiento del procesador mientras se ejecuta el video:   
![procesador_video_convoluciones](/imagenes/procesador_shaders_video.png)  


## Conclusiones
 * Aunque el consumo de recursos al usar shaders es levemente mayor, realmente no hay una diferencia de rendimiento significativa entre usar o no shaders personalizados.
 * conclusion 2
 * conclusion 3

## Referencias 📖  

* [Average RGB](https://web.stanford.edu/class/cs101/image-6-grayscale-adva.html)
* [Converting Color Images to Grayscale](https://developer.apple.com/documentation/accelerate/converting_color_images_to_grayscale)
* [LUMA](https://en.wikipedia.org/wiki/Luma_(video))
* [Filtering](https://www.codingame.com/playgrounds/2524/basic-image-manipulation/filtering)  
* [Image Filtering](https://lodev.org/cgtutor/filtering.html)
* [Introducción a la Programación de Shaders](https://www.youtube.com/watch?v=vaiyuVlZuCk)
* [Overview of GLSL](https://www.youtube.com/watch?v=uOErsQljpHs)


## Autores ✒️

|       Integrante      |                 GitHub Nick                   |
|-----------------------|-----------------------------------------------|
| Fredy Mendez          | [fgmendezg](https://github.com/fgmendezg)     |
| Jhon Mueses           | [jjmuesesq](https://github.com/jjmuecesq)     |
| Gonzalo Báez          | [gebaezs](https://github.com/gebaezs)         |

## Licencia 📄

Este proyecto está bajo la Licencia MIT - mira el archivo [LICENSE.md](https://github.com/VisualUnal2020/procesamiento_imagenes/blob/master/LICENSE) para mas detalles.
