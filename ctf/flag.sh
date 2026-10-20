#!/bin/sh
# >>> isoloom-1.0 secret-from-file shim (auto-added by convert-lab.py) >>>
# Inputs now arrive as files (isoloom.yml `files:`), not environment variables.
# Read each into its old variable when unset, keeping the dev/CI fallback working.
for __p in CTF_FLAG_MAIN:/run/lab/ctf_flag_main; do
  __n=${__p%%:*}; __f=${__p#*:}
  eval "__v=\${$__n:-}"
  if [ -z "$__v" ] && [ -s "$__f" ]; then
    __v=$(tr -d '\r\n' < "$__f"); eval "export $__n=\"\$__v\""
  fi
done
unset __p __n __f __v 2>/dev/null || true
# <<< isoloom-1.0 secret-from-file shim <<<
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
