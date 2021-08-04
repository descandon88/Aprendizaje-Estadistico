#Librerias
library(ISLR)
library(rpart)
library(randomForest)
library(tree)
## Librerias para graficas chulas
library(rattle)
library(rpart.plot)
library(RColorBrewer)
library(ggplot2)
library(Hmisc) ## para apliocar describe
data("Carseats")

#Estadístico del dataset
di <- describe(Carseats)
summary(Carseats)
str(Carseats)

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

tree.carseats=tree(,-Sales ,train )

mytree <- rpart( Sales ~ CompPrice + Income + Advertising
                 + Population, data = train, method = "class")

fancyRpartPlot(mytree, caption = NULL)
rpart.plot(mytree)

#Minimum Square error
MSE <- mean((pred_model-test$Sales)^2)

rmse(test$Sales,pred_model)

fancyRpartPlot(mytree, caption = NULL)
rpart.plot(mytree)

#3. Utilizando validacion cruzada determinar nivel optimo complejidad y obtener 
#un arbol podado. En este caso, ¿podar el arbol mejora error de generalizacion?

#Cross-Validation con cv.tree
set.seed(123)
cv.carseats<-cv.tree(mytree,prune.tree,K=10)

#Arbol podado
cv.carseats=cv.tree(mytree,FUN=prune.misclass)

