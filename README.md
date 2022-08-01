# Trabaja Practico - Entorno

## Creacion del container
docker build . -t entorno

## Ejemplos 
### Ejemplo de modo interactivo usando /mnt/texts como carpeta por defecto
```
docker run -ti -e LOG_LEVEL=CRITICAL  --rm  --name entorno entorno -i
```

<img src="/images/interactive_default.gif">

### Ejemplo de funcion con modo interactivo deshabilitado
Si la funcion a ejecutar necesita argumentos, pueden pasarsa utilizando "". Uso: ```"<nombre funcion> arg1 arg2 ... argN>"```
```
docker run -ti -e LOG_LEVEL=CRITICAL  --rm  --name entorno entorno -f "blockSelection p 1"
```
<img src="/images/noninteractive_default.gif">

### Ejemplo de funcion con modo interactivo y especificando distintos fuentes de texto
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

