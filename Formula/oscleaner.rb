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
      sha256 "ecf55e66471e28e7053a6775298489078dfd5723287dee1db9c38b18707e333b"
    else
      url "https://github.com/hebertcisco/oscleaner/releases/download/v1.0.0/oscleaner-x86_64-apple-darwin.tar.gz"
      sha256 "7a6d0c2e6f083213967fb769a3f8096bf876218b7f27cb052a8afafea2756975"
    end
  end

  on_linux do
    url "https://github.com/hebertcisco/oscleaner/releases/download/v1.0.0/oscleaner-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "68b5b4ec5ed22e30dcf6298009d48c1141ce1f0d355b6aed53ee456ee54dce3d"
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
