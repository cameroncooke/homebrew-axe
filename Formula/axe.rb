class Axe < Formula
  desc "CLI tool for interacting with iOS Simulators via accessibility and HID APIs"
  homepage "https://github.com/cameroncooke/AXe"
  license "MIT"
  version "1.5.1"

  url "https://github.com/cameroncooke/AXe/releases/download/v1.5.1/AXe-macOS-homebrew-v1.5.1.tar.gz"
  sha256 "38451072591513a9b0b282e542bb46d39b400c31b24eec5ee815403e4dc9644b"

  def install
    libexec.install "axe", "Frameworks"
    bin.write_exec_script libexec/"axe"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/axe --version")
  end
end
