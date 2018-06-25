#!/bin/bash
# Este script cria arquivo e gráfico em R (requer Linguagem R instalada).
# Criará um gráfico de barras com a quantidade de Sismos no mundo desde 2000 - dividido em magnitudes...
# Para executá-lo digite no seu Terminal Linux:
# curl -s https://raw.githubusercontent.com/HelioGiroto/Sismos/master/sismos_grafico.sh | bash

for num in $(seq 5 9)
do
	mag[$num]=$(curl -s -X GET $(echo 'https://earthquake.usgs.gov/fdsnws/event/1/count?minmagnitude='$num'&starttime=2000-01-01')) 
	echo "Magnitude" $num " - " ${mag[$num]} "vezes."
done

dados=$(echo ${mag[*]} | sed 's/ /,/g')		# Cria array formatado para R
echo;echo $dados 

# Antiga versão:
# echo "png()" > graf.R
# echo "plot(c("$dados"), type='l')" >> graf.R
# echo "dev.off()" >> graf.R
# Tente tb type= l,p,b,o,c,h,s,S

# Daqui em diante, cria um arquivo R:
echo "png()" > graf.R
echo "valores <- c(${dados})" >> graf.R
echo "X <- c('>5','>6','>7','>8','>9')" >> graf.R
echo "barplot(valores, names.arg = X, xlab = 'Magnitudes', ylab = 'Nro. de Sismos', main = 'Sismos no Mundo (desde 2000)', col='red')" >> graf.R
echo "dev.off()" >> graf.R

# Abre (cria) gráfico com os dados coletados:
R -f graf.R &> /dev/null
display Rplot*.png &

# Autor: Helio Giroto
