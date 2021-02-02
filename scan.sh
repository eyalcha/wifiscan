#!/bin/bash

# Init networks detetced per channel
channels=(0 0 0 0 0 0 0 0 0 0 0 0 0 0)

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
        # echo " $mac  $essid  $frq  $chn  $qual  $lvl  $enc"  # output after ESSID
        # Accumlate networks on channels
        channels[$chn]=$((channels[$chn]+1))
    }
done

# Return channels scan result
echo ${channels[@]}
