class Edinet < Formula
  desc "A command-line interface for EDINET."
  homepage "https://github.com/strikegroup/edinet_cli"
  version "0.0.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/strikegroup/edinet_cli/releases/download/v0.0.1/edinet_cli-aarch64-apple-darwin.tar.xz"
      sha256 "4c1898e3472a5df3d126f6c6dbf7d83b7f6e0d0555e8c0e583a265b5532257cb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/strikegroup/edinet_cli/releases/download/v0.0.1/edinet_cli-x86_64-apple-darwin.tar.xz"
      sha256 "a29ed4107672c3f4825357b0aec16cc25768cf5b76973b6220be7e0454a2f911"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/strikegroup/edinet_cli/releases/download/v0.0.1/edinet_cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c504ba742a59bd9eb4ffa447af61d574485fdfca59c8c262eb61fcbfe6f735ac"
    end
    if Hardware::CPU.intel?
      url "https://github.com/strikegroup/edinet_cli/releases/download/v0.0.1/edinet_cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4198f70e21ff4a724aded07982ba0cbed7df4802af4677867ad6c688abd80b4c"
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
