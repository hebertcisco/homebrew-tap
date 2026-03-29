# Homebrew Tap

[![Publish to Homebrew Core](https://github.com/hebertcisco/homebrew-tap/actions/workflows/publish-core.yml/badge.svg)](https://github.com/hebertcisco/homebrew-tap/actions/workflows/publish-core.yml)

This repository hosts Hebert Cisco's custom Homebrew tap and the automation
that keeps the maintained formulae in sync with `Homebrew/homebrew-core`.

## Available formulae

| Formula | Description | Version |
| --- | --- | --- |
| `oscleaner` | Cross-platform system cleanup CLI | 1.0.0 |

## Quick install

```sh
brew tap hebertcisco/homebrew-tap
brew install oscleaner
```

## Local development

```sh
brew update
git clone https://github.com/hebertcisco/homebrew-tap.git
cd homebrew-tap
brew install --build-from-source Formula/oscleaner.rb
brew test oscleaner
brew audit --strict oscleaner
```

## How releases work

The tap is updated automatically by the
[release-macos](https://github.com/hebertcisco/oscleaner/actions/workflows/release-macos.yml)
workflow in the main `oscleaner` repository. When a new `v*` tag is pushed:

1. Binaries are built for macOS (Apple Silicon + Intel) and Linux x86_64.
2. Homebrew bottles are built on macOS 14, macOS 15 Intel, and Ubuntu.
3. The formula in this tap is updated with the new version, SHA256, and bottle
   metadata, then committed and pushed automatically.

No manual formula edits are needed for routine version bumps.

## Publishing to `homebrew-core`

Homebrew still requires contributors to follow the
[homebrew-core contributing guide](https://github.com/Homebrew/homebrew-core/blob/main/CONTRIBUTING.md)
and the [Formula Cookbook](https://docs.brew.sh/Formula-Cookbook#commit), but
this tap automates most of the manual work via
`.github/workflows/publish-core.yml`.

### Automatic updates (existing formula)

Any push to `main` that touches `Formula/*.rb` kicks off the workflow, which:

1. Installs, tests, and audits the tap formula locally (`brew install
   --build-from-source`, `brew test`, `brew audit --new --strict`).
2. Calls `brew bump-formula-pr --strict --version=<detected> <formula>` to
   open a PR against `Homebrew/homebrew-core`.
3. BrewTestBot merges automatically once the PR passes CI in `homebrew-core`.

### First-time submissions (new formula)

When a formula does not yet exist in `homebrew-core`, the workflow bootstraps
the submission:

1. Add a `Formula/<formula>.rb.core` template to this repo. This file is
   copied verbatim into the `homebrew-core` checkout, so keep it in sync with
   the version and URLs you intend to release.
2. The workflow forks `homebrew-core`, creates a branch
   `add-<formula>-<version>`, copies the template, runs `brew audit
   --new-formula`, commits, pushes, and opens a PR via `gh pr create`.

### Manual dispatch

The workflow can be triggered manually from the Actions tab. Supply a `formula`
name to override the auto-detected set.

### Required secrets and variables

| Secret / Variable | Where | Purpose |
| --- | --- | --- |
| `HOMEBREW_GITHUB_API_TOKEN` | This repo (secret) | PAT with `repo` scope for pushing to your `homebrew-core` fork and authenticating with the GitHub CLI |
| `HOMEBREW_CORE_FORK_OWNER` | This repo (variable, optional) | Override the fork owner when the fork lives under a different account or org. Defaults to the pushing user |

The default `GITHUB_TOKEN` is not sufficient — a Personal Access Token with
`repo` scope is required.

## Code of Conduct

All contributors must follow the
[Homebrew Code of Conduct](https://github.com/Homebrew/.github/blob/HEAD/CODE_OF_CONDUCT.md#code-of-conduct).
