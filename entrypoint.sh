#!/bin/bash
# mailto: ext.igor.drobot@nordlb.de
# Docker container main point of entry

echo "$(date +'%H:%M:%S %d-%m-%Y') INFO: Entering the entrypoint.sh"
echo "$(date +'%H:%M:%S %d-%m-%Y') INFO: Passed stage name: $STAGE"

# Check for the STAGE
if [[ -z ${STAGE} ]]; then
    echo "$(date +'%H:%M:%S %d-%m-%Y') ERROR: STAGE is not defined!"
    exit 1
fi

# Check for the REST_PORT
if [[ -z ${REST_PORT} ]]; then
    echo "$(date +'%H:%M:%S %d-%m-%Y') ERROR: REST_PORT is not defined!"
    exit 1
fi

# set port in a dirty way
sed -i "s/REST_PORT/${REST_PORT}/" app.py

python3 app.py

echo "$(date +'%H:%M:%S %d-%m-%Y') INFO: Completed the execution of entrypoint.sh"
