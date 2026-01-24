# typed: false
# frozen_string_literal: true

class Oscleaner < Formula
  desc "Cross-platform system cleanup CLI"
  homepage "https://github.com/hebertcisco/oscleaner"
  version "1.0.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/hebertcisco/oscleaner/releases/download/v1.0.0/oscleaner-aarch64-apple-darwin.tar.gz"
      sha256 "16d19502cca68b3715ace249b8fe90d7c47a6f6b96a4d1e7baec4d7bb3624b5a"
    else
      url "https://github.com/hebertcisco/oscleaner/releases/download/v1.0.0/oscleaner-x86_64-apple-darwin.tar.gz"
      sha256 "ae3fcb97914f109fb2d276fb279128aff36ac7858ad5b1f71a77c658d2e64ce0"
    end
  end

  on_linux do
    url "https://github.com/hebertcisco/oscleaner/releases/download/v1.0.0/oscleaner-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "efe8fcb028bed054e3cdaa23e155355cf7ceff724c4221c4d98c6eebad47112d"
  end

  def install
    bin_name = if OS.mac?
      Hardware::CPU.arm? ? "oscleaner-aarch64-apple-darwin" : "oscleaner-x86_64-apple-darwin"
    else
      "oscleaner-x86_64-unknown-linux-gnu"
    end

    bin.install bin_name => "oscleaner"
  end

  test do
    output = shell_output("#{bin}/oscleaner --help")
    assert_match "oscleaner", output
  end
end
