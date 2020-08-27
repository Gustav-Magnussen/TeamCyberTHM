#!/bin/bash

FINALNUMB=0
HOPS=0
while true; do
    $(wget http://10.10.156.128:3010/ -q -l -O)
    PORT=$(sed -n '/hostname+/,/script/p' index.html | cut -d'"' -f6)
    FILE=index.html
    if test -f "$FILE"; then
        $(rm index.html)
        while true; do
            LESSPORT=$PORT
            LESSPORT=$(echo $PORT | sed -e 's/://g')
            if [[ "$LESSPORT" = "9765" ]]; then
                break
            fi
            ADDRESS='http://10.10.156.128/'
            FULLADDRESS=$ADDRESS$PORT
            echo $FULLADDRESS
            while true; do
                $(wget ${FULLADDRESS} -q -l -O)
                if test -f "$FILE"; then
                    echo "Connect"
                    HOPS=$(($HOPS + 1))
                    break
                fi
            done
            FILE=index.html
            DISPLAY=$(cat index.html)
            if [[ $DISPLAY == "STOP" ]]; then
                exit
            fi
            DISP="Final Number:"
            H="Hops:"
            NUMS=$DISP$FINALNUMB
            HOPSD=$H$HOPS
            echo $DISPLAY
            TYPE=$(cut index.html -d' ' -f1)
            NUMBER=$(cut index.html -d' ' -f2)
            PORTN=$(cut index.html -d' ' -f3)
            EXTRA=":"
            $(rm index.html)
            echo $NUMS
            if [ "$TYPE" = "add" ]; then
                FINALNUMB=$(bc <<< "scale=2; $FINALNUMB + $NUMBER")
                PORT=$EXTRA$PORTN
            elif [ "$TYPE" = "minus" ]; then
                FINALNUMB=$(bc <<< "scale=2; $FINALNUMB - $NUMBER")
                PORT=$EXTRA$PORTN
            elif [ "$TYPE" = "divide" ]; then
                FINALNUMB=$(bc <<< "scale=2; $FINALNUMB / $NUMBER")
                PORT=$EXTRA$PORTN
            elif [ "$TYPE" = "multiply" ]; then
                FINALNUMB=$(bc <<< "sclae=2;$FINALNUMB * $NUMBER")
                PORT=$EXTRA$PORTN
            else
                echo "Wrong port!"
                break
            fi
            echo $HOPSD
        done
        if test -f "$FILE"; then
            break
        fi
    fi
done
echo $FINALNUMB
echo $HOPS
