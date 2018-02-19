#!/bin/bash

# site='https://earthquake.usgs.gov/fdsnws/event/1/query?format=text' 			# Qualquer magnitude

site='https://earthquake.usgs.gov/fdsnws/event/1/query?format=text&minmagnitude=5'	# Avisa se Mag. é >= 5.0
hora_anterior=''

while :
do

	hora=$(curl -sX GET ${site} | sed '1d; s/T/|/' | head -n1 | cut -d"|" -f3)

 	local=$(curl -sX GET ${site} | sed '1d; s/T/|/' | head -n1 | cut -d"|" -f1)

	mag=$(curl -sX GET ${site} | sed '1d; s/T/|/' | head -n1 | cut -d"|" -f12) 
		
	[[ $hora == $hora_anterior ]] || { omxplayer beep.mp3 &> /dev/null; hora_anterior=$hora; chromium-browser https://earthquake.usgs.gov/earthquakes/eventpage/${local}#executive &> /dev/null; }
	# Outros sistemas ver no rodapé...

	echo "Último sismo: ${hora} UTC - ${mag}" #>> registros.txt
	sleep 10

done

	# OUTROS SISTEMAS:
	
	# No Mac:	
	# [[ $hora == $hora_anterior ]] || { afplay beep.mp3; hora_anterior=$hora; open -a Safari https://earthquake.usgs.gov/earthquakes/eventpage/${local}#executive; }

	# No Raspberry Pi:
	# [[ $hora == $hora_anterior ]] || { omxplayer beep.mp3; hora_anterior=$hora; chromium-browser https://earthquake.usgs.gov/earthquakes/eventpage/${local}#executive; }
	
	# No Linux:
	# [[ $hora == $hora_anterior ]] || { cvlc --play-and-exit beep.mp3 ; hora_anterior=$hora; chromium-browser https://earthquake.usgs.gov/earthquakes/eventpage/${local}#executive; }


# Autor: Hélio Giroto


