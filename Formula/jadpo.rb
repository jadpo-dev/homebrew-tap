class Jadpo < Formula
  desc "The jadpo command"
  homepage "https://github.com/jadpo-dev/jadpo"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jadpo-dev/jadpo/releases/download/v0.2.0/jadpo-cli-aarch64-apple-darwin.tar.gz"
      sha256 "c1366494d4519c651e1267464b5014d3072d8efd132e92561fcafae9f66d152d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jadpo-dev/jadpo/releases/download/v0.2.0/jadpo-cli-x86_64-apple-darwin.tar.gz"
      sha256 "379b5435dfdd6f3111095680d1f662a8eb1107fc52988057e6b39766acc93255"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/jadpo-dev/jadpo/releases/download/v0.2.0/jadpo-cli-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c42a0dd0e4b14df5b95e14ad6295cbb1caf5698aef5c52996c361a886622dc19"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jadpo-dev/jadpo/releases/download/v0.2.0/jadpo-cli-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "43930a10d64d4a5d79c806badb95d43467a0a24ef9174a2d003d259bbfa4d506"
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
