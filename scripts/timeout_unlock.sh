#!/bin/bash

FILE=~/.timeout_info_temp
if [ -f "$FILE" ]; then
    line=$( cat ~/.timeout_info_temp | grep Standby  )

    sta1=$( echo $line | sed 's/^Standby:[[:blank:]]*\([0-9]*\).*/\1/' )
    sta2=$( echo $line | sed 's/^.*Suspend:[[:blank:]]*\([0-9]*\).*/\1/' )
    sta3=$( echo $line | sed 's/^.*Off:[[:blank:]]*\([0-9]*\).*/\1/' )

    # echo "Standby: $sta1"
    # echo "Suspend: $sta2"
    # echo "Off: $sta2"
    
    xset dpms $sta1 $sta2 $sta3
    rm -rf ~/.timeout_info_temp
else
    xset dpms 600 900 1200
    notify-send -t 15000 "[Error]: Cannot read screen timeout temp file!" "Screen timeout set to 10 minutes. Check the scirpt."
fi
