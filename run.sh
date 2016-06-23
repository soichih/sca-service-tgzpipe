#!/bin/bash

#make sure jq is installed on $SCA_SERVICE_DIR
if [ ! -f $SCA_SERVICE_DIR/jq ];
then
        echo "installing jq"
        wget https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 -O $SCA_SERVICE_DIR/jq
        chmod +x $SCA_SERVICE_DIR/jq
fi

input_dir=`$SCA_SERVICE_DIR/jq -r '.input_dir' config.json`

rm -f pipe #incase restarting

mkfifo pipe
tar -cz $input_dir > pipe &

echo "[]" > products.json
