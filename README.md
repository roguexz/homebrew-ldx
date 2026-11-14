# Homebrew tap for `ldx`

The Homebrew tap for [ldx](https://github.com/roguexz/dev-rig), the Local
Development Experience CLI (local Kubernetes stacks, TLS, secrets, security
tools).

```bash
brew tap roguexz/ldx
brew install roguexz/ldx/ldx
```

Upgrades: `brew upgrade roguexz/ldx/ldx`.

`Formula/ldx.rb` is maintained by the dev-rig release workflow: pushing a
version tag to roguexz/dev-rig updates this repository with that release's
archive URL and sha256. The source of truth for the formula's behavior is
`roguexz/dev-rig`.
