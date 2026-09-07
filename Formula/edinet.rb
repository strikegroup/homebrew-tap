class Edinet < Formula
  desc "A command-line interface for EDINET."
  homepage "https://github.com/strikegroup/edinet_cli"
  version "0.0.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/strikegroup/edinet_cli/releases/download/v0.0.2/edinet_cli-aarch64-apple-darwin.tar.xz"
      sha256 "f02f321facc53b66206587b30ad3278292330e7d08c5d05715822f203a015ffa"
    end
    if Hardware::CPU.intel?
      url "https://github.com/strikegroup/edinet_cli/releases/download/v0.0.2/edinet_cli-x86_64-apple-darwin.tar.xz"
      sha256 "3d41c6804b30186183b6fd5d5e3294e29878116b0a87e135571b892aae1dd41c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/strikegroup/edinet_cli/releases/download/v0.0.2/edinet_cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a6804d66c89a0f7913f07a916c295a86e836eaff58f7df52c70ebd8fb447c846"
    end
    if Hardware::CPU.intel?
      url "https://github.com/strikegroup/edinet_cli/releases/download/v0.0.2/edinet_cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "11a97375fe8d0fb97f3ea1558bdbf22207dad23ea432aa1c23b16b9e64ff6542"
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
