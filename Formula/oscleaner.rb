# typed: false
# frozen_string_literal: true

class Oscleaner < Formula
  desc "Cross-platform system cleanup CLI"
  homepage "https://github.com/hebertcisco/oscleaner"
  url "https://github.com/hebertcisco/oscleaner/archive/refs/tags/v1.1.1.tar.gz"
  sha256 "99152dfe90659e4ecda0bee8ab822f5b21401be7eb9a24cad12fe0c8cb1541d6"
  license "MIT"
  head "https://github.com/hebertcisco/oscleaner.git", branch: "main"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "e95600a12f4ec250cb4df9ed6b8ba30b61f4415e97ee9cae853e1a40f7b16f5e"
    sha256 cellar: :any_skip_relocation, sequoia:     "965a2fcc0930def472fbcab2dd4c7f01a7059f0e117f59d65596b26cd05d9ab1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "1596bea007b21b43aac37463d52ab58197cc5e6340e0fb7dfdbf4ed58685011d"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "oscleaner", shell_output("#{bin}/oscleaner --help")
  end
end
