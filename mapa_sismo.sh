#!/bin/bash

# 	ESTE SCRIPT ABRIRÁ O NAVEGADOR NO MAPA DO SISMO DO LUGAR QUE ESTÁ A REFERÊNCIA EM CLIPBOARD

local=$(xclip -o)

# chromium-browser https://earthquake.usgs.gov/earthquakes/eventpage/${local}#map 

google-chrome https://earthquake.usgs.gov/earthquakes/eventpage/${local}#map 

# firefox https://earthquake.usgs.gov/earthquakes/eventpage/${local}#map 
