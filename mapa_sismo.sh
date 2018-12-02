#!/bin/bash

# 	ESTE SCRIPT ABRIRÁ O NAVEGADOR NO MAPA DO SISMO DO LUGAR QUE ESTÁ A REFERÊNCIA EM CLIPBOARD

local=$(xclip -o)
firefox https://earthquake.usgs.gov/earthquakes/eventpage/${local}#map

# chromium-browser https://earthquake.usgs.gov/earthquakes/eventpage/${local}#map



