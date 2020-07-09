#!/bin/sh

USER=pet
HOST=leg.ufpr.br
DIR=/home/pet/
read -p 'PORTA: ' PORT

hugo && rsync -avz -e "ssh -p $PORT" --delete docs/ ${USER}@${HOST}:${DIR}

exit 0
