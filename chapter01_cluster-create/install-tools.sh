#!/bin/bash

set -eu

KIND_VERSION=v0.20.0
KUBECTL_VERSION=v1.28.1
CILIUM_CLI_VERSION=v0.15.7
HELM_VERSION="v3.12.3"
HELMFILE_VERSION="0.156.0"
OS=darwin

sudo apt update -y && \
sudo apt install -y jq

echo "--- install kind ---"
echo "  see: https://kind.sigs.k8s.io/docs/user/quick-start/#installation"
curl -Lo ./kind https://kind.sigs.k8s.io/dl/${KIND_VERSION}/kind-${OS}-amd64
chmod +x kind
sudo mv kind /usr/local/bin/
kind --version
echo ""

echo "--- install kubectl ---"
echo "  see: https://kubernetes.io/ja/docs/tasks/tools/install-kubectl/#install-kubectl-on-linux"
curl -LO "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/${OS}/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/
echo ""

echo "--- install cilium CLI ---"
echo "  see: https://docs.cilium.io/en/stable/gettingstarted/k8s-install-default/#cilium-quick-installation"
curl -L --fail --remote-name-all https://github.com/cilium/cilium-cli/releases/download/${CILIUM_CLI_VERSION}/cilium-${OS}-amd64.tar.gz{,.sha256sum}
shasum -a 256 --check cilium-${OS}-amd64.tar.gz.sha256sum
sudo tar xzvfC cilium-${OS}-amd64.tar.gz /usr/local/bin
rm cilium-${OS}-amd64.tar.gz{,.sha256sum}
echo ""

echo "--- install helm ---"
echo "  see: https://helm.sh/docs/intro/install/#from-the-binary-releases"
curl -LO "https://get.helm.sh/helm-${HELM_VERSION}-${OS}-amd64.tar.gz"
tar -zxvf "helm-${HELM_VERSION}-${OS}-amd64.tar.gz"
sudo mv ${OS}-amd64/helm /usr/local/bin/helm
rm "helm-${HELM_VERSION}-${OS}-amd64.tar.gz"
echo ""

# echo "--- install helm-diff ---"
# echo "  see: https://github.com/databus23/helm-diff#install"
# helm plugin install https://github.com/databus23/helm-diff
# echo ""

echo "--- install helmfile ---"
echo "  see: https://github.com/helmfile/helmfile#installation"
curl -LO "https://github.com/helmfile/helmfile/releases/download/v${HELMFILE_VERSION}/helmfile_$(echo ${HELMFILE_VERSION})_${OS}_amd64.tar.gz"
tar -zxvf "helmfile_$(echo ${HELMFILE_VERSION})_${OS}_amd64.tar.gz"
sudo mv helmfile /usr/local/bin/helmfile
rm "helmfile_$(echo ${HELMFILE_VERSION})_${OS}_amd64.tar.gz"
echo ""
