#! /usr/bin/env bash
if [[ -a "$(dirname "$0")/clientid.sh" ]]; then
	source "$(dirname "$0")/clientid.sh"
else
	echo "clientid file not find"
fi

COUNT=30

Json=$(curl -H "Authorization: Client-ID $UNSPLASH_CLIENT_ID" \
	"https://api.unsplash.com/photos/random?orientation=landscape&count=$COUNT")


mapfile -t IMG_URLS < <(echo "$Json" | jq -r 'if type=="array" then .[].urls.raw else .urls.raw end')

for i in "${!IMG_URLS[@]}"; do
	curl -L "${IMG_URLS[$i]}" -o "$HOME/Pictures/$((i + 1)).jpg"
done
