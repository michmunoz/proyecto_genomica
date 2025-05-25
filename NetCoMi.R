

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
