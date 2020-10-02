#2 de octubre, 2020
#Marco Garduño
#Descarga y alineamiento de secuencias desde R

#Installando las dependencias necesarias
install.packages("ips")  #  Este paquete contiene el alineador
install.packages("ape")  #  Este paquete nos va a permitir descargar las secuencias

#Cargando las librerias
library("ape")
library("ips")

###
# Para poder correr el código es necesario tener conexión
#  a internet

## descargamos 8 muestras de tanagers (Ramphocelus)
## de Paradis (1997)
ref <- c("U15717", "U15718", "U15719", "U15720",
         "U15721", "U15722", "U15723", "U15724")

#Descargamos estas 8 secuencias
Rampho <- read.GenBank(ref)
## para obtener el nombre de las especies:
attr(Rampho, "species")
## construimos una matriz
## con el nombre de las especies y el código de gb:
cbind(attr(Rampho, "species"), names(Rampho))

## imprimimos la primera secuencia
## (También puede hacerse como: `Rampho$U15717' )
Rampho[[1]]
## observamos la descripción de las secuencias:
attr(Rampho, "description")

#Las exportamos a un archivo de texto
write.dna(x = Rampho, file = "/Volumes/ThiefSanity/bioinfo/fasta_manegment/ape_fasta.fasta", format = "fasta")

###   
       Ejemplo de Astyanax
####

#Cargamos una tabla con los códigos previamente escritos               
ncbi_codes<-read.table(file = "/Volumes/ThiefSanity/bioinfo/fasta_manegment/prueba/samples2.txt",header = FALSE  )
#los pasamos como texto a un vector
codes<-c(levels(ncbi_codes$V1))
#descargamos las secuencias (180)
Asty_cytb<-read.GenBank(codes)

## Observamos el nombre de las especies:
attr(Asty_cytb, "species")
## construimos una matriz
## con el nombre de las especies y el código de gb:

cbind(attr(Asty_cytb, "species"), names(Asty_cytb))
## observamos la descripción de las secuencias:
attr(Asty_cytb, "description")

#llevamos a cabo el alineamiento
aling_ap<-mafft(x = Asty_cytb,method ="localpair")

#Guardamos el archivo sin alinear
write.dna(x = Asty_cytb, file = "/Volumes/ThiefSanity/bioinfo/fasta_manegment/Asty_ape.fasta", format = "fasta")
#Guardamos el archivo alineado
write.dna(x = aling_ape, file = "/Volumes/ThiefSanity/bioinfo/fasta_manegment/Rmafft_ape.fasta", format = "fasta")
