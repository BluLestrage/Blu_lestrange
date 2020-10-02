#2 de octubre, 2020
#Descargar secuencias formato fasta desde la terminal con Entrez
#Conocimientos previos: haber instalado conda en el ordenador

#directorio de trabajo

cd ~
mkdir prueba
cd $HOME/prueba	#este va a cambiar dependiendo de la computadora de cada quien.

#instalamos Entrez a través de conda
conda install -c bioconda entrez-direct
#instalamos mafft para llevar a cabo el alineamiento
conda install -c biocore mafft


#Sintaxis para la descarga utilizando el comando esearch.

esearch -db nucleotide \  					# -db: database <- la base de datos donde hará la búsqueda de la secuencia
-query "NC_030850.1" | \  					# -query: cadena de caracteres sobre el cual se llevará la búsqueda
efetch -format fasta > NC_030850.1.fasta	# efetch: va a utilizar la información de eserch, y la va a transformar en 
											# formato fasta utilizando el comando -format
											# y redirigirla a un archivo, en este caso de nombre "NC_030850.1.fasta"

#Ejemplo práctico.
#En este caso vamos a descargas las secuencias del artículo de Ornelas-García et al. (2008)
#De varias especies de Astyanax. 
https://www.ncbi.nlm.nih.gov/popset?DbFrom=nuccore&Cmd=Link&LinkName=nuccore_popset&IdsFromResult=238232348

#buscamos las muestras y creamos un texto desde la terminal
#Ver la pestaña de a lado
nano sampes.txt 

#aplicando expresiones regulares, filtramos los datos que no nos interesan y obtenemos los códigos del genebank
cat samples.txt |egrep -Eo 'FJ[0-9]{6}.1*'|sort > samples2.txt

for i in $(cat samples2.txt); do 
echo muestra $i; 
query=\"$i\"; esearch -db nucleotide -query $query | efetch -format fasta > $i.fasta
done

#Las muestras descargadas pueden evaluarse utilizando el comando wc
head -n 1 *fasta
wc *.fasta

#hacemos una matriz con todas las muestras
cat *fasta > concat.fasta

#Llevamos a cabo el alineamiento utilizando mafft
mafft --localpair --maxiterate 1000 concat.fasta > alig.fasta

#revisamos que el alineamient haya salido bien utilizando la interfas gráfica
open -a mesquite
