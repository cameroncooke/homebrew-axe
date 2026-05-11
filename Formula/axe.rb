class Axe < Formula
  desc "CLI tool for interacting with iOS Simulators via accessibility and HID APIs"
  homepage "https://github.com/cameroncooke/AXe"
  license "MIT"
  version "1.7.0"
  depends_on macos: :sonoma

  url "https://github.com/cameroncooke/AXe/releases/download/v1.7.0/AXe-macOS-homebrew-v1.7.0.tar.gz"
  sha256 "030c3f6a27aeb8881d12997f4a8b0d3b5ce1e6055205a448c1ae00e78a219286"

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
