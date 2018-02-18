#!/bin/bash

# ESSE ESCRIPT RODA EM MAC...

# Avisará todos os terremotos acima de magnitude 2. 
# Caso quiera alterar a magnitude, modificar linhas 13 e 15:

hora_anterior=''

while :
do

	hora=$(curl -sX GET 'https://earthquake.usgs.gov/fdsnws/event/1/query?format=text&minmagnitude=2&starttime=yesterday' | awk -F'|' '{print $2 "|" $11 "|" $9 "|" $13}' | sed '1d; s/T/|/' | head -n1 | cut -d"|" -f2)

	local=$(curl -sX GET 'https://earthquake.usgs.gov/fdsnws/event/1/query?format=text&minmagnitude=2&starttime=yesterday' | awk -F'|' '{print $2 "|" $11 "|" $9 "|" $13}' | sed '1d; s/T/|/' | head -n1 | cut -d"|" -f4)
		
	[[ $hora == $hora_anterior ]] || { afplay beep.mp3; hora_anterior=$hora; open -a Safari https://earthquake.usgs.gov/earthquakes/eventpage/${local}#executive; }

	# No Raspberry Pi:
	# [[ $hora == $hora_anterior ]] || { omxplayer beep.mp3; hora_anterior=$hora; open -a Safari https://earthquake.usgs.gov/earthquakes/eventpage/${local}#executive; }
	
	# No Linux:
	# [[ $hora == $hora_anterior ]] || { cvlc --play-and-exit beep.mp3 ; hora_anterior=$hora; open -a Safari https://earthquake.usgs.gov/earthquakes/eventpage/${local}#executive; }




	sleep 10

done



