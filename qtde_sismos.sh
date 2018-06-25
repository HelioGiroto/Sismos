#!/bin/bash

for num in $(seq 5 9)
do
	mag[$num]=$(curl -s -X GET $(echo 'https://earthquake.usgs.gov/fdsnws/event/1/count?minmagnitude='$num'&starttime=2000-01-01')) 
	echo "Magnitude" $num " - " ${mag[$num]} "vezes."

done

dados=$(echo ${mag[*]} | sed 's/ /,/g')
echo $dados 

# Antigo:
# Abaixo deveria gerar um grafico jpg ou png e depois abrir o jpg/png
# echo "png()" > graf.R
# echo "plot(c("$dados"), type='l')" >> graf.R
# echo "dev.off()" >> graf.R
# Tente tb type= l,p,b,o,c,h,s,S

echo "png()" > graf.R
echo "valores <- c(${dados})" >> graf.R
echo "X <- c('>5','>6','>7','>8','>9')" >> graf.R
echo "barplot(valores, names.arg = X, xlab = 'Magnitudes', ylab = 'Nro. Sismos', main = 'Sismos no Mundo (desde 2000)', col='red')" >> graf.R
echo "dev.off()" >> graf.R

R -f graf.R &> /dev/null
display Rplot*.png &

# Esses 2 abaixo nao funcionaram: 
# R < graf.R --no-save
# Rscript graf.R

# Para abrir uma imagem:
# display graf.png
# ou pode ser xdg-open para abrir qualquer arquivo pois o xdg-open simula os dois cliques

# Pausa nao funcionou
# echo "Sys.sleep(20)" >> graf.R
