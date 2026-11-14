class Ldx < Formula
  desc "Local Development Experience CLI: local k8s, TLS, secrets, security"
  homepage "https://github.com/roguexz/dev-rig"
  # This file is maintained by the dev-rig release workflow: every version
  # tag pushed to roguexz/dev-rig updates url/sha256/version below with the
  # hash of that tag's GitHub-built archive. The all-zeros sha256 below is a
  # placeholder: an unbumped formula fails the checksum check on install,
  # so a release can never half-install.
  url "https://github.com/roguexz/dev-rig/archive/refs/tags/0.7.0.tar.gz"
  version "0.7.0"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"
  head "https://github.com/roguexz/dev-rig.git", branch: "main"

  depends_on "anchore/tap/grype"
  depends_on "hashicorp/tap/vault"
  depends_on "helm"
  depends_on "jq"
  depends_on "mkcert"
  depends_on "terminal-notifier"

  def install
    # GitHub archive tarballs unpack under a dev-rig-<version>/ prefix.
    root = Dir["dev-rig-*"].first
    raise "unexpected archive layout" if root.nil?

    # Install the whole tree (bin/, bin/lib/, config/, charts/, cvescan/,
    # lib/, skills/, VERSION) under the prefix. bin/ldx resolves LDX_HOME
    # from its realpath, so commands and assets are found under the prefix
    # at runtime. Homebrew's bin directory is on the PATH, so the bin/ldx
    # link is the only wiring a user needs.
    prefix.install Dir["#{root}/*"]
    bin.install_symlink prefix/"bin/ldx"
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
