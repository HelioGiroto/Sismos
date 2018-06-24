#!/bin/bash
# Script que gera um arquivo e gráfico em R

for num in $(seq 5 9)
do
	mag[$num]=$(curl -s -X GET $(echo 'https://earthquake.usgs.gov/fdsnws/event/1/count?minmagnitude='$num'&starttime=2000-01-01')) 
	echo "Magnitude" $num " - " ${mag[$num]} "vezes."

done

dados=$(echo ${mag[*]} | sed 's/ /,/g')

# Abaixo deveria gerar um grafico jpg ou png e depois abrir o jpg/png
echo "png()" > graf.R
echo "plot(c("$dados"), type='l')" >> graf.R
# ou:
# echo "barplot(c("$dados"))" >> graf.R
echo "dev.off()" >> graf.R

# Tente tb type= l,p,b,o,c,h,s,S

# Esses 2 abaixo nao funcionaram: 
# R < graf.R --no-save
# Rscript graf.R

R -f graf.R &> /dev/null
display *.png &

# Para abrir uma imagem:
# display graf.png
# ou pode ser xdg-open para abrir qualquer arquivo pois o xdg-open simula os dois cliques

# Pausa nao funcionou
# echo "Sys.sleep(20)" >> graf.R
