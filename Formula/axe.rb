# Formula/axe.rb
class Axe < Formula
  desc "CLI application for macOS to interact with iOS Simulators and Devices via IDB"
  homepage "https://github.com/cameroncooke/AXe" # Your main AXe project

  # --- PLACEHOLDERS - These will be updated by your release script ---
  # It's good practice to point to a non-existent file or an empty tarball for the initial state
  # so `brew audit` doesn't complain too much if someone tries to install before a real release.
  # Or, you can comment them out, but Homebrew might then complain the formula is incomplete.
  # Let's use a dummy URL for now.
  url "https://github.com/cameroncooke/AXe/releases/download/v0.0.0/AXe-macOS-Universal-v0.0.0.tar.gz"
  version "0.0.0" # Placeholder version
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855" # SHA256 of an empty file
  # --- END PLACEHOLDERS ---

  # Specify macOS version dependency, matching your Package.swift
  depends_on macos: :sonoma # macOS 14 (Sonoma)

  def install
    # This install block assumes your release archive (e.g., AXe-macOS-Universal-vX.Y.Z.tar.gz)
    # will be created such that its contents (the 'axe' executable and the .framework bundles)
    # are at the root of the extracted archive.
    # This is achieved by using `tar -czvf archive.tar.gz -C Artifacts .` in your release.sh script.

    # Homebrew will extract the archive into a temporary directory, and this 'install' block
    # will be executed with its current directory being that temporary location.

    libexec.install Dir["*"] # Copies 'axe' and all '*.framework' directories into libexec

    # Create a symlink from bin (which is in the user's PATH) to the executable in libexec.
    bin.install_symlink libexec/"axe"
  end

  test do
    # A simple test to ensure the executable runs and produces expected output.
    # Using `shell_output` captures the output.
    # Check for a substring that's definitely in your --help output.
    assert_match "USAGE: axe", shell_output("#{bin}/axe --help", 2) # Expect exit code 2 for --help on ArgumentParser
    # If --help exits with 0, use:
    # assert_match "USAGE: axe", shell_output("#{bin}/axe --help")
  end
end