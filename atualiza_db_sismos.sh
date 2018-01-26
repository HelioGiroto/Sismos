#!/bin/bash


hoje=$( date +%s )
anterior=$( ls -l sismos5+ | date +%s )


periodo=$( echo $(( ( $hoje - $anterior ) / (60*60*24) +2 )) )		


curl -sX GET 'https://earthquake.usgs.gov/fdsnws/event/1/query?format=text&minmagnitude=5&starttime=-'$periodo'days' | awk -F'|' '{print $2 "|" $11 "|" $9 "|" $13}' | sed '1d; s/T/|/' > ult_sismos


cat ult_sismos sismos5+ | sort -ur > recente	
						
mv sismos5+ sismos5+.antigo
mv recente sismos5+
rm ult_sismos 


# diff -12 sismos5+ sismos5+.antigo 		# Opcional para ver as mudanças

# Autor: Helio Giroto
