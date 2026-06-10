class ClipmdAT010 < Formula
  desc "Transform clipboard URLs into Markdown links and rich-text hyperlinks"
  homepage "https://github.com/mambocab-claudesandbox/clipmd"
  url "https://github.com/mambocab-claudesandbox/clipmd/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "f41ebeb421cf204bd79a27560c4d4c841b033963f0a22a80c7aaa6aff813335f"
  license "MIT"

  depends_on "zig@0.16" => :build

  def install
    system "zig", "build", "-Doptimize=ReleaseFast", "--prefix", prefix
  end

  test do
    assert_match "clipmd", shell_output("#{bin}/clipmd version")
  end
end
