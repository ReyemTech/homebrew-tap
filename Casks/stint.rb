cask "stint" do
  version "0.5.0"
  sha256 "401944e04cf4d2c88da3ee98508765859ee0c251766a4f33ccedd2cc9050bcd0"

  url "https://github.com/reyemtech/stint/releases/download/v#{version}/Stint-#{version}.dmg"
  name "Stint"
  desc "Time tracker that syncs with Solidtime (CLI + menu bar app)"
  homepage "https://github.com/reyemtech/stint"

  livecheck do
    url :url
    strategy :github_latest
  end

  # `auto_updates true` removed intentionally: brew's upgrade code path with
  # auto_updates set uninstalls /Applications/Stint.app but then skips the
  # install/copy step, leaving the user with no app. Tauri's in-app updater
  # still works independently — auto_updates is purely a brew-side hint and
  # doesn't affect runtime self-update behavior.
  depends_on macos: ">= :ventura"

  app "Stint.app"
  binary "#{appdir}/Stint.app/Contents/MacOS/stint"
  manpage "#{appdir}/Stint.app/Contents/Resources/man/man1/stint.1"

  uninstall quit:      "tech.reyem.stint",
            launchctl: "tech.reyem.stint"

  zap trash: [
    "~/Library/Application Support/stint",
    "~/Library/Preferences/tech.reyem.stint.plist",
    "~/Library/Caches/tech.reyem.stint",
    "~/Library/Logs/stint",
    "~/Library/WebKit/tech.reyem.stint",
  ]
end
