# typed: false
# frozen_string_literal: true

class Oscleaner < Formula
  desc "Cross-platform system cleanup CLI"
  homepage "https://github.com/hebertcisco/oscleaner"
  url "https://github.com/hebertcisco/oscleaner/releases/download/v1.0.0/oscleaner-v1.0.0-source.tar.gz"
  sha256 "cf1b9f208722313d67b24efc81daa45dc0bcd27bc0b39751203668d86f564a91"
  license "MIT"
  head "https://github.com/hebertcisco/oscleaner.git", branch: "main"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "9cda25fb986140471748df24df62ee53f6e10b208c7165e0979cdfa2e4439d47"
    sha256 cellar: :any_skip_relocation, sequoia: "6017c761db8a494b6f6f1271a0acbb7984919ebaf4c728c11a20aed48932fd6a"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "2d3cf2fb011e538d3ad7538be76c4f5c57ed87f1735e34f3858d2f3860942bde"
  end

  on_macos do
    depends_on "rust" => :build
  end

  on_linux do
    url "https://github.com/hebertcisco/oscleaner/releases/download/v1.0.0/oscleaner-v1.0.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "0f305c8c41e00f321815fca5a71b95d2d8b898bf2faa17590c60beb92a4f72c2"
  end

  def install
    if OS.mac?
      system "cargo", "install", *std_cargo_args(path: ".")
    else
      bin.install "oscleaner-v#{version}-x86_64-unknown-linux-gnu" => "oscleaner"
    end
  end

  test do
    output = shell_output("#{bin}/oscleaner --help")
    assert_match "oscleaner", output
  end
end
