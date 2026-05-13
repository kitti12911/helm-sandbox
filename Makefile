HELM_CHARTS := $(shell find charts -mindepth 2 -maxdepth 2 -name Chart.yaml -exec dirname {} \; | sort)
CHART_PATH := charts/$(CHART)

.PHONY: lint lint-all lint-helm ci-lint-helm lint-helm-all ci-lint-helm-all markdownlint ci-markdownlint pretty format require-chart chart-version bump-chart-patch bump-chart-minor bump-chart-major
lint: require-chart lint-helm markdownlint

lint-all:
	$(MAKE) lint-helm-all
	$(MAKE) markdownlint

lint-helm: require-chart
	CHART="$(CHART)" ./scripts/ci/helm-lint.sh

ci-lint-helm: lint-helm

lint-helm-all:
	./scripts/ci/helm-lint.sh

ci-lint-helm-all:
	./scripts/ci/helm-lint.sh

markdownlint:
	./scripts/ci/markdownlint.sh

ci-markdownlint:
	./scripts/ci/markdownlint.sh

pretty:
	prettier --write "**/*.{md,markdown,yml,yaml,json,jsonc}"

format: pretty

require-chart:
ifndef CHART
	$(error CHART is required, for example: make lint CHART=grpc-sandbox)
endif

chart-version: require-chart
	@yq '.version' "$(CHART_PATH)/Chart.yaml"

bump-chart-patch: require-chart
	@yq -i '.version = (.version | split(".") | .[2] = ((.[2] | tonumber) + 1 | tostring) | join("."))' "$(CHART_PATH)/Chart.yaml"

bump-chart-minor: require-chart
	@yq -i '.version = (.version | split(".") | .[1] = ((.[1] | tonumber) + 1 | tostring) | .[2] = "0" | join("."))' "$(CHART_PATH)/Chart.yaml"

bump-chart-major: require-chart
	@yq -i '.version = (.version | split(".") | .[0] = ((.[0] | tonumber) + 1 | tostring) | .[1] = "0" | .[2] = "0" | join("."))' "$(CHART_PATH)/Chart.yaml"
