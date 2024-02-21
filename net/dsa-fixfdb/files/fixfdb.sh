#!/bin/sh

bridge_device=$1

# monitor all new entries to the "forwarding database"; read the output line by
# line into variables 'mac', 'd', 'dev', and 'rest'
/usr/sbin/bridge monitor fdb | while read -r mac d dev rest; do 
  if [ "$mac" != Deleted ]; then
    echo Found "$mac" on "$dev";
    /usr/sbin/bridge fdb show br "$bridge_device" | while read -r omac d odev rest; do
# Check whether the mac address already exists on the bridge device, but 
# attached to a different network device -- if found, remove it
      if [ "$omac" = "$mac" ] && [ "$odev" != "$dev" ]; then
        echo Attempting to remove old entry for "$mac" from "$odev" as it should now be on "$dev";
# run bridge fdb del to remove the old entry; if error message is "RTNETLINK answers: No such file or directory", then the entry was already removed. Echo an appropriate message in that case.
        /usr/sbin/bridge fdb del "$mac" dev "$odev" "$rest" 2>&1 | grep -q "No such file or directory" && echo "Entry for $mac already removed from $odev" || echo "Error running /usr/sbin/bridge fdb del $mac dev $odev $rest";    
      fi;
    done;
 fi;
done