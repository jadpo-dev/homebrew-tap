class Jadpo < Formula
  desc "The jadpo command"
  homepage "https://github.com/jadpo-dev/jadpo"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jadpo-dev/jadpo/releases/download/v0.1.0/jadpo-cli-aarch64-apple-darwin.tar.gz"
      sha256 "d561125ed80d350f14fb123a03f9913e74df4c80bf72bd136399bbd08ab7a867"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jadpo-dev/jadpo/releases/download/v0.1.0/jadpo-cli-x86_64-apple-darwin.tar.gz"
      sha256 "e90a6058e9c60de6e7747c5b6898005f8ef9ae5f98605fa410f83befa5954fa5"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/jadpo-dev/jadpo/releases/download/v0.1.0/jadpo-cli-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e0f03459aa88d329d50bf63dc9da2c2b9c7584c153dff4f8db89e10249704d40"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jadpo-dev/jadpo/releases/download/v0.1.0/jadpo-cli-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2f404815990f0271cc11f128cc9d5b8e52971389368d5d4f13e2b52181191084"
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
