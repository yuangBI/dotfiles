#! /usr/bin/env bash
if [[ -a "$(dirname "$0")/clientid.sh" ]]; then
	source "$(dirname "$0")/clientid.sh"
else
	echo "clientid file not find"
fi
if [[ -a ~/Pictures/new.jpg ]]; then
	mv -f ~/Pictures/new.jpg ~/Pictures/wallpaper.jpg
fi
pkill swaybg 2>/dev/null || true

swaybg -i ~/Pictures/wallpaper.jpg -m fill & 

Json=$(curl -H "Authorization: Client-ID $UNSPLASH_CLIENT_ID" \
	https://api.unsplash.com/photos/random?orientation=landscape)
	IMG_URL=$(echo "$Json" | jq -r '.urls.raw')
	curl -L "$IMG_URL" -o "/home/bi/Pictures/new.jpg"  
