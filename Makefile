HELM_CHARTS := $(shell find charts -mindepth 2 -maxdepth 2 -name Chart.yaml -exec dirname {} \; | sort)
CHART_PATH := charts/$(CHART)

.PHONY: lint lint-all lint-helm lint-helm-all markdownlint pretty format require-chart chart-version bump-chart-patch bump-chart-minor bump-chart-major
lint: require-chart lint-helm markdownlint

lint-all:
	@for chart in $(HELM_CHARTS); do \
		echo "helm lint $${chart}"; \
		helm lint "$${chart}"; \
	done
	markdownlint-cli2

lint-helm: require-chart
	helm lint "$(CHART_PATH)"

lint-helm-all:
	@for chart in $(HELM_CHARTS); do \
		echo "helm lint $${chart}"; \
		helm lint "$${chart}"; \
	done

markdownlint:
	markdownlint-cli2

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
