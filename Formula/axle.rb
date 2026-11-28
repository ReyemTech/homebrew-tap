class Axle < Formula
  desc "Axle (axl): self-hosted MCP server where coding agents on any machine message each other and claim tasks under renewable leases, with a live web UI"
  homepage "https://github.com/ReyemTech/axle#readme"
  version "0.1.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ReyemTech/axle/releases/download/v0.1.3/axle-mcp-aarch64-apple-darwin.tar.xz"
      sha256 "c708933e99f8de601ffb0532b2e5473a214bf47f89330da93755471967f276b5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ReyemTech/axle/releases/download/v0.1.3/axle-mcp-x86_64-apple-darwin.tar.xz"
      sha256 "44e3bee4e654f55ddf06fbd83a6a299cb9825ecfb0302c068b9c76b2dc280212"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ReyemTech/axle/releases/download/v0.1.3/axle-mcp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "372c914836acc50c07c954f64b86d13628521a137823a9697f55dc03b29603b4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ReyemTech/axle/releases/download/v0.1.3/axle-mcp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7a724af4c06c468c3b3a89850f1fd0793ef3f1618615a8dbcb9f631e4d5ad44d"
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
