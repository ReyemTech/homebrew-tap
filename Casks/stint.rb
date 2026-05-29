cask "stint" do
  version "0.4.0"
  sha256 "10734148cce04f8aae9c7cc1598e92660681dd4b2b074c77ff72424813ac9243"

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
