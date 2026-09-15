class Edinet < Formula
  desc "A command-line interface for EDINET."
  homepage "https://github.com/strikegroup/edinet_cli"
  version "0.0.6"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/strikegroup/edinet_cli/releases/download/v0.0.6/edinet_cli-aarch64-apple-darwin.tar.xz"
      sha256 "dd1364cea2c11f45c305d2d1d96dda767b5c1c941cc911b8f462c0d30a521023"
    end
    if Hardware::CPU.intel?
      url "https://github.com/strikegroup/edinet_cli/releases/download/v0.0.6/edinet_cli-x86_64-apple-darwin.tar.xz"
      sha256 "acbeec9b3f322561f5e04109249aaf951e6567be3cbabc12bfb035f6216bf340"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/strikegroup/edinet_cli/releases/download/v0.0.6/edinet_cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "bb959bc68defdc7427b7c69346f4de9b3a56485633f42ad896942a68eb2a0379"
    end
    if Hardware::CPU.intel?
      url "https://github.com/strikegroup/edinet_cli/releases/download/v0.0.6/edinet_cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b0da3189a8764e8d96c1ad7b76ed5496ec91626bf18077e3e033a92d316c9822"
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
