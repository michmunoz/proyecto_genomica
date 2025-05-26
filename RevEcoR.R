

###Instalar el paquete 
if (!requireNamespace("devtools")) install.packages("devtools")
library(devtools)
install_github("zy26/RevEcoR")

# Cargar el paquete
library(RevEcoR)

#Enfoque del paquete: reconstruccion y analisis de redes metabolicas

#Keggrest: permite acceso a la base de datos de rutas metabolicas

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("KEGGREST")
library(KEGGREST)

#Aqui buscamos los organismos presentes en la lista de keggrest
orgs <- keggList("organism")
head(orgs, 10)

#Escogemos el codigo del organismo predilecto: eco por E. coli
rutas<- keggList("pathway", "eco")
rutas
rutas2<- names(rutas)[1] #guarda el nombre de la ruta metabolica que es el ID
fatty<- names(rutas)[grep("beta-Lactam resistance", rutas)]
fatty# esta es para escoger una ruta metabolica especifica 
genesfatty<- keggLink("genes", ruta_id) #etraer los genes presentes en esa ruta para despues hacer los demas analisis.
