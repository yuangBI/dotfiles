#!/bin/sh

wallpaper="${HOME}/Pictures/wallpaper.jpg"

swaylock -fe \
	-i "$wallpaper" \
	-s fill \
	--show-failed-attempts \
	--font "Iosevka Term" \
	--font-size 24 \
	--indicator-radius 120 \
	--indicator-thickness 8 \
	--ring-color "2a2f38" \
	--ring-clear-color "2a2f38" \
	--ring-ver-color "8ab4f8" \
	--ring-wrong-color "e57373" \
	--key-hl-color "c5e1a5" \
	--bs-hl-color "f5c2e7" \
	--separator-color "00000000" \
	--line-color "00000000" \
	--inside-color "00000055" \
	--inside-clear-color "00000055" \
	--inside-ver-color "1e3a5f88" \
	--inside-wrong-color "5f1e1e88" \
	--text-color "e6edf3" \
	--text-clear-color "e6edf3" \
	--text-ver-color "e6edf3" \
	--text-wrong-color "e6edf3"
