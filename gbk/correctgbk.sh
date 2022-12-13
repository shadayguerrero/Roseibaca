file=$1
#locus=$(grep -m 1 "LOCUS" $file |cut -d\  -f 8 |cut -b1-11)  #selecionas de el primer Locus, los primeros 11 caracteres donde empiezan con N
locus=$(grep -m 1 "DEFINITION" $file |cut -d " " -f6,7)
perl -p -i -e 's/\n// if /ORGANISM/' $file  #cambiar 
perl -p -i -e 's/\s*Unclassified/ '"${locus}"'/' $file
