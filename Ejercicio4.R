#Librerias
library(ISLR)
library(rpart)
library(randomForest)

library(ggplot2)
library(Hmisc) ## para apliocar describe
data("Carseats")

#Estadístico del dataset
di <- describe(Carseats)
summary(Carseats)

##1. Dividir los datos en un conjunto de entrenamiento y un conjunto de control.

Carseats=data.frame(Carseats)
# Defino un tamaño de la muestra
crseats_size = floor(0.75*nrow(Carseats)) ## lo defino en un 75%

set.seed(123)   # set seed to ensure you always have same random numbers generated
train_ind = sample(seq_len(nrow(Carseats)),size = crseats_size)  # Randomly identifies therows equal to sample size ( defined in previous instruction) from  all the rows of Smarket dataset and stores the row number in train_ind
train =Carseats[train_ind,] #creates the training dataset with row numbers stored in train_ind
test=Carseats[-train_ind,]  

##2. Ajustar un arbol de regresion utilizando la biblioteca rpart a los datos de entrenamiento y
##estimar el error de generalizacion del modelo.


