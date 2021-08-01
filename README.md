# Aprendizaje-Estadistico
Ejercicio 8 del Cap 8 de ISLR. Se utilizan los datos Carseats. Para obtenerlos podemos instalar la biblioteca que viene con el libro y luego cargar los datos:
install.packages("ISLR") # una sola vez
library(ISLR) # cada vez que queiro usar la biblioteca
data("Carseats") # carga los datos
? Carseats # descripcion de los datos

Utilizando estos datos vamos a ajustar varios modelos teniendo Sales como variable dependiente, 
utilizamos las bibliotecas que trabajamos en clase:

library(rpart)
library(randomForest)
