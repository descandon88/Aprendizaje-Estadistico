#Librerias
library(ISLR)
library(rpart)
library(randomForest)
library(tree)

library(rattle)
library(rpart.plot)


#1. Dividir los datos en un conjunto de entrenamiento y un conjunto de control.

attach(Carseats)
set.seed(123) # seteo un seed
train_in<-sample(nrow(Carseats),nrow(Carseats)*0.75) ## lo defino en un 75%
train1<-Carseats[train_in,] #se crea un set de entrenamiento con el numero de filas asignados en in train_ind
test1<-Carseats[-train_in,] #se crea un set de testeo


#2. Ajustar un arbol de regresion utilizando la biblioteca rpart a los datos de entrenamiento y
#estimar el error de generalizacion del modelo.

mytree.train <- rpart( Sales ~ CompPrice + Income + Advertising ## Utilizo solo las variables cuantitativas a mi modelo
                 + Population + Price +ShelveLoc +Age + Education, data = train1, method = "anova")

summary(mytree.train)

printcp(mytree.train) # imprimir los resultados

plot(mytree.train, uniform=TRUE, main="Árbol de Regresión") 
text(mytree.train, use.n=TRUE, all=TRUE, cex=0.8)

pred<-predict(mytree.train,testdata=test1)
tree_mse<-mean((test1$Sales-pred)^2)
tree_mse




tree.prediction<-predict(car.model.train,newdata=test1)
tree.mse2<-mean((test1$Sales-tree.prediction)^2)
tree.mse2

# 3. Utilizando validación cruzada determinar nivel óptimo complejidad
# y obtener un árbol podado.  En este caso, ¿podar el árbol mejora error
#de generalización?



printcp(mytree.train)
plotcp(mytree.train) # visualización de los resultados de cross-validation

rsq.rpart(mytree.train)

summary(mytree.train, cp=0.1)

prune.predict<-predict(prune.car,car.test)
mean((prune.predict-car.test$Sales)^2)
#4. Elige un arbol e interpreta los resultados
# prune the tree
pfit<- prune(mytree.train, cp=mytree.train$cptable[which.min(mytree.train$cptable[,"xerror"]),"CP"])

# plot the pruned tree
plot(pfit, uniform=TRUE,
     main="Árbol de Regresión Podado")
text(pfit, use.n=TRUE, all=TRUE, cex=.8)
post(pfit, file = "c:/ptree.ps",
     title = "Árbol de Regresión Podado")

#5. Utilizando la biblioteca randomForest ajustar un bosque aleatorio a 
#los datos de entrenamiento. Elegir el valor de mtry con validacion cruzada.
library(randomForest)


# Funnción tuneRF()
set.seed(123)
best_mtry <- tuneRF(x=subset(train1,select=-Sales),y=train1$Sales, ntreeTry= 500,
                    stepFactor=1.5)
print(best_mtry)

#x = subset(credit_train, select = -default),
#y = credit_train$default,

rf_car<-randomForest(Sales~.,data=train1,importance=TRUE,mtry=sqrt(6))


#6 Con el bosque seleccionado, analiza la importancia de las variables
#en el modelo.
importance(rf_car)

rf_car_pred<-predict(rf_car,test1)
mean((rf_car_pred-test1$Sales)^2)



