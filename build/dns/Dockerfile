# Vulhub's dns/dns-zone-transfer (in app/) runs vulhub/bind:9.10.3 with named.conf.local and
# vulhub.db mounted from the environment folder. Isoloom has no bind mounts, so this image copies
# the same files to the same places. Nothing else differs.
FROM vulhub/bind:9.10.3
COPY app/named.conf.local /etc/bind/named.conf.local
COPY app/vulhub.db /etc/bind/vulhub.db
