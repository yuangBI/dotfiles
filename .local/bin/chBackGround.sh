#! /usr/bin/env bash
if [[ -a "$(dirname "$0")/clientid.sh" ]]; then
	source "$(dirname "$0")/clientid.sh"
else
	echo "clientid file not find"
fi

COUNT=30
if [[ -a ~/Pictures/1.jpg ]]; then
	mv -f ~/Pictures/1.jpg ~/Pictures/wallpaper.jpg
fi
pkill swaybg 2>/dev/null || true

swaybg -i ~/Pictures/wallpaper.jpg -m fill & 

Json=$(curl -H "Authorization: Client-ID $UNSPLASH_CLIENT_ID" \
	"https://api.unsplash.com/photos/random?orientation=landscape&count=$COUNT")


mapfile -t IMG_URLS < <(echo "$Json" | jq -r 'if type=="array" then .[].urls.raw else .urls.raw end')

for i in "${!IMG_URLS[@]}"; do
	curl -L "${IMG_URLS[$i]}" -o "$HOME/Pictures/$((i + 1)).jpg"
done
