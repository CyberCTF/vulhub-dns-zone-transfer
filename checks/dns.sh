#!/bin/sh
# A normal SOA query for vulhub.org gets an answer from this server (no transfer is requested).
set -e
nslookup -type=soa vulhub.org dns | grep -qi 'vulhub.org'
