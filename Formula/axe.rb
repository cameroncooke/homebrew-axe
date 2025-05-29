# Formula/axe.rb
class Axe < Formula
  desc "CLI application for macOS to interact with iOS Simulators and Devices via IDB"
  homepage "https://github.com/cameroncooke/AXe"

  # This version will be updated by CI
  version "1.0.43" # Placeholder, CI will replace this

  on_macos do
    if Hardware::CPU.arm?
      # ARM64_URL_PLACEHOLDER
      url "https://github.com/cameroncooke/AXe/releases/download/v1.0.43/AXe-macOS-v1.0.43.tar.gz" # Placeholder, CI will replace this
      # ARM64_SHA256_PLACEHOLDER
      sha256 "f9d6febbc4b7a4f8caa3fecbd963199bf00b0453f434a827eb3d10efa50ffd2f" # SHA256 of empty file
    else
      # X86_64_URL_PLACEHOLDER
      url "https://github.com/cameroncooke/AXe/releases/download/v1.0.43/AXe-macOS-v1.0.43.tar.gz" # Placeholder, CI will replace this
      # X86_64_SHA256_PLACEHOLDER
      sha256 "f9d6febbc4b7a4f8caa3fecbd963199bf00b0453f434a827eb3d10efa50ffd2f" # SHA256 of empty file
    end
  end

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
