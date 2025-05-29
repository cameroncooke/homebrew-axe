# Formula/axe.rb
class Axe < Formula
  desc "CLI application for macOS to interact with iOS Simulators and Devices via IDB"
  homepage "https://github.com/cameroncooke/AXe"

  version "0.1.1"
  url "https://github.com/cameroncooke/AXe/releases/download/v0.1.1/AXe-macOS-v0.1.1.tar.gz"
  sha256 "b6aaed9f4025b22bbbff771a87469cc78adf263b81084e9037bcf052b4da8938"

  depends_on macos: :sonoma 

  def install
    # The tarball contains 'axe' and a 'Frameworks' directory at its root.
    # libexec.install Dir["*"] would copy 'Frameworks' folder into libexec.
    # 'axe' executable would be at libexec/axe
    # Frameworks would be at libexec/Frameworks/*
    # With rpath @executable_path/Frameworks, this setup is correct.
    libexec.install Dir["*"] 
    bin.install_symlink libexec/"axe"
  end

  test do
    assert_match "USAGE: axe", shell_output("#{bin}/axe --help", 2)
  end
end
