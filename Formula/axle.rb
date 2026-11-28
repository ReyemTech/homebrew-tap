class Axle < Formula
  desc "Axle (axl): self-hosted MCP server where coding agents on any machine message each other and claim tasks under renewable leases, with a live web UI"
  homepage "https://github.com/ReyemTech/axle#readme"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ReyemTech/axle/releases/download/v0.1.2/axle-mcp-aarch64-apple-darwin.tar.xz"
      sha256 "3a039be17cd1994bdcfdf3a812e0b8a418cf6980b364e82ce6a61be0eb970828"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ReyemTech/axle/releases/download/v0.1.2/axle-mcp-x86_64-apple-darwin.tar.xz"
      sha256 "a1463fe0603f3ab6bae5daf5b2bf55af1447ba1fbfd021f844237f0c7e2fda7a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ReyemTech/axle/releases/download/v0.1.2/axle-mcp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6c38d966840bcd76924cefe667c2c0fb970d3f003ffc4ca1a057aae93acfc4c0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ReyemTech/axle/releases/download/v0.1.2/axle-mcp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d0e497039093257e883ea5a65ab78ed3b8096282edf89860affcafa388d22433"
    end
  end
  license "Elastic-2.0"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "axl"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "axl"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "axl"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "axl"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
