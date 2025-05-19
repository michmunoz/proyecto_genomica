

### Instalar paquete

install.packages("devtools")
install.packages("BiocManager")

# Since two of NetCoMi's dependencies are only available on GitHub, 
# it is recommended to install them first:
devtools::install_github("zdk123/SpiecEasi")
devtools::install_github("GraceYoon/SPRING")

# Install NetCoMi
devtools::install_github("stefpeschel/NetCoMi", 
                         repos = c("https://cloud.r-project.org/",
                                   BiocManager::repositories()))
