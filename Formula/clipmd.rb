class Clipmd < Formula
  desc "Transform clipboard URLs into Markdown links and rich-text hyperlinks"
  homepage "https://github.com/mambocab-claudesandbox/clipmd"
  url "https://github.com/mambocab-claudesandbox/clipmd/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "f41ebeb421cf204bd79a27560c4d4c841b033963f0a22a80c7aaa6aff813335f"
  license "MIT"
  head "https://github.com/mambocab-claudesandbox/clipmd.git", branch: "main"

  # clipmd uses Zig 0.16 (std.zon, std.Io). Older Zigs won't even parse the
  # sources; this check fails fast with a clear message before `zig build`
  # produces a noisier compiler error.
  MIN_ZIG = "0.16.0".freeze

  depends_on "zig" => :build

  def install
    zig_version = Utils.safe_popen_read("zig", "version").strip
    if Gem::Version.new(zig_version) < Gem::Version.new(MIN_ZIG)
      odie "clipmd requires Zig #{MIN_ZIG} or newer (found #{zig_version})"
    end
    system "zig", "build", "-Doptimize=ReleaseFast", "--prefix", prefix
  end

  test do
    assert_match "clipmd", shell_output("#{bin}/clipmd version")
  end
end
