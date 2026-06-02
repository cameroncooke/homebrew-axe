class Axe < Formula
  desc "CLI tool for interacting with iOS Simulators via accessibility and HID APIs"
  homepage "https://github.com/cameroncooke/AXe"
  license "MIT"
  version "1.7.1"
  depends_on macos: :sonoma

  url "https://github.com/cameroncooke/AXe/releases/download/v1.7.1/AXe-macOS-homebrew-v1.7.1.tar.gz"
  sha256 "067e9be0a628f151477e5b5f60e6ed92796b22238fddd3b1636d953a20d910fe"

  def install
    libexec.install "axe", "Frameworks", "AXe_AXe.bundle"
    bin.write_exec_script libexec/"axe"
  end

  def post_install
    Dir.glob("#{libexec}/Frameworks/*.framework").each do |framework|
      system "codesign", "--force", "--sign", "-", "--timestamp=none", framework
    end

    system "codesign", "--force", "--sign", "-", "--timestamp=none", libexec/"axe"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/axe --version")
  end
end
