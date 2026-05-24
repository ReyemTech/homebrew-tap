cask "stint-beta" do
  version "0.0.0-beta.0"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"

  url "https://github.com/reyemtech/stint/releases/download/v#{version}/Stint-#{version}.dmg"
  name "Stint"
  desc "Pre-release builds of Stint"
  homepage "https://github.com/reyemtech/stint"

  # livecheck scrapes the moving beta-latest Release's asset list (it always
  # mirrors the newest beta's versioned DMG) to detect the latest prerelease.
  livecheck do
    url "https://github.com/reyemtech/stint/releases/expanded_assets/beta-latest"
    regex(/Stint-(\d+(?:\.\d+)*(?:-beta\.\d+)?)\.dmg/i)
  end

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Stint.app"
  binary "#{appdir}/Stint.app/Contents/MacOS/stint"

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
