# Homebrew Tap

This repository hosts Hebert Cisco's custom Homebrew tap and the automation
that keeps the maintained formulae in sync with `Homebrew/homebrew-core`.

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

Homebrew still requires contributors to follow the
[homebrew-core contributing guide](https://github.com/Homebrew/homebrew-core/blob/main/CONTRIBUTING.md)
and the [Formula Cookbook](https://docs.brew.sh/Formula-Cookbook#commit), but
this tap now automates most of the manual work:

1. **Update the formula** in `Formula/` (URL, version, SHA256, test block, etc.)
   and push to `main`. Any push that touches `Formula/*.rb` files automatically
   kicks off `.github/workflows/publish-core.yml`.
2. **Automation runs per formula**. The workflow determines which formulae
   changed, parses version/URL/SHA data directly from the Ruby files, and then:
   - Installs/tests/audits the tap formula (`brew install --build-from-source`,
     `brew test`, `brew audit --new --strict`).
   - Calls `brew bump-formula-pr --strict --version=<detected> <formula>` to
     open a PR against `Homebrew/homebrew-core`.
3. **Review and merge**. BrewTestBot merges automatically once the PR passes in
   `homebrew-core`; no extra pushes are needed from this tap.

Manual dispatch is still available in the Actions tab when you need to re-run
the workflow outside of `main` pushes; supply a `formula` name to override the
auto-detected set.

The workflow requires a Personal Access Token stored as
`HOMEBREW_GITHUB_API_TOKEN`. This token must have `repo` scope so the runner can
push branches to your `homebrew-core` fork and also read this tap when running
`brew update`. The default `GITHUB_TOKEN` is not sufficient.

## Code of Conduct

All contributors must follow the [Homebrew Code of Conduct](https://github.com/Homebrew/.github/blob/HEAD/CODE_OF_CONDUCT.md#code-of-conduct).
