# Formula/axe.rb
class Axe < Formula
  desc "CLI application for macOS to interact with iOS Simulators and Devices via IDB"
  homepage "https://github.com/cameroncooke/AXe"

  version "1.2.0"
  url "https://github.com/cameroncooke/AXe/releases/download/v1.2.0/AXe-macOS-v1.2.0.tar.gz"
  sha256 "9a0307ecbfbc39593d8cb9e4710291874a6900ab89da28283b28b888b3caa9f1"

  depends_on macos: :sonoma 

  def install
    libexec.install Dir["*"] 
    bin.install_symlink libexec/"axe"
  end

  def post_install
    # Ad-hoc sign the installed binary and framework binaries to ensure executability after Homebrew relocation.
    system("codesign", "--force", "--sign", "-", "--timestamp=none", "#{libexec}/axe")

    Dir.glob("#{libexec}/Frameworks/*.framework").each do |framework|
      name = File.basename(framework, ".framework")
      binary = Dir["#{framework}/Versions/*/#{name}"].first
      next unless binary
      system("codesign", "--force", "--sign", "-", "--timestamp=none", binary)
    end
  end

  test do
    assert_match "USAGE: axe", shell_output("#{bin}/axe --help", 2)
  end
end
