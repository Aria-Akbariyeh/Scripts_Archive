#!/bin/bash

#define the target and wordlist variables
Target = "target.ine.local"
Words_List = "/root/Desktop/wordlists.shares.txt"

#Check if wordlist doesn't exist
if [ ! -f "$Words_List"]; then
	echo "Wordlist not found: $Words_List"
	exit 1
fi


#Loop through each share in the wordlist
while read -r SHARE; do
	echo "Testing share: $SHARE"
	smbclient //$TARGET/$SHARE -N -c "ls" &>/dev/nul

	if [ $? -eq 0 ]; then
        echo "[+] Anonymous access allowed for: $SHARE"
    else
        echo "[-] Access denied for: $SHARE"
    fi

done < "$WORDLIST"

