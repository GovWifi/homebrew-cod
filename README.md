homebrew-gds
============

A private Homebrew tap for the internal COD CLI tooling, like the [cod-cli](https://github.com/govwifi/cod-cli).

## COD CLI

### Pre-requisites

- An SSH key configured in GitHub, as the cod-cli repo clones over SSH.

### Usage

```
brew tap govwifi/cod
brew install cod-cli
cod --version
```

or

```
brew install govwifi/cod/cod-cli
cod --version
```
