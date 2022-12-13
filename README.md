# Roseibaca

## Intro
En este repositorio hacemos un estudio de *Roseibaca V10* una cepa que pertenece a familia *Rhodobacteraceae*, centrandonos en la su evolución desde un punto de vista biosintetico.
La familia que usamos para este estudio la podemos ver el archivo [list.txt](list.txt) y está dad por: 

| Assembly accesion 	| Organims                                 	| Strain     	|
|-------------------	|------------------------------------------	|------------	|
| GCF_023336755.1   	| _Roseibaca sp.V10_                       	| V10        	|
| GCF_001517585.1   	| _Roseibaca calidilacus_                  	| HL-91      	|
| GCF_900499075.1   	| _Roseibaca ekhonensis_                   	| CECT 7235  	|
| GCF_001870675.1   	| _Roseinatronobacter thiooxidans_         	| ALG1       	|
| GCF_006716865.1   	| _Roseinatronobacter monicus_             	| DSM 18423  	|
| GCF_004366635.1   	| _Rhodobaca bogoriensis DSM 18756_        	| DSM 18756  	|
| GCF_001870665.2   	| _Rhodobaca barguzinensis_                	| alga05     	|
| GCF_014681765.1   	| _Roseicitreum antarcticum_               	| ZS2-28     	|
| GCF_003076755.1   	| _Pararhodobacter oceanensis_             	| AM505      	|
| GCF_003990445.1   	| _Pararhodobacter zhoushanensis_          	| ZQ420      	|
| GCF_003122215.1   	| _Pararhodobacter marinus_                	| CIC4N-9    	|
| GCF_003075525.1   	| _Pararhodobacter aggregans_              	| D1-19      	|
| GCF_016653255.1   	| _Rhodobaculum claviforme_                	| LMG 28126  	|
| GCF_003350345.1   	| _Alkalilacustris brevis_                 	| 34079      	|
| GCF_000740775.1   	| _Haematobacter missouriensis_            	| CCUG 52307 	|
| GCF_003254295.1   	| _Rhodobacter capsulatus_                 	| DSM 1710   	|
| GCF_000740785.1   	| _Paenirhodobacter enshiensis_            	| DW2-9      	|
| GCF_000714535.1   	| _Thioclava pacifica DSM 10166_           	| DSM 10166  	|
| GCF_003034995.1   	| _Phaeovulum veldkampii DSM 11550_        	| DSM 11550  	|
| GCF_900100045.1   	| _Paracoccus denitrificans_               	| DSM 413    	|
| GCF_009908165.1   	| _Frigidibacter albus_                    	| SP32       	|
| GCF_002927635.1   	| _Albidovulum inexpectatum_               	| DSM 12048  	|
| GCF_003034965.1   	| _Fuscovulum blasticum DSM 2131_          	| DSM 2131   	|
| GCF_003290025.1   	| _Pseudogemmobacter bohemicus_            	| Cd-10      	|
| GCF_002900975.1   	| _Tabrizicola aquatica_                   	| RCRI19     	|
| GCF_001294535.1   	| _Cypionkella psychrotolerans_            	| PAMC 27389 	|
| GCF_900110025.1   	| _Gemmobacter aquatilis_                  	| DSM 3857   	|
| GCF_000420745.1   	| _Pseudorhodobacter ferrugineus DSM 5888_ 	| DSM 5888   	|
| GCF_003034985.1   	| _Cereibacter changlensis JA139_          	| JA139      	|
| GCF_004015795.1   	| _Falsirhodobacter deserti_               	| W402       	|
| GCF_000429765.1   	| _Gemmobacter nectariphilus DSM 15620_    	| DSM 15620  	|
| GCF_002871005.1   	| _Acidimangrovimonas sediminis_           	| MS2-2      	|
| GCF_004010155.1   	| _Solirhodobacter olei_                   	| Pet-1      	|

## Preparación de datos
### [Descargar genomas](/raw_data/)

Los archivos `.fna` de cada una de la sepas fueron descargado de NCBI usando el ambiendo de conda `ncbi-genome-download` y fueron almacenados en la carpeta [raw_data](https://github.com/shadayguerrero/Roseibaca/tree/main/raw_data).

### [Anotación funcional](https://github.com/shadayguerrero/Roseibaca/tree/main/functional_annotation) 
La anotación funcional fue realizada con con **Prokka 1.14.6** y los detalles para cada una de las sepas estan [functional_annotation](https://github.com/shadayguerrero/Roseibaca/tree/main/functional_annotation).

### [Genbank](https://github.com/shadayguerrero/Roseibaca/tree/main/gbk) 
En esta carpeta estan los archivos `.gbk` que salieron de la anotación funcional realizada con Prokka. Estos archivos fueron corregidos usando el script sigueinte `correctgbk.sh`, que nos permite cambiar el termino "Unclassified" en la fila "Organims" por la sepa recpectiva de cada organimos.

~~~
file=$1
locus=$(grep -m 1 "DEFINITION" $file |cut -d " " -f6,7) #if you have details the strain in your gbk files, use this line. Else use the next line.
#locus=$(grep -m 1 "LOCUS" $file |cut -d\  -f 8 |cut -b1-11)  #select the first 11 characters from the first "LOCUS"
perl -p -i -e 's/\n// if /ORGANISM/' $file  #cambiar 
perl -p -i -e 's/\s*Unclassified/ '"${locus}"'/' $file
~~~

Además, corriemos los renombramos los nombre de los archivos para que tegan los detalles de cada organismo.

~~~
cat list.txt | while read line
do 
  id2=$(echo $line |cut -d " " -f1,2,3,4,5 | tr " \t" "_")
  id=$(echo $line |cut -d " " -f1)
  #echo $id.prokka
  #echo $id2
mv $id.prokka.gbk $id2.gbk
done
~~~

## [Cluster de genes biosinteticos (BGC)](https://github.com/shadayguerrero/Roseibaca/tree/main/antismash) 
Para la busqueda de los BGCs usamos **antiSMASH 6.0.0** y los resultados fueron almacenados en la carpeta [antismash](https://github.com/shadayguerrero/Roseibaca/tree/main/antismash). Además, usamos el script [change-names.sh](/antismash/change-names.sh), que añade en el nombre los detalles cepa a cada una de las regiones encontradas con antiSMASH.


Encontramos 7 BGC para *Roseibaca V10*, como podemos observar en la salida de [antismash](/antismash/GCF_023336755.1_Roseibaca_sp.V10_V10/index.html), falta ver como se relacionan con los otros cluster en los diversos genomas.

## [Redes de similitud de BGC](https://github.com/shadayguerrero/Roseibaca/tree/main/bigscape)
Para identificar que grupos de BGC se estan formando y en cuales esta presente *Roseibaca sp.V10* utilizamos **BiG-SCAPE 1.1.2**, los resultados los econtramos en la siguiente carpeta [bigscpae/output](https://github.com/shadayguerrero/Roseibaca/tree/main/bigscape/output).

Una exploracion grafica de los resultados de **BiG-SCAPE** los podemos ver en [bigscpae/output/index.html](/bigscape/output/index.html).

### Terpene
### 


