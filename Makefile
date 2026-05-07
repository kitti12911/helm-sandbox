HELM_CHARTS := $(shell find charts -mindepth 2 -maxdepth 2 -name Chart.yaml -exec dirname {} \; | sort)

.PHONY: lint lint-helm markdownlint pretty format
lint: lint-helm markdownlint

lint-helm:
	@for chart in $(HELM_CHARTS); do \
		echo "helm lint $${chart}"; \
		helm lint "$${chart}"; \
	done

markdownlint:
	markdownlint-cli2

pretty:
	prettier --write "**/*.{md,markdown,yml,yaml,json,jsonc}"

format: pretty

.PHONY: lint-grpc-sandbox
lint-grpc-sandbox:
	helm lint charts/grpc-sandbox
