class Ldx < Formula
  desc "Local Development Experience CLI: local k8s, TLS, secrets, security"
  homepage "https://github.com/roguexz/dev-rig"
  # This file is maintained by the dev-rig release workflow: every version
  # tag pushed to roguexz/dev-rig updates url/sha256/version below with the
  # hash of that tag's GitHub-built archive. The all-zeros sha256 below is a
  # placeholder: an unbumped formula fails the checksum check on install,
  # so a release can never half-install.
  url "https://github.com/roguexz/dev-rig/archive/refs/tags/0.10.0.tar.gz"
  version "0.10.0"
  sha256 "bd12996d4bacec34e5f1a172d7a957fd1a2d3d0996e4c04914beaf26ef62a08f"
  head "https://github.com/roguexz/dev-rig.git", branch: "main"

  depends_on "grype"
  depends_on "hashicorp/tap/vault"
  depends_on "helm"
  depends_on "jq"
  depends_on "mkcert"
  depends_on "terminal-notifier"

  def install
    # Homebrew strips the archive's top-level directory (dev-rig-<version>/)
    # before running this, so the tree is already at the staging root.
    # Install the whole tree (bin/, bin/lib/, config/, charts/, cvescan/,
    # lib/, skills/, VERSION) under the prefix. bin/ldx resolves LDX_HOME
    # from its realpath, so commands and assets are found under the prefix
    # at runtime. Everything in prefix/bin is linked into Homebrew's bin
    # directory automatically by `brew link`, which is all the PATH wiring a
    # user needs. Do NOT add bin.install_symlink here: the tree is already in
    # prefix/bin, and a self-referential symlink replaces bin/ldx.
    prefix.install Dir["*"]

    # Stamp the package version so `ldx --version` reports it without a git
    # checkout: the dispatcher falls back to LDX_HOME/VERSION. The source of
    # truth for brew installs is this formula's version, set by the release
    # workflow from the git tag.
    (prefix/"VERSION").write("#{version}\n")
  end

  def caveats
    <<~EOS
      Not installed by Homebrew (install manually):
        * Rancher Desktop (https://rancherdesktop.io, no Homebrew cask exists) - the
          local k8s context used by ldx infra commands; it also provides kubectl
        * Xcode Command Line Tools (xcode-select --install) - needed by
          `ldx touchid` to compile the Touch ID helper
        * A JDK - needed by `ldx tls keystore`
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ldx --version")
  end
end
