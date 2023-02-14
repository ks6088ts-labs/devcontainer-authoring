[![test](https://github.com/ks6088ts-labs/devcontainer-authoring/workflows/test/badge.svg)](https://github.com/ks6088ts-labs/devcontainer-authoring/actions/workflows/test.yml)

# devcontainer-authoring
Devcontainer for authoring

## How to use

### Devcontainer

- **Prerequisites**
    - Docker
- **Steps**
    1. Open VS Code
    1. Open command palette (`ctrl+shift+p`)
    1. Select `Dev Containers: Reopen in Container`

### Local

- **Prerequisites**
    - Node.js
    - GNU Make
- **Steps**
    1. Open VS Code
    1. Install extensions listed in [extensions.json](./.vscode/extensions.json)
    1. Run `make install-deps-dev` to install dependencies
