# Formula/axe.rb
class Axe < Formula
  desc "CLI application for macOS to interact with iOS Simulators and Devices via IDB"
  homepage "https://github.com/cameroncooke/AXe"

  version "1.1.0"
  url "https://github.com/cameroncooke/AXe/releases/download/v1.1.0/AXe-macOS-v1.1.0.tar.gz"
  sha256 "790e9baaa59efd725b7a9691dbe24139f3cb779da8c6375d03b33b092ed9ddf5"

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
