#!/bin/sh

if [ ! $3 ]
then
	echo Usage: $0 [--ssl] username ip.addr sitename.tld [alias.tld ...]
	exit 1
fi

# Handle command-line parameters
if [ "$1" = "--ssl" ]
then
	ARG_USE_SSL=yes
	shift
fi
ARG_USERNAME=$1
ARG_IP=$2
ARG_SITENAME=$3
CONF=$ARG_SITENAME.conf
ARG_ALIAS_LIST=""
while [ $4 ]
do
	ARG_ALIAS_LIST="$ARG_ALIAS_LIST $4 www.$4"
	shift
done

./template.sh <virthost.tpl >virthost.tpl.sh

IP="*"
PORT="80"
USERNAME=$ARG_USERNAME
SITENAME=$ARG_SITENAME
ALIAS_LIST="www.$ARG_SITENAME $ARG_ALIAS_LIST"
USE_SSL="no"
. virthost.tpl.sh >$CONF

if [ "$ARG_USE_SSL" = "yes" ]
then
    IP=$ARG_IP
    PORT="443"
	SITENAME="www.$ARG_SITENAME"
    ALIAS_LIST=""
    USE_SSL="yes"
    . virthost.tpl.sh >>$CONF
fi
