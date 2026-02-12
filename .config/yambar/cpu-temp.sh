#!/bin/sh

sensor=""
for zone in /sys/class/thermal/thermal_zone*; do
    [ -r "$zone/type" ] || continue
    zone_type="$(cat "$zone/type" 2>/dev/null)"
    case "$zone_type" in
        *cpu*|*x86_pkg_temp*|*Tctl*|*soc_thermal*)
            sensor="$zone"
            break
            ;;
    esac
done

[ -n "$sensor" ] || sensor="/sys/class/thermal/thermal_zone0"
raw_temp="$(cat "$sensor/temp" 2>/dev/null)"
[ -n "$raw_temp" ] || raw_temp=0

temp_c=$((raw_temp / 1000))
if [ "$temp_c" -ge 60 ]; then
    hot=true
else
    hot=false
fi

echo "temp|int|${temp_c}"
echo "hot|bool|${hot}"
echo ""
