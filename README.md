# Trabaja Practico - Entorno
===========
## Indice
---
![Creacion del container](/README#creacion-del-container)
![Uso](/README#creacion-del-container)
- [opciones](/README#opciones)
![Ejemplos](/README#ejemplos)
- ![modo interactivo](/README#ejemplo-de-modo-interactivo-usando-mnttexts-como-carpeta-por-defecto)
- ![modo interactivo deshabilitado](/README#ejemplo-de-funcion-con-modo-interactivo-deshabilitado)
- ![especificando distintas fuentes de texto](/README#ejemplo-de-funcion-con-modo-interactivo-y-especificando-distintos-fuentes-de-texto)
- ![habilitando debug](/README#ejemplo-habilitando-modo-debug)
![Funciones disponibles](/README#funciones-disponibles)


## Creacion del container
```
docker build . -t entorno
```

## Uso
---
```
 docker run -ti --rm  --name entorno entorno [-h|-s <URL|PATH>] [ -i|-f <FUNCTION NAME> ]
```

### Opciones
```
Modo verbose disponible seteando la variable de entorno LOG_LEVEL. Valores permitidos: <DEBUG|WARNING|CRITICAL>.
```

```    
-h muestra menu de ayuda
-s Una lista de cadenas separada por espacios especificando URL, carpetas o rutas a archivos de texto. Ej: "http://google.com /mnt/texts /mnt/texts/enterSandman.txt".
   Cualquier carpeta vacia sera ignorada.
-i Ejecuta el script en modo interactivo. Se despliega menu de opciones.
-f Ejecuta una funcion automaticamente. Si la funcion toma parametros, se debe especificar mediante un solo parametro como lista de string : "<nombre funcion> arg1 arg2 ... argN>" 
   Ejemplo: -f "blockSelection p 1"
   Funciones disponibles: < statsWords|statsUsageWords|findNames|statsSentences|blankLinesCounter|caseConverter|substringReplace|blockSelection >
```

## Ejemplos 
---

### Ejemplo de modo interactivo usando /mnt/texts como carpeta por defecto
```
docker run -ti -e LOG_LEVEL=CRITICAL  --rm  --name entorno entorno -i
```

<img src="/images/interactive_default.gif">

### Ejemplo de funcion con modo interactivo deshabilitado
Si la funcion a ejecutar necesita argumentos, pueden pasarsa utilizando "". Uso: `"<nombre funcion> arg1 arg2 ... argN>"`
```
docker run -ti -e LOG_LEVEL=CRITICAL  --rm  --name entorno entorno -f "blockSelection p 1"
```
<img src="/images/noninteractive_default.gif">

### Ejemplo de funcion con modo interactivo y especificando distintas fuentes de texto
Se pueden especificar tantas carpetas y URLs como se desee.
Solo seran interpretadas como URL validas las comenzadas con *http://* | *https://*
```
docker run -ti -e LOG_LEVEL=CRITICAL  --rm  --name entorno entorno -s "/mnt/texts https://www.google.com"  -i
```
<img src="/images/source_example.gif">

### Mismo ejemplo anterior pero sin modo interactivo
```
docker run -ti -e LOG_LEVEL=CRITICAL  --rm  --name entorno entorno -s "/mnt/texts https://www.google.com"  -f statsWords
```

### Ejemplo habilitando modo DEBUG
```
docker run -ti -e LOG_LEVEL=DEBUG --rm  --name entorno entorno -s "/mnt/texts"  -f findNames
```
<img src="/images/debug.gif">

## Funciones disponibles:
---
1. *statsWords*
Indicador estadístico de longitud de palabras (la más corta, la más larga y el
promedio de longitud).

2. *statsUsageWords*
Indicador estadístico de uso de palabras, deben ser de al menos 4(cuatro)
letras. (mostrar un Top Ten de estas palabras ordenadas desde la que tiene
más apariciones a la que tiene menos). Es decir, filtrar las palabras que
tengan al menos 4 letras y de éstas, elegir las 10 más usadas.

3. *findNames*
Identificación de nombres propios (se identifican sólo si están en este formato
Nnnnnnnnn), aunque la palabra no sea un nombre propio realmente.
Ejemplos: Mateo, Estonoesunnombre, Ana.

4. *statsSentences*
Indicador estadístico de longitud de oraciones (la más corta, la más larga y el
promedio de longitud).

5. *blankLinesCounter*
Contador de líneas en blanco.

6. *caseConverter*
Invertir minúsculas a mayúsculas, y viceversa, de todas las palabras.

7. *substringReplace*
Reemplazo de subcadenas, que considere diferencias entre minúsculas y
mayúsculas, pero ignore acentos. Recibe dos cadenas, y cada aparición de
cadena1 debe reemplazarse por la cadena2.
Ejemplo: cadena1: tre cadena2: TRE
las palabras: enTrepiso, entretenido, intrépido
pasan a: enTrepiso, enTREtenido, inTREpido

8. *blockSelection*
Selección de oración y/o párrafo en base a un número de entrada. Es decir,
se puede establecer como entrada “O” o “P” para indicar oración o párrafo y
luego un número (un párrafo se distingue de otro con un punto y aparte, las
oraciones vía un punto seguido).
