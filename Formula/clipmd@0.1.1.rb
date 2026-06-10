class ClipmdAT011 < Formula
  desc "Transform clipboard URLs into Markdown links and rich-text hyperlinks"
  homepage "https://github.com/mambocab-claudesandbox/clipmd"
  url "https://github.com/mambocab-claudesandbox/clipmd/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "aecbc8596efaecdf82c142c8e5116c9e8b7207304b8476e5854227deafd984f4"
  license "MIT"

  depends_on "zig@0.16" => :build

  def install
    system "zig", "build", "-Doptimize=ReleaseFast", "--prefix", prefix
  end

  test do
    assert_match "clipmd", shell_output("#{bin}/clipmd version")
  end
end
