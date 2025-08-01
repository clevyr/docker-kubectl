# docker-kubectl

Lightweight, up-to-date Docker images with kubectl.

## Tags

All tags follow the pattern:

```
ghcr.io/clevyr/kubectl:<k8s-version>[-variant]
```

- `latest` contains the latest Kubernetes release
- `alpine` is the Alpine Linux variant and contains the latest Kubernetes release
- `v1.33` pin to a specific Kubernetes version.
- Variants:
  - **(no suffix):** Based on `scratch`
  - **`-alpine`:** Based on Alpine Linux

## Examples

### Scratch Image

```shell
docker run --rm -it \
  -v ~/.kube:/.kube:ro \
  ghcr.io/clevyr/kubectl get pods
````

### Alpine Image

```shell
docker run --rm -it \
  -v ~/.kube:/.kube:ro \
  ghcr.io/clevyr/kubectl:alpine get pods
```
