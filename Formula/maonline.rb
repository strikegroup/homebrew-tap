class Maonline < Formula
  desc "Command-line interface for M&A Online"
  homepage "https://github.com/strikegroup/maonline_cli"
  version "0.0.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/strikegroup/maonline_cli/releases/download/v0.0.0/maonline-v0.0.0-aarch64-apple-darwin.tar.gz"
      sha256 "bdb50a46b8c9a68e614f84edd768a05fc8e9e02a1b401fefb245292c2fa54511"
    end
    if Hardware::CPU.intel?
      url "https://github.com/strikegroup/maonline_cli/releases/download/v0.0.0/maonline-v0.0.0-x86_64-apple-darwin.tar.gz"
      sha256 "42efe6ab8a6050e901eeaccc90bb5921a4a52a279b99636cbce21711ee552ce3"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/strikegroup/maonline_cli/releases/download/v0.0.0/maonline-v0.0.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b67622816e5d4608a51d57ea85ceb5d308ed0582ffc702a8a66136befbf5c71b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/strikegroup/maonline_cli/releases/download/v0.0.0/maonline-v0.0.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7a5d3ba1b80a4f08897c9e5929acdcd0b70d732fb2518ef227a94ece70c913d4"
    end
  end
  license "Apache-2.0"

  def install
    bin.install "maonline"
    pkgshare.install "THIRD_PARTY_LICENSES.html"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/maonline --version")
  end
end
