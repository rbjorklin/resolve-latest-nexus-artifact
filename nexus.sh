#!/bin/bash

USER="<your username here>"
PASS="<your password here>"
NEXUS_URL="https://nexus.example.com"

while [[ $# -gt 0 ]] ;do
    key="$1"
    
    case $key in
        -p|--publish)
        curl -i -X POST -u "${USER}:${PASS}" --header "Content-Type: application/json" ${NEXUS_URL}/service/rest/v1/script -d @resolveLatest.json
        shift # past argument
        ;;
        -r|--run)
        VALUE="$2"
        curl -X POST -u "${USER}:${PASS}" --header "Content-Type: text/plain" ${NEXUS_URL}/service/rest/v1/script/resolveLatest/run -d "${VALUE}"
        shift # past argument
        shift # past value
        ;;
        -u|--update)
        curl -i -X PUT -u "${USER}:${PASS}" --header "Content-Type: application/json" ${NEXUS_URL}/service/rest/v1/script/resolveLatest -d @resolveLatest.json
        shift # past argument
        ;;
        *)    # unknown option
        echo "Unknown option."
        exit 1
        ;;
    esac
done
