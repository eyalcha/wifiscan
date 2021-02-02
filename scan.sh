#!/bin/bash

# Init result (ssid channel, 13 channels)
result=(0 0 0 0 0 0 0 0 0 0 0 0 0 0)

# Scan and parse
while IFS= read -r line; do

  ## Test line contenst and parse as required
  [[ "$line" =~ Address ]] && mac=${line##*ss: }
  [[ "$line" =~ \(Channel ]] && { chn=${line##*nel }; chn=${chn:0:$((${#chn}-1))}; }
  [[ "$line" =~ Frequen ]] && { frq=${line##*ncy:}; frq=${frq%% *}; }
  [[ "$line" =~ Quality ]] && { 
      qual=${line##*ity=}
      qual=${qual%% *}
      lvl=${line##*evel=}
      lvl=${lvl%% *}
  }
  [[ "$line" =~ Encrypt ]] && enc=${line##*key:}
  [[ "$line" =~ ESSID ]] && {
      essid=${line##*ID:}
      # Accumlate networks onin channel
      result[$chn]=$((result[$chn]+1));
      # Set ssid channel (if specified)
      if [[ "$essid" == "\"$SSID\"" ]]; then
        result[0]=$chn
      fi
      # echo " $mac  $essid  $frq  $chn  $qual  $lvl  $enc"  # output after ESSID
  }

done

# Return channels scan result
echo "${result[@]}"
