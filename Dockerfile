ARG ARGOCD_VERSION=v3.3.9
FROM quay.io/argoproj/argocd:${ARGOCD_VERSION}

USER root

ARG SOPS_VERSION=3.9.0
ARG KUSTOMIZE_VERSION=5.4.3

RUN apt-get update && \
    apt-get install -y --no-install-recommends curl ca-certificates tar gzip && \
    rm -rf /var/lib/apt/lists/*

RUN curl -fsSL \
    -o /usr/local/bin/sops \
    https://github.com/getsops/sops/releases/download/v${SOPS_VERSION}/sops-v${SOPS_VERSION}.linux.amd64 && \
    chmod +x /usr/local/bin/sops

RUN curl -fsSL \
    https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv${KUSTOMIZE_VERSION}/kustomize_v${KUSTOMIZE_VERSION}_linux_amd64.tar.gz \
    | tar -xz -C /usr/local/bin && \
    chmod +x /usr/local/bin/kustomize

USER argocd