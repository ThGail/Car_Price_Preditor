set.seed(2022)
library(dplyr)
#setwd("/Users/thibaultgaillard/Documents/M2 ISF/Projet de R/Car_Price_Preditor")
data_init = read.csv2("dataset.csv", header = TRUE, sep = ",")

str(data_init)

#on supprime la colo,nne ID car elle servira à rien
data <- data_init %>% select(-ID)

#Traitement des NA : 
#Officiellement, il y a 10 NA
rows_with_na <- rowSums(is.na(data)) > 0
data_with_na <- data[rows_with_na, ]

#Ces lignes ne présentent aucune information, on peut les virer : (10 lignes en moins) 
data = data[-c(4070, 6671, 9769, 11648, 13329, 13530, 15006, 15407, 16400, 17847),]


#Traitement de Levy
#temp <- print(data[data$Levy == '-',]) #5814 Levy manquantes -> On remplace par la moyenne
data$Levy <- ifelse(data$Levy == '-', NA, data$Levy)
data$Levy = as.integer(data$Levy)
levy_mean = mean(data$Levy, na.rm = TRUE)
data$Levy[is.na(data$Levy)] <- levy_mean
data$Levy = as.integer(data$Levy)
#temp <- mean(data$Levy)

#Traitement de Mileage :
# On supprime le symbol 'km' dans la colonne Mileage pour la transformer en numeric
data$Mileage <- substr(data$Mileage, 1, nchar(data$Mileage) - 3)
data$Mileage <- as.integer(data$Mileage)

#Traitement de 'Doors', le nombre de portières :
#Il y a des dates à la place d'une valeur numérique
#La trop grande majorité des lignes n'est pas retraitable, nous supprimons la colonne
data <- data %>% select(-Doors)

#Traitement du nombre de cylindres 'cylinders' : 
data$Cylinders = as.integer(data$Cylinders)


#Il faudra changer engine entre la cylindrée et le turbo
#Model et manufacturer sont à aussi à traiter
#Leather integer à passer en boolean

str(data)
