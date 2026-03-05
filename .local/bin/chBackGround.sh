#! /usr/bin/env bash
if [[ -a ~/Pictures/1.jpg ]]; then
	echo "mv -f ~/Pictures/1.jpg ~/Pictures/wallpaper.jpg"
	cp -f ~/Pictures/1.jpg ~/Pictures/wallpaper.jpg
fi

if command -v awww >/dev/null ; then
awww img "$HOME/Pictures/wallpaper.jpg" \
  --transition-type random \
  --transition-duration 2 \
  --transition-fps 60
#awww img ~/Pictures/wallpaper.jpg
else

	pkill swaybg 2>/dev/null || true
	swaybg -i ~/Pictures/wallpaper.jpg -m fill & 
fi

pkill -f "/home/bi/.local/bin/downloadPictures.sh"
bash -c "$(dirname "$0")/downloadPictures.sh"
