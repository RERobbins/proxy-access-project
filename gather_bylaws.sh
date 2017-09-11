#!/bin/bash

COUNTER=0

dos2unix $1
while IFS=$'\t' read NAME URL
do
    if [[ "$URL" == *"http"* ]]; then
	let COUNTER=COUNTER+1
        CLEANED_NAME=$(echo $NAME | \
			       sed "s/ *$\|[\.,\(\)]//g" | \
			       sed "s/\o222//g" | \
			       sed "s/\o77//g" | \
			       sed "s/f\/k\/a/fka/g" | \
			       sed "s/ & / and /g" | \
			       sed "s/&/ and /g" |
			       sed "s/ /-/g" |
			       sed "s/\o57/-/g" |
			       sed "s/\o240/-/g"
			)
	OUTPUT_FILE_NAME=$(echo `printf %03d $COUNTER`-$CLEANED_NAME\.docx)
	CLEANED_URL=$(echo $URL | sed "s/$//g")
	pandoc -o $OUTPUT_FILE_NAME $CLEANED_URL
    fi
done < "$1"


