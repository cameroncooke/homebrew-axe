# Formula/axe.rb
class Axe < Formula
  desc "CLI application for macOS to interact with iOS Simulators and Devices via IDB"
  homepage "https://github.com/cameroncooke/AXe"

  version "1.0.0"
  url "https://github.com/cameroncooke/AXe/releases/download/v1.0.0/AXe-macOS-v1.0.0.tar.gz"
  sha256 "5d32037aaef3bd8c57b454cf43b40b470c209d5dd2a39ab78eeb7b9c438817f9"

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
