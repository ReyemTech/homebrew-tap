cask "stint" do
  version "0.1.1"
  sha256 "dacf673038879f77b3f98752a41c5c46a2dd83a5cdea56778d686cc5512de07b"

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
