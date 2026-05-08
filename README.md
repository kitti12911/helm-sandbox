# helm-sandbox

Reusable Helm charts for homelab sandbox applications.

## Commands

| Command                    | Description                            |
| -------------------------- | -------------------------------------- |
| `make lint`                | Run Helm and Markdown linting          |
| `make lint-helm`           | Lint all discovered Helm charts        |
| `make lint-grpc-sandbox`   | Lint the `grpc-sandbox` Helm chart     |
| `make markdownlint`        | Lint Markdown files                    |
| `make pretty`              | Format Markdown, YAML, JSON, and JSONC |
| `make format`              | Run document/config formatting         |
| `make chart-version`       | Print the selected chart version       |
| `make bump-chart-patch`    | Bump the selected chart patch version  |
| `make bump-chart-minor`    | Bump the selected chart minor version  |
| `make bump-chart-major`    | Bump the selected chart major version  |

Set `CHART=<name>` when running chart version commands.
