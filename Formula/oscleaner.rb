# typed: false
# frozen_string_literal: true

class Oscleaner < Formula
  desc "Cross-platform system cleanup CLI"
  homepage "https://github.com/hebertcisco/oscleaner"
  url "https://github.com/hebertcisco/oscleaner/releases/download/v1.0.0/oscleaner-v1.0.0-source.tar.gz"
  sha256 "c609820994a2dee7a3df7802f650969a35630038f6bcfb88632c92cf5dcddc10"
  license "MIT"
  head "https://github.com/hebertcisco/oscleaner.git", branch: "main"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "e43a49614f4e9a9c14c2c08f2a4e1ffacf000c1a6fbb6a1e27393a4675dcf888"
    sha256 cellar: :any_skip_relocation, sequoia: "5e56397217a5dc57f2f4c89516e05fe39ae3115255d4167e9a4d1b0808949f66"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "b5741dedcfcb63cda2ce8d70272c41a06e2aaac06414b94dd4a4dd278a61a72c"
  end

  on_macos do
    depends_on "rust" => :build
  end

  on_linux do
    url "https://github.com/hebertcisco/oscleaner/releases/download/v1.0.0/oscleaner-v1.0.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "6e6b927789d8364f6afab605ca0291c431925db34c359abeaccd2445a7d0bcc2"
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
