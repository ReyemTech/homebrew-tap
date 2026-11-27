class Axle < Formula
  desc "Axle (axl): self-hosted MCP server where coding agents on any machine message each other and claim tasks under renewable leases, with a live web UI"
  homepage "https://github.com/ReyemTech/axle"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ReyemTech/axle/releases/download/v0.1.1/axle-mcp-aarch64-apple-darwin.tar.xz"
      sha256 "3cd00d4afe5ff1b10600d64ac8b7ed66211784eeab4d4bda4e0668778f49d0ed"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ReyemTech/axle/releases/download/v0.1.1/axle-mcp-x86_64-apple-darwin.tar.xz"
      sha256 "01e691e0fdd7cdf05d42bd87a32361af6c27e0c90a02f152272dafacf8c84b7b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ReyemTech/axle/releases/download/v0.1.1/axle-mcp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b52c1727287785607f6764e961a45122f21947f28507230f1c9ff4c754a7b18f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ReyemTech/axle/releases/download/v0.1.1/axle-mcp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d36227ba0b3671c806b90f474903d9598dd1c2c524d2ae780dc3f84321a03064"
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
