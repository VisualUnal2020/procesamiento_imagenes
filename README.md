# Procesamiento De Imagenes

En este taller se desarrollan diferentes formas de procesamiento de imagenes, tanto por software (Processing) como por hardware (OpenGL Shading Language). En la parte de software (archivo.pde) se desarrollaran en varias fases, como lo son diferentes métodos de convertir imagenes a varias escalas de grises como tambien aplicando varias matrices de convolución las cuales dan dieferentes efectos a las imágenes como por ejemplo enfoque, realce, entre otros. Tambien se implementaran estos mismos métodos pero ahora con un pequeño video en el cual se tomara cada fotograma y realizaran las diferentes converciones y se podra observar los resultados. Ahora en la parte de hadware se haran las mismas pruebas tanto con imágenes como con videos pero en este caso se implementaran SHADERS (archivo.glsl), para hacer la comparación en rendimiento entre los recursos usados tanto por la CPU como por la GPU.


## Objetivos  

* Observar la diferencia entre las converciones a escalas de grises por el método **promedio RGB** y el método **LUMA**, mas especificamente cual es mas fiel con la conservación de la luminosidad y detalles con respecto a la imagen o video original.  

* Obervar los efectos obtenidos al aplicar los filtros (matrices de convolución) tanto a las imagenes como al video y como estos pueden ser comparados con algunos efectos que emplean algunos programas de edición y/o cámaras con diferentes lentes.  

* Por medio de un histrograma observar la cantidad (porcentaje) de los diferentes valores de grises luego de realizar la conversión de una imagen a escala de grises mediante el método **LUMA** y como estos se ven reflejados en la imagen convertida.  

* Realizar la comparación entre el rendimiento entre la CPU y la GPU al ejecutar los ejercicios solo con **Processing** como con **OpenGL Shading Language**.


## Comenzando 🚀

Antes de ejecutar los ejercicios debemos tener tener las siguientes herramientas y algunas librerias instaladas (_dependiendo del sistema operativo_), las cuales mencionaremos a continuación al igual que su instalacion.


### Pre-requisitos 📋

* **Processing**:  
    Es un lenguaje de programación y entorno de desarrollo integrado de código abierto basado en Java, de fácil utilización, y que sirve como medio para la enseñanza y producción de proyectos multimedia e interactivos de diseño digital.  
    
    Se puede descargar de su pagina oficial en el siguiente link:  
    [**DESCARGAR PROCESSING**](https://processing.org/download/)  
    
    Debemos elegir el archivo a descargar según las especificaciones de la arquitecura del procesador (32-bit ó 64-bit) y el sistema operativo instalado (Windows ,GNU/Linux).  

    **[WINDOWS]**  
    Luego de descargar el archivo (.zip), vamos a la carpeta donde se descargo, hacer click derecho sobre el archivo y descomprimirlo, lo cual nos generara una carpeta llamada ***processing-3.5.4***, ingresamos a esta carpeta y ejecutamos el archivo ***processing.exe*** haciendo doble clic sobre el mismo, esperamos un momento mientras carga y listo ya tenemos **Processing** funcionando en Windows.  
  

    **[GNU/Linux]**  
    Luego de descargar el archivo (.tgz), vamos a la carpeta donde se encuentra la descarga, hacemos clic derecho sobre el archivo y le damos extraer lo cual nos genera una carpeta llamada ***processing-3.5.4***, ingresamos a esta carpeta y dentro de la carpeta hacemos clic derecho y 
    damos clic sobre la opcion ***Abrir Terminal***. lo cual nos abre una terminal la cual ya en la ruta de la carpeta en la estamos en el modo grafico, ahora ejecutamos el siguiente comando:  


```  
    sudo sh install.sh 
````  

   Ahora buscamos en nuestro lanzador de aplicaciones o menu desplegable la aplicacion **Processing** y la abrimos. listo ya tenemos instalado **Processing** en GNU/Linux.

    
### Instalación de libreia [video] 🔧

Para la instalación de la libreria **video** seguimos las siguientes instrucciones (tanto para Windows como para GNU/Linux): abrimos la aplicación *[Processing**, vamos a la barra de menu y damos clic en la opción **Tools** la cual nos abre un menu desplegable y damos clic en la opcion **Add Tool...**, la cual nos abre una nueva ventana con cuatro pestañas y vamos a la pestaña de **Libraries**, en el campo de busqueda (filtro) escribimos **video**, en los resultados buscamos la opción que dice **Video | GStreamer-based video library for Processing.**, la seleccionamos y en la parte inferior derecha damos clic en el boton **install**, esperamos un momento mientras instala la libreria, luego reiniciamos la aplicacion (cerramos y volvemos a abrir la aplicación).

***[Problemas instalación en GNU/Linux]***  
Distribuciones recientes GNU/Linux que emplean  **[gstreamer >= 1]**, requieren [**ESTA!!!**](https://github.com/gohai/processing-video/releases/tag/v1.0.2) versión alternativa de la libreria de video. Descomprimir el archivo ***(.zip)*** en la carpeta de **libraries** del sketbook **(e.g., $HOME/sketchbook/libraries)**.  
  
## Ejecutando los ejercicios ⚙️

_Explica como ejecutar las pruebas automatizadas para este sistema_

### Analice las pruebas end-to-end 🔩

_Explica que verifican estas pruebas y por qué_

```
Da un ejemplo
```

### Y las pruebas de estilo de codificación ⌨️

_Explica que verifican estas pruebas y por qué_

```
Da un ejemplo
```

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