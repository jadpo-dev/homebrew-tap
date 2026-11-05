class Jadpo < Formula
  desc "The jadpo command"
  homepage "https://github.com/jadpo-dev/jadpo"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jadpo-dev/jadpo/releases/download/v0.3.0/jadpo-cli-aarch64-apple-darwin.tar.gz"
      sha256 "18aaaf003b056dbf4e24fb4469879fdca49bf0f626f0deda6aa9c2d7a6fcb94e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jadpo-dev/jadpo/releases/download/v0.3.0/jadpo-cli-x86_64-apple-darwin.tar.gz"
      sha256 "4e61bdf9621a5b8cf85771354e0fa71c9f1412a76d7a30253dd3bffa1530c474"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/jadpo-dev/jadpo/releases/download/v0.3.0/jadpo-cli-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "35b0c1b88d9893fde48456da8db7b4b4ed9bc511fb1099a71a8943eb23abca02"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jadpo-dev/jadpo/releases/download/v0.3.0/jadpo-cli-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f16df55b61ab199982f5b71930365a40353389a7db81b8e45906a8acb3f31a1b"
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
