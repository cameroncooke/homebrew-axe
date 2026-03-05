class Axe < Formula
  desc "CLI tool for interacting with iOS Simulators via accessibility and HID APIs"
  homepage "https://github.com/cameroncooke/AXe"
  license "MIT"
  version "1.5.0"

  url "https://github.com/cameroncooke/AXe/releases/download/v1.5.0/AXe-macOS-homebrew-v1.5.0.tar.gz"
  sha256 "8ebb1672158941ee37fcd1193727b9bc7c3031500771ec0c2cb61f08053086b8"

  def install
    libexec.install "axe", "Frameworks"
    bin.write_exec_script libexec/"axe"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/axe --version")
  end
end
