class Edinet < Formula
  desc "A command-line interface for EDINET."
  homepage "https://github.com/strikegroup/edinet_cli"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/strikegroup/edinet_cli/releases/download/v0.1.0/edinet_cli-aarch64-apple-darwin.tar.xz"
      sha256 "68226e22f2ee6abb95cb443803da174f785810797465eb3525fa6a778a905694"
    end
    if Hardware::CPU.intel?
      url "https://github.com/strikegroup/edinet_cli/releases/download/v0.1.0/edinet_cli-x86_64-apple-darwin.tar.xz"
      sha256 "42d5e9a742943db510d7eed1b6133a58ac1b17719fdbd43873b3b14a5bf9978a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/strikegroup/edinet_cli/releases/download/v0.1.0/edinet_cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ea4c5a29f36a44f6808ca88cc3a22ac787199edb2104eeee2e564dbc32573033"
    end
    if Hardware::CPU.intel?
      url "https://github.com/strikegroup/edinet_cli/releases/download/v0.1.0/edinet_cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0d2b2c88b129292e1e1fa19c12afe7d8799d056db1e46dcbf1da62632f036090"
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
