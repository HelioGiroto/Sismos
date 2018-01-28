#!/bin/bash

echo > sismos_meses.dat

for ano in {1950..2018}
do
	echo "-$ano:" >> sismos_meses.dat
	for mes in {01..12}
	do

		grep -Ec "$ano-$mes-.." sismos5+ >> sismos_meses.dat

	done
	grep -Ec "$ano-....." sismos5+ >> sismos_meses.dat
#	echo >> sismos_meses.dat
done

cat sismos_meses.dat | tr '\n' ' ' | tr '-' '\n' > tot-sismos.txt
sed -i 1d tot-sismos.txt




# PROGRAMA # 2:

for m in {2..14}
do
	awk -v m=$m '{tot+=$m} END {print tot}' tot-sismos.txt >> tot-meses.dat
done

echo >> tot-sismos.txt
echo "=====================================================" >> tot-sismos.txt
echo "TOTAL: " $(cat tot-meses.dat | xargs) >> tot-sismos.txt

rm *.dat

# Para saber o ano que mais teve terremoto:
# cat tot-sismos.txt | sort -nr -t' ' -k 14
