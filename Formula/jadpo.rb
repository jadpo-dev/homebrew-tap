class Jadpo < Formula
  desc "The jadpo command"
  homepage "https://github.com/jadpo-dev/jadpo"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jadpo-dev/jadpo/releases/download/v0.4.0/jadpo-cli-aarch64-apple-darwin.tar.gz"
      sha256 "2944f4b147bc99bb29a93b62274ebf63c7533a4c316e5d3081de5dbfe773adac"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jadpo-dev/jadpo/releases/download/v0.4.0/jadpo-cli-x86_64-apple-darwin.tar.gz"
      sha256 "0f8cfaf9a9b3ab8d84382c8f6f149b7a91f432cab4709e0ff26056938d4cec38"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/jadpo-dev/jadpo/releases/download/v0.4.0/jadpo-cli-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "482844106180a46fca137e10b48b3011b11188c0c517da6993f489b5e7dc5700"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jadpo-dev/jadpo/releases/download/v0.4.0/jadpo-cli-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b810cdd88684750655ae819ac56b2e0891b199ee13dc31c7d597bad79211dfef"
    end
  end
  license "Apache-2.0"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
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
      bin.install "jadpo"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "jadpo"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "jadpo"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "jadpo"
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
