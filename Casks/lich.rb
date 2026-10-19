# Rendered by .github/workflows/release.yml (0.72.0 -> tag, checksums from the
# release's checksums.txt) and pushed to the lichdotdev/homebrew-tap repository as
# Casks/lich.rb — edit this template, never the tap copy.
#
# A cask, not a formula: only a cask installs an .app into /Applications, which
# is what puts lich in Launchpad, in Spotlight and behind its own icon. The
# binary stanza keeps `lich` on PATH, so the one install still serves both.
cask "lich" do
  arch arm: "arm64", intel: "amd64"

  version "0.72.0"
  sha256 arm: "cccab7e04b696d5c28859f0a8cb680a084fb7ddfdfdf51b4f07b8cde67c121c7", intel: "1376651ad95c928c181c268a1ef6456fc8f03bf651848bf9e101bc351f295de4"

  url "https://github.com/lichdotdev/lich/releases/download/v#{version}/lich-v#{version}-darwin-#{arch}.zip"
  name "lich"
  desc "Terminal-first ADE for the coding agents you already use"
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

  caveats <<~EOS
    The app brings its own window on Apple Silicon and Intel. Should the
    window fail to open, lich opens as a tab in your default browser instead
    and keeps running after the tab is closed, so stop it from the terminal
    or by signalling the process.
  EOS

  zap trash: [
    "~/Library/Application Support/lich",
  ]
end
