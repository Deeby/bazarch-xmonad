#!/bin/bash
# Get the maximum volume of any pulseaudio sink channel
# amixer get Master | egrep -o "[0-9]+%"
mute=$(amixer get Master | awk  '/'Front' 'Left:' 'Playback'/  {print $6}')

vol=$(amixer get Master | awk -F'[]%[]' '/%/ {if ($7 == "off") { print "MM" } else { print $2 }}' | head -n 1)

if [ "$vol" -le "30" -a "$mute" = "[on]" ]
	then echo "<fc=blue><fn=2>  </fn></fc><fc=blue>$vol% </fc>"
elif [ "$vol" -le "60" -a "$mute" = "[on]" ]
	then echo "<fc=green><fn=2>  </fn></fc><fc=green>$vol% </fc>"
elif [ "$vol" -le "90" -a "$mute" = "[on]" ]
	then echo "<fc=orange><fn=2>  </fn></fc><fc=orange>$vol% </fc>"
elif [ "$vol" -gt "90" -a "$mute" = "[on]" ]
	then echo "<fc=red><fn=2>  </fn></fc><fc=red>$vol% </fc>"

elif [ "$mute" = "[off]" ]
	then echo "<fc=blue><fn=2>  </fn></fc><fc=blue> Mute </fc>"
else
	echo  echo "<fc=red><fn=2>  </fn></fc><fc=red>$vol% </fc>"

fi

exit 0
