#!/usr/bin/env sh
set -eu

repo_dir="$(pwd)"
cd "${repo_dir}"

if [ "$#" -gt 0 ]; then
	exec helm lint "$@"
fi

if [ -n "${CHART:-}" ]; then
	exec helm lint "charts/${CHART}"
fi

charts="$(find charts -mindepth 2 -maxdepth 2 -name Chart.yaml -exec dirname {} \; 2>/dev/null | sort || true)"
if [ -z "${charts}" ]; then
	echo "no Helm charts to lint"
	exit 0
fi

for chart in ${charts}; do
	echo "helm lint ${chart}"
	helm lint "${chart}"
done
