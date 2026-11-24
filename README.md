# Homebrew tap for `ldx`

The Homebrew tap for [ldx](https://github.com/roguexz/dev-rig), the Local
Development Experience CLI (local Kubernetes stacks, TLS, secrets, security
tools).

```bash
brew tap hashicorp/tap   # vault dependency (not in homebrew-core)
brew tap roguexz/ldx
brew install roguexz/ldx/ldx
```

Homebrew does not tap third-party taps automatically, so
`hashicorp/tap` (for `vault`) must be tapped explicitly before installing.
`bash`, `grype`, `helm`, `jq`, `mkcert` and `terminal-notifier` come from
homebrew-core. `bash` is a hard dependency: the ldx scripts require bash 4+
(macOS ships bash 3.2, frozen by Apple) and refuse to run on older shells.

Upgrades: `brew upgrade roguexz/ldx/ldx`.

`Formula/ldx.rb` is maintained by the dev-rig release workflow: pushing a
version tag to roguexz/dev-rig updates this repository with that release's
archive URL and sha256. The source of truth for the formula's behavior is
`roguexz/dev-rig`.
