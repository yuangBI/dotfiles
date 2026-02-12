#!/bin/sh

json="$(niri msg --json workspaces 2>/dev/null)"
[ -n "$json" ] || json='[]'

printf '%s' "$json" | jq -r '
  def b($v): if $v then "true" else "false" end;

  reduce .[] as $w ({exists: {}, active: {}, urgent: {}};
    .exists[($w.idx | tostring)] = true |
    if $w.is_focused then .active[($w.idx | tostring)] = true else . end |
    if $w.is_urgent then .urgent[($w.idx | tostring)] = true else . end
  ) |
  . as $st |
  range(1; 10) as $i |
  "ws\($i)_exists|bool|\(b($st.exists[$i | tostring] // false))",
  "ws\($i)_active|bool|\(b($st.active[$i | tostring] // false))",
  "ws\($i)_urgent|bool|\(b($st.urgent[$i | tostring] // false))"
'

printf '\n'
