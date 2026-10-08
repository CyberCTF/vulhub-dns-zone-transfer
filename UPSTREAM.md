# Upstream

| | |
| --- | --- |
| Project | Vulhub |
| Repository | https://github.com/vulhub/vulhub |
| Environment | `dns/dns-zone-transfer` |
| Version | default branch (Vulhub has no releases) |
| Commit | 8fd63916f7a8711e2e01dda0d27237e4d6175d38 |
| Licence | MIT |

| Here | Vulhub path |
| --- | --- |
| `build/dns/app/` | [`dns/dns-zone-transfer`](https://github.com/vulhub/vulhub/tree/8fd63916f7a8711e2e01dda0d27237e4d6175d38/dns/dns-zone-transfer) |
| `base/bind/9.10.3/` | [`base/bind/9.10.3`](https://github.com/vulhub/vulhub/tree/8fd63916f7a8711e2e01dda0d27237e4d6175d38/base/bind/9.10.3): the Dockerfile of `vulhub/bind:9.10.3` |

The vendored folders are that commit, unchanged. The lab runs Vulhub's published image `vulhub/bind:9.10.3`, pinned by tag (as Vulhub's own compose file does); its Dockerfile is vendored under `base/` to show how it is built. Building from `base/` instead would download the vulnerable software from its original sources, some of which are gone.

`build/dns/Dockerfile` starts from `vulhub/bind:9.10.3` and copies `named.conf.local` and `vulhub.db`, which Vulhub's compose file mounts (Isoloom has no bind mounts). Vulhub publishes port 53 over TCP and UDP; Isoloom services have no protocol setting, so only TCP is published to the host (AXFR uses TCP). Inside the lab network both work.

To update, replace the vendored folders with a newer Vulhub commit, then change this file.
