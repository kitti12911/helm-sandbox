# helm-sandbox

Reusable Helm charts for homelab sandbox applications.

## Commands

| Command                       | Description                            |
| ----------------------------- | -------------------------------------- |
| `make lint CHART=<name>`      | Run selected chart and Markdown lint   |
| `make lint-all`               | Run all Helm and Markdown linting      |
| `make lint-helm CHART=<name>` | Lint the selected Helm chart           |
| `make lint-helm-all`          | Lint all discovered Helm charts        |
| `make markdownlint`           | Lint Markdown files                    |
| `make pretty`                 | Format Markdown, YAML, JSON, and JSONC |
| `make format`                 | Run document/config formatting         |
| `make chart-version`          | Print the selected chart version       |
| `make bump-chart-patch`       | Bump the selected chart patch version  |
| `make bump-chart-minor`       | Bump the selected chart minor version  |
| `make bump-chart-major`       | Bump the selected chart major version  |

Set `CHART=<name>` when running chart-specific commands.

## CI Scripts

Provider workflows should call the reusable scripts under `scripts/ci/` from a
toolchain container instead of duplicating commands in CI YAML:

| Script                       | Description                           |
| ---------------------------- | ------------------------------------- |
| `scripts/ci/helm-lint.sh`    | Lint all charts or `CHART=<name>`     |
| `scripts/ci/markdownlint.sh` | Run markdownlint-cli2 with pinned npx |

The GitHub workflow resolves shared toolchain images through repository
variables; the scripts themselves are CI-agnostic.
