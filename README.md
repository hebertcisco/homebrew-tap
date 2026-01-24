# Homebrew Tap

This repository hosts Hebert Cisco's custom Homebrew tap and the automation
needed to eventually land the maintained formulae in `Homebrew/homebrew-core`.

## Available formulae

| Formula | Description |
| --- | --- |
| `oscleaner` | Cross-platform system cleanup CLI |

## Use the tap locally

```sh
brew tap hebertcisco/homebrew-tap
brew install oscleaner
```

To develop or test locally, work from the tap checkout:

```sh
brew update
git clone https://github.com/hebertcisco/homebrew-tap.git
cd homebrew-tap
brew install --build-from-source Formula/oscleaner.rb
brew test oscleaner
brew audit --strict oscleaner
```

## Publishing to `homebrew-core`

Homebrew requires all new or updated formulae to follow the steps described in
the [homebrew-core contributing guide](https://github.com/Homebrew/homebrew-core/blob/main/CONTRIBUTING.md)
and the [Formula Cookbook](https://docs.brew.sh/Formula-Cookbook#commit).
The high-level checklist for this tap is:

1. **Update the formula** in `Formula/` (URL, version, SHA256, test block, etc.).
2. **Test locally** with:
   - `HOMEBREW_NO_INSTALL_FROM_API=1 brew install --build-from-source <formula>`
   - `brew test <formula>`
   - `brew audit --new --strict <formula>`
3. **Create an atomic commit** per the Cookbook's commit rules:
   - First line must be `formula-name version` (e.g. `oscleaner 1.0.1`) or
     `formula-name: short fix summary`.
   - Keep the summary <= 50 characters, add a blank line, then an explanation.
4. **Open a pull request in `homebrew-core`**. Run
   `brew bump-formula-pr --strict <formula> --url=<tarball> --sha256=<sha>` (or
   pass `--tag`/`--revision`) from a machine that has your fork of
   `Homebrew/homebrew-core` so the command can push a branch and open the PR.
5. **Link issues / close requests** using `Closes #123`. Address any CI notes
   before requesting review from the Homebrew maintainers.

Once your PR is approved, BrewTestBot will merge it automatically; no extra
action is required on the tap.

## GitHub Action: publish to core

The workflow defined in `.github/workflows/publish-core.yml` runs on
`workflow_dispatch` and automates the `brew bump-formula-pr` flow:

1. It checks out this tap and sets up the official Homebrew environment.
2. It syncs `Formula/<name>.rb` into the runner's `hebertcisco/homebrew-tap`
   location and installs/tests the tap formula via `brew`.
3. It runs `brew audit --new --strict` and `brew bump-formula-pr --strict` to
   open a pull request in `Homebrew/homebrew-core`.

Trigger it from the Actions tab with:

- `formula`: file name without extension (e.g. `oscleaner`).
- `url`, `sha256`, and optional `tag`/`revision`: values to hand to
  `brew bump-formula-pr`.
- Optional `version` override and a commit `message` suffix (such as
  `(new formula)`).

The workflow requires a Personal Access Token stored as the
`HOMEBREW_GITHUB_API_TOKEN` secret because pushing to `homebrew-core` forks
needs more scope than the default `GITHUB_TOKEN`, and the token also grants the
runner read access to this private tap when `brew update` fetches it. See the
Formula Cookbook for details about what each argument should contain.

## Code of Conduct

All contributors must follow the [Homebrew Code of Conduct](https://github.com/Homebrew/.github/blob/HEAD/CODE_OF_CONDUCT.md#code-of-conduct).
