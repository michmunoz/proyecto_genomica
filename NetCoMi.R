

### Instalar paquete

install.packages("devtools")
install.packages("BiocManager")


#Instalar estas librerias que se encuentran en GitHub
devtools::install_github("zdk123/SpiecEasi")
devtools::install_github("GraceYoon/SPRING")

# Instalar NetCoMi
devtools::install_github("stefpeschel/NetCoMi", 
                         repos = c("https://cloud.r-project.org/",
                                   BiocManager::repositories()))
library(NetCoMi)
library(phyloseq)

#Uso de la base de datos soilrep la cual contiene información sobre microbiota del suelo bajo distintas condiciones
data("soilrep")
sample_data(soilrep) 
View(soilrep)

## Construcción de redes con NetComi

#Creamos dos subsets que separen las condiciones más importantes de esta base de datos: altas y bajas temepraturas 
alta<-subset_samples(soilrep, warmed == "yes")
baja<-subset_samples(soilrep, warmed == "no")

#Hacemos la construcción de la red tomando los dos subsets que hicimos antes, las redes son de co-ocurrencia microbiana y 
#utiliza la corrrelación de Pearson
net <- netConstruct(data = baja, data2 = alta, filtTax = "highestVar", filtTaxPar = list(highestVar = 500),
  zeroMethod = "pseudo", normMethod = "clr", measure = "pearson", verbose = 0)

#Analizar y visualizar las redes
#Analisis de la red: nodos, densidad, diametro, degrees, medidas de centralidad, etc.
analisis<- netAnalyze(net, clustMethod = "cluster_fast_greedy") #fast_greedy  es usado para detectar comunidades

plot(analisis, sameLayout = TRUE, layoutGroup = "union", nodeColor = "cluster", hubLabelThreshold = 0.8, 
     groupNames = c("muestra de suelo 1: no calentado", "Muestra de suelo 2: calentado"))

#obtener una matriz de adyacencias ponderada
adj_mat <- net$adjaMat1   
write.csv(adj_mat, "matrizponderada.csv")

#Comparar grupos

#Hacer subsets
UC<-subset_samples(soilrep, Treatment == "UC")
UU<-subset_samples(soilrep, Treatment == "UU")
#hacer matrices de abundancia
matrizUC<- as(otu_table(UC), "matrix")
matrizUU<- as(otu_table(UU), "matrix")
#Construir la red
constredUC<- netConstruct(data = matrizUC, normMethod = "clr", measure = "pearson", verbose = 0)
constredUU<- netConstruct(data = matrizUU, normMethod = "clr", measure = "pearson", verbose = 0)

analisisUC <- netAnalyze(constredUC, clustMethod = "cluster_fast_greedy")
analisisUU <- netAnalyze(constredUU, clustMethod = "cluster_fast_greedy")


net_comparison <- netCompare(
  net1 = analisisUC,
  net2 = analisisUU)
