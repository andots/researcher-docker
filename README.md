# RE:SEARCHER Docker

## Build & Start

```bash
docker compose -p researcher up --build
```

## Start

```bash
docker compose -p researcher up
```

## Health Check

```sh
curl http://127.0.0.1:9200/_cat/health?pretty
```

- kibana: <http://localhost:5601/>

## Docker Desktop on WSL2

```bash
wsl -d docker-desktop
sysctl -w vm.max_map_count=262144
```

## Version

- Elasticsearch: 7.10.1
- analysis-sudachi: v2.1.0
- SudachiDict: sudachi-dictionary-20210802-full
