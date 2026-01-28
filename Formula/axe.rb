# Formula/axe.rb
class Axe < Formula
  desc "CLI application for macOS to interact with iOS Simulators and Devices via IDB"
  homepage "https://github.com/cameroncooke/AXe"

  version "1.3.0"
  url "https://github.com/cameroncooke/AXe/releases/download/v1.3.0/AXe-macOS-homebrew-v1.3.0.tar.gz"
  sha256 "64af33f64326df21e24aa58b0b86e1e4c305e5cbad6b65bd32bbffd4176ec952"

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
