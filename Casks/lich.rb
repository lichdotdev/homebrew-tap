# Rendered by .github/workflows/release.yml (0.81.0 -> tag, checksums from the
# release's checksums.txt) and pushed to the lichdotdev/homebrew-tap repository as
# Casks/lich.rb — edit this template, never the tap copy.
#
# A cask, not a formula: only a cask installs an .app into /Applications, which
# is what puts lich in Launchpad, in Spotlight and behind its own icon. The
# binary stanza keeps `lich` on PATH, so the one install still serves both.
cask "lich" do
  arch arm: "arm64", intel: "amd64"

  version "0.81.0"
  sha256 arm: "d64b0c708ed0ea6febebc3a4add5d3a6a71184b233212e9932251081b4c13dbb", intel: "2d0e4b75a014404f5b5a65dd9afb68bab3d89a04d0f8edc516fa29d2839a3b7a"

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
