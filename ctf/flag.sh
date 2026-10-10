#!/bin/sh
# Places the player's flag (CTF_FLAG_MAIN, given by the launcher) in the zone vulhub.org, as the
# TXT record of flag.vulhub.org (included from /ctf/flag.db), then reloads the zone;
# without one (CI, a run by hand) the development flag.
dev='FLAG{dev-vulhub-dns-zone-transfer}'
flag=$(printf '%s' "${CTF_FLAG_MAIN:-$dev}" | sed 's/\\/\\\\/g; s/"/\\"/g')
printf 'flag IN TXT "%s"\n' "$flag" > /ctf/flag.db
chmod 444 /ctf/flag.db
i=0
until rndc reload vulhub.org >/dev/null 2>&1; do i=$((i+1)); [ $i -gt 30 ] && exit 1; sleep 1; done
i=0
until dig +short @127.0.0.1 flag.vulhub.org TXT | grep -q .; do i=$((i+1)); [ $i -gt 30 ] && exit 1; sleep 1; done
