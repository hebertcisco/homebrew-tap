# typed: false
# frozen_string_literal: true

class Oscleaner < Formula
  desc "Cross-platform system cleanup CLI"
  homepage "https://github.com/hebertcisco/oscleaner"
  url "https://github.com/hebertcisco/oscleaner/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "53e78e9541dd29e21a7f7e4a211d701840a6cdd685529703d05fbf54c7b0ad35"
  license "MIT"
  head "https://github.com/hebertcisco/oscleaner.git", branch: "main"


  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "oscleaner", shell_output("#{bin}/oscleaner --help")
  end
end
