class Edinet < Formula
  desc "A command-line interface for EDINET."
  homepage "https://github.com/strikegroup/edinet_cli"
  version "0.0.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/strikegroup/edinet_cli/releases/download/v0.0.5/edinet_cli-aarch64-apple-darwin.tar.xz"
      sha256 "d0e8023794e39332b49cb2be7518afa8747db1c592339ceaf272f0c74a678e91"
    end
    if Hardware::CPU.intel?
      url "https://github.com/strikegroup/edinet_cli/releases/download/v0.0.5/edinet_cli-x86_64-apple-darwin.tar.xz"
      sha256 "2eebdf5aa4116f6eafc56c35ed6c022ca6f42ec127c4d7facf94c6d72b4f734e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/strikegroup/edinet_cli/releases/download/v0.0.5/edinet_cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "63ecfc7e792dbfc3c4c5a8980e9405d3446552a00deb5fffbc18778ee376df6f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/strikegroup/edinet_cli/releases/download/v0.0.5/edinet_cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "84f8aa62e4327603e0074bf5ca351db36bd12d81a2be5bdcb1decd165b7a1bb0"
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
      bin.install "edinet"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "edinet"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "edinet"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "edinet"
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
