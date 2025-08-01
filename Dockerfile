#syntax=docker/dockerfile:1

ARG VARIANT=scratch

FROM --platform=$BUILDPLATFORM alpine:3.22.1 AS kubectl

ARG KUBECTL_VERSION

ARG TARGETARCH
RUN <<EOT
  set -eux

  if [[ "${KUBECTL_VERSION:-}" == "" ]]; then
    KUBECTL_VERSION="$(wget -O- https://dl.k8s.io/release/stable.txt)"
  fi

  wget "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/${TARGETARCH}/kubectl"
  chmod +x kubectl
EOT

FROM alpine:3.22.1 AS kubectl-alpine
COPY --from=kubectl /kubectl /usr/local/bin
ENTRYPOINT ["kubectl"]

FROM scratch AS kubectl-scratch
COPY --from=kubectl /kubectl /
ENTRYPOINT ["/kubectl"]

FROM kubectl-$VARIANT
ENV KUBECONFIG=/.kube/config
