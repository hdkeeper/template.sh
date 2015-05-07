#!/bin/sh

# $SUBSTITUTION
# <if $EXPR> ... <else> ... </if>
# <for ITEM in $LIST> ... </for>

cat | sed -E -e 's/\\/\\\\\\\\/g' -e 's/"/\\"/g' -e 's/%/%%/g' \
-e 's/^(.*)$/printf "\1\\n"/' | \
sed -E -e 's/<if ([^>]*)>/"; if [ \1 ]; then printf "/' \
-e 's/<else>/"; else printf "/' \
-e 's/<\/if>/"; fi; printf "/' \
-e 's/<for ([^>]+)>/"; for \1; do printf "/' \
-e 's/<\/for>/"; done; printf "/'
