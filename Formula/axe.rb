class Axe < Formula
  desc "CLI tool for interacting with iOS Simulators via accessibility and HID APIs"
  homepage "https://github.com/cameroncooke/AXe"
  license "MIT"
  version "1.5.2"
  depends_on macos: :sonoma

  url "https://github.com/cameroncooke/AXe/releases/download/v1.5.2/AXe-macOS-homebrew-v1.5.2.tar.gz"
  sha256 "49644b84de6d0df722005e4150a106f64af80b213121fbe3a00f8686b694f369"

  def install
    libexec.install "axe", "Frameworks", "AXe_AXe.bundle"
    bin.write_exec_script libexec/"axe"
  end

  def post_install
    signed_paths = {}

    Dir.glob("#{libexec}/**/*", File::FNM_DOTMATCH).each do |path|
      next unless File.file?(path)
      next if path.match?(%r{\.framework/[^/]+$}) && File.directory?(File.join(File.dirname(path), "Versions"))

      resolved_path = Pathname.new(path).realpath.to_s
      next if signed_paths[resolved_path]
      next unless quiet_system("file", resolved_path)

      file_output = Utils.safe_popen_read("file", resolved_path)
      next unless file_output.include?("Mach-O")

      system "codesign", "--force", "--sign", "-", "--timestamp=none", resolved_path
      signed_paths[resolved_path] = true
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/axe --version")
  end
end
