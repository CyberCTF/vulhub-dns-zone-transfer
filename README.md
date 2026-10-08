# DNS Zone Transfer (AXFR) Information Disclosure

[Vulhub](https://vulhub.org)'s [`dns/dns-zone-transfer`](https://github.com/vulhub/vulhub/tree/8fd63916f7a8711e2e01dda0d27237e4d6175d38/dns/dns-zone-transfer) environment, by
phith0n and the Vulhub contributors: BIND 9.10.3 serving the vulhub.org zone without an `allow-transfer` restriction, so anyone downloads the whole zone with an AXFR request. This repository runs it with
[Isoloom](https://www.isoloom.com): [`isoloom.yml`](isoloom.yml) describes the machine, and
the machine runs Vulhub's published image `vulhub/bind:9.10.3` with Vulhub's zone files copied in ([`build/dns/`](build/dns)); the environment folder is vendored in [`build/dns/app/`](build/dns/app) and the image's Dockerfile in [`base/`](base).

| Machine | Service |
| --- | --- |
| dns | BIND 9.10.3 on port 53 (TCP published; UDP inside the lab network) |

## Run it

```bash
isoloom generate
isoloom run docker
```

Then query it with `dig @127.0.0.1 -p 53 +tcp vulhub.org SOA` (the published port is TCP only; inside the lab network UDP works too). The same spec runs as Docker on a local VM (`docker-vm`), on a
cloud VM (`cloud-docker`) or on Kubernetes. Lab guide: Vulhub's
[README](https://github.com/vulhub/vulhub/tree/8fd63916f7a8711e2e01dda0d27237e4d6175d38/dns/dns-zone-transfer/README.md) for this environment, with the walkthrough and references.

Upstream version and commit: [UPSTREAM.md](UPSTREAM.md).

## Licence

MIT, as Vulhub ([LICENSE](LICENSE)). The vulnerable software inside the image keeps its own licence.
This environment is deliberately vulnerable: keep it isolated.
