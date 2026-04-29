class AniCli < Formula
  desc "Rust TUI anime client"
  homepage "https://github.com/lorisleban/ani-cli"
  url "https://github.com/lorisleban/ani-cli/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "f5345e9e3b782dad882382f5281c0dccf433e9e315781ac16e956ab4b8e8e0cd"
  license "GPL-3.0-only"

  depends_on "rust" => :build
  depends_on "openssl@3"
  uses_from_macos "curl"

  def install
    ENV["OPENSSL_DIR"] = Formula["openssl@3"].opt_prefix
    system "cargo", "install", *std_cargo_args(path: ".")
  end

  test do
    output = shell_output("#{bin}/ani-cli 2>&1", 1)
    assert_match "error:", output
  end

  def caveats
    <<~EOS
      ani-cli launches an external media player at runtime.

      Install one of:
        brew install mpv
        brew install vlc

      On macOS, IINA can also be used if installed separately.
    EOS
  end
end
