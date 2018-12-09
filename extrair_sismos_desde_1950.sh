#!/bin/bash
# Script em BASH que baixa diretamente dos BD's da USGS.GOV a TODOS os sismos no mundo maiores de 5.x desde 1950

: > sismos.dat		# Cria arq. vazio

# Array com todos URLs de sismos acima de 5.0
urls=(
"https://earthquake.usgs.gov/fdsnws/event/1/query?format=text&starttime=1949-12-31&endtime=1960-01-01&minmagnitude=5"
"https://earthquake.usgs.gov/fdsnws/event/1/query?format=text&starttime=1959-12-31&endtime=1970-01-01&minmagnitude=5"
"https://earthquake.usgs.gov/fdsnws/event/1/query?format=text&starttime=1969-12-31&endtime=1980-01-01&minmagnitude=5"
"https://earthquake.usgs.gov/fdsnws/event/1/query?format=text&starttime=1979-12-31&endtime=1990-01-01&minmagnitude=5"
"https://earthquake.usgs.gov/fdsnws/event/1/query?format=text&starttime=1989-12-31&endtime=2000-01-01&minmagnitude=5"
"https://earthquake.usgs.gov/fdsnws/event/1/query?format=text&starttime=1999-12-31&endtime=2010-01-01&minmagnitude=5"
"https://earthquake.usgs.gov/fdsnws/event/1/query?format=text&starttime=2009-12-31&endtime=2020-01-01&minmagnitude=5"
)

# Laço para garimpar dados e "appendá-los" em arquivo texto:
for url in ${urls[@]}
do
	echo $url
	curl -s "$url" | awk -F'|' '{print $2 "|" $11 "|" $9 "|" $13}' | sed '1d; s/T/|/' >> sismos.dat

# ANTES:
#	curl -sX GET $url | awk -F'|' '{print $2 "|" $11 "|" $9 "|" $13}' | sed '1d; s/T/|/' >> sismos_5+_desde_1950.txt

done

sort -ru sismos.dat > sismos_5+_desde_1950.txt		# Ordena e aplica UNIQ (-u)
rm sismos.dat						# Deleta o arquivo bruto.

# Autor: Helio Giroto 
