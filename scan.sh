#!/bin/bash

# SSID to match
ssid=$SSID

# Level in dbm. Only networks with higher level values will be counted.
level=${LEVEL:--999}

# Min level for levels array
min_level=${MIN_LEVEL:--100}

# Ssid channel (if SSID specified)
ssid_channel=0

# Networks per channel
networks=(0 0 0 0 0 0 0 0 0 0 0 0 0 0)

# Channel max level
levels=($min_level $min_level $min_level $min_level $min_level $min_level $min_level $min_level $min_level $min_level $min_level $min_level $min_level $min_level)

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
      # Accumlate networks in channel
      if [ $lvl -gt $level ]; then
        networks[$chn]=$((networks[$chn]+1));
      fi
      # Set ssid channel (if specified)
      if [[ "$essid" == "\"$ssid\"" ]]; then
        ssid_channel=$chn
      fi
      #      
      if [ $lvl -gt ${levels[$chn]} ]; then
        levels[$chn]="$lvl"
      fi
      # echo " $mac  $essid  $frq  $chn  $qual  $lvl  $enc"  # output after ESSID
  }

done


# Return channels scan result
echo $ssid_channel "${networks[@]:1}" "${levels[@]:1}"
