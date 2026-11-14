# Rendered by .github/workflows/release.yml (0.91.0 -> tag, checksums from the
# release's checksums.txt) and pushed to the lichdotdev/homebrew-tap repository as
# Casks/lich.rb — edit this template, never the tap copy.
#
# A cask, not a formula: only a cask installs an .app into /Applications, which
# is what puts lich in Launchpad, in Spotlight and behind its own icon. The
# binary stanza keeps `lich` on PATH, so the one install still serves both.
cask "lich" do
  arch arm: "arm64", intel: "amd64"

  version "0.91.0"
  sha256 arm: "d87649816d31b71982f089bdaeb5f5eaf9cc77aa5c57241c01d48700d3cca067", intel: "c88e4c2417a43cee2bf4b3f6bd998ce1727ddbcd37f9fc0a338d652c0501b5c2"

  url "https://github.com/lichdotdev/lich/releases/download/v#{version}/lich-v#{version}-darwin-#{arch}.zip"
  name "lich"
  desc "Run coding agents side by side, each on its own branch"
  homepage "https://github.com/lichdotdev/lich"

  depends_on macos: ">= :ventura"

  app "Lich.app"
  binary "#{appdir}/Lich.app/Contents/MacOS/lich"

  # lich is ad-hoc signed and never notarized, so Gatekeeper refuses a
  # quarantined copy outright. The archive is pinned by the checksums above and
  # comes from the project's own release — that is the trust this trades on.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Lich.app"]
  end

  zap trash: [
    "~/Library/Application Support/lich",
  ]
end
