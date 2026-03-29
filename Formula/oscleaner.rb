# typed: false
# frozen_string_literal: true

class Oscleaner < Formula
  desc "Cross-platform system cleanup CLI"
  homepage "https://github.com/hebertcisco/oscleaner"
  url "https://github.com/hebertcisco/oscleaner/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "53e78e9541dd29e21a7f7e4a211d701840a6cdd685529703d05fbf54c7b0ad35"
  license "MIT"
  head "https://github.com/hebertcisco/oscleaner.git", branch: "main"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "4958d97c8d6d9d44ca773158d8a361c3cf9570114c589e9530164746dc40ea8a"
    sha256 cellar: :any_skip_relocation, sequoia:     "3b26082381adf31992a4fdf24d0d49d35ac61f63f6f41c23ca2634f0ce44014a"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "f8047ee48d0c851d09ba93352e2ef7403d5892586d56930bbc804d799aa155db"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "oscleaner", shell_output("#{bin}/oscleaner --help")
  end
end
