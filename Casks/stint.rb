cask "stint" do
  version "0.1.2"
  sha256 "88194f3a480386584f2438096e33b0dfd0d08f8566ab84e15f28a4ad6f75097e"

  url "https://github.com/reyemtech/stint/releases/download/v#{version}/Stint-#{version}.dmg"
  name "Stint"
  desc "Time tracker that syncs with Solidtime (CLI + menu bar app)"
  homepage "https://github.com/reyemtech/stint"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Stint.app"
  binary "#{appdir}/Stint.app/Contents/MacOS/stint"

  uninstall quit:      "tech.reyem.stint",
            launchctl: "tech.reyem.stint",
            delete:    "/Applications/Stint.app"

  zap trash: [
    "~/Library/Application Support/stint",
    "~/Library/Preferences/tech.reyem.stint.plist",
    "~/Library/Caches/tech.reyem.stint",
    "~/Library/Logs/stint",
    "~/Library/WebKit/tech.reyem.stint",
  ]
end
