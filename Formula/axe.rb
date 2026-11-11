class Axe < Formula
  desc "CLI tool for interacting with iOS Simulators via accessibility and HID APIs"
  homepage "https://github.com/cameroncooke/AXe"
  license "MIT"
  version "2.0.0"
  depends_on macos: :sonoma

  url "https://github.com/cameroncooke/AXe/releases/download/v2.0.0/AXe-macOS-homebrew-v2.0.0.tar.gz"
  sha256 "92fb473b29909e08bf0425d498939dd99c1bd55e861f04f72fe059d4ce81fb61"

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
