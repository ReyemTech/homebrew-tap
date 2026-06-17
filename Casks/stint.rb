cask "stint" do
  version "0.5.1"
  sha256 "936313779a6ca6611a1ff8cec75fdce19a278e7d7dbc68550454ae59fd88417b"

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
  depends_on macos: :ventura

  app "Stint.app"
  binary "#{appdir}/Stint.app/Contents/MacOS/stint"
  manpage "#{appdir}/Stint.app/Contents/Resources/man/man1/stint.1"

  uninstall launchctl: "tech.reyem.stint",
            quit:      "tech.reyem.stint"

  zap trash: [
    "~/Library/Application Support/stint",
    "~/Library/Caches/tech.reyem.stint",
    "~/Library/Logs/stint",
    "~/Library/Preferences/tech.reyem.stint.plist",
    "~/Library/WebKit/tech.reyem.stint",
  ]
end
