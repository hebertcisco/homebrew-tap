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
      sha256 "7bc7270dc203296cd2169cbd4a84386ad80a46aef5bce174409e2dfc1a655cbc"
    else
      url "https://github.com/hebertcisco/oscleaner/releases/download/v1.0.0/oscleaner-x86_64-apple-darwin.tar.gz"
      sha256 "de78fb973f9b9ddec8f8305258c3433011a697a2e91dcbb67ebafa8618ee5768"
    end
  end

  on_linux do
    url "https://github.com/hebertcisco/oscleaner/releases/download/v1.0.0/oscleaner-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "b0a356156f5c3962d5bf0f3ebad078d4b772245987ff206e468f8474779e4ae6"
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
