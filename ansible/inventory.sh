#!/bin/bash

case "$1" in
--list) cat ./inventory.json ;;
--host) echo "{}" ;;
esac
