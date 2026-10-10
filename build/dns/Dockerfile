# Vulhub's dns/dns-zone-transfer (in app/) runs vulhub/bind:9.10.3 with named.conf.local and
# vulhub.db mounted from the environment folder. Isoloom has no bind mounts, so this image copies
# the same files to the same places. Nothing else differs.
FROM vulhub/bind:9.10.3
COPY app/named.conf.local /etc/bind/named.conf.local
COPY app/vulhub.db /etc/bind/vulhub.db
# CyberCTF: the zone also includes /ctf/flag.db, the TXT record flag.vulhub.org written by
# ctf/flag.sh at every start (an empty placeholder until then).
RUN printf '\n$INCLUDE /ctf/flag.db\n' >> /etc/bind/vulhub.db && mkdir -p /ctf && touch /ctf/flag.db
