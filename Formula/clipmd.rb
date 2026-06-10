class Clipmd < Formula
  desc "Transform clipboard URLs into Markdown links and rich-text hyperlinks"
  homepage "https://github.com/mambocab-claudesandbox/clipmd"
  url "https://github.com/mambocab-claudesandbox/clipmd/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "f41ebeb421cf204bd79a27560c4d4c841b033963f0a22a80c7aaa6aff813335f"
  license "MIT"
  head "https://github.com/mambocab-claudesandbox/clipmd.git", branch: "main"

  # clipmd uses Zig 0.16 (std.zon, std.Io). `zig@0.16` is currently a
  # homebrew-core alias for `zig`; when `zig` advances to 0.17 a real
  # versioned formula will appear and we'll still pull in 0.16.
  depends_on "zig@0.16" => :build

  def install
    system "zig", "build", "-Doptimize=ReleaseFast", "--prefix", prefix
  end

  test do
    assert_match "clipmd", shell_output("#{bin}/clipmd version")
  end
end
