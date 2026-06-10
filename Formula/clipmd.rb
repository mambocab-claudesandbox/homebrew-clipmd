class Clipmd < Formula
  desc "Transform clipboard URLs into Markdown links and rich-text hyperlinks"
  homepage "https://github.com/mambocab-claudesandbox/clipmd"
  url "https://github.com/mambocab-claudesandbox/clipmd/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "aecbc8596efaecdf82c142c8e5116c9e8b7207304b8476e5854227deafd984f4"
  license "MIT"
  head "https://github.com/mambocab-claudesandbox/clipmd.git", branch: "main"

  # clipmd uses Zig 0.16 (std.zon, std.Io). `zig@0.16` is currently a
  # homebrew-core alias for `zig`; when `zig` advances to 0.17 a real
  # versioned formula will appear and we'll still pull in 0.16.
  depends_on "zig@0.16" => :build

  def install
    system "zig", "build", "-Doptimize=ReleaseFast", "--prefix", prefix
  end

  # `brew services start clipmd` installs this as a per-user LaunchAgent so
  # the menu bar item + global hotkey come back automatically at login. It
  # has to be a user-level agent (not a system daemon) because clipmd talks
  # to AppKit/WindowServer.
  service do
    run [opt_bin/"clipmd", "daemon"]
    run_type :immediate
    keep_alive true
    log_path var/"log/clipmd.log"
    error_log_path var/"log/clipmd.log"
  end

  test do
    assert_match "clipmd", shell_output("#{bin}/clipmd version")
  end
end
