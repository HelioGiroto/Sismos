#!/bin/bash

# Este script dará o total de todos os sismos no mundo nas últimas 7 décadas (70 anos)

# O resultado é o que você vê neste link abaixo:
# https://github.com/HelioGiroto/Sismos/blob/master/sismos_mundo_desde_1950.txt


for ano in $(seq 1950 10 2010)
do
	decada=$(( ano + 9 ))		# para calcularmos uma década.
		
	for mag in $(seq 3 9)
	do
		qtos[$mag]=$( curl -sX GET $( echo 'https://earthquake.usgs.gov/fdsnws/event/1/count?minmagnitude='$mag'&starttime='$ano'-01-01&endtime='$decada'-12-31' ) ) 
		echo "Na década de" $ano"-"$decada "tiveram" ${qtos[$mag]} "sismos de magnitude" $mag
	done
	echo				# para separar com uma linha em branco qdo muda o ano (década)
done

# Autor: Helio Giroto
