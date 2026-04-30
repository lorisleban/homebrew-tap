class AniCli < Formula
  desc "Rust TUI anime client"
  homepage "https://github.com/lorisleban/ani-cli"
  url "https://github.com/lorisleban/ani-cli/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "8698a089fdd29660d2a0ddc5986b7d02b0b087b5decf9d3979654c2950bb465c"
  license "GPL-3.0-only"

  depends_on "rust" => :build
  depends_on "openssl@3"
  uses_from_macos "curl"

  def install
    ENV["OPENSSL_DIR"] = Formula["openssl@3"].opt_prefix
    system "cargo", "install", *std_cargo_args(path: ".")
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

  test do
    assert_path_exists bin/"ani-cli"
    assert_predicate bin/"ani-cli", :executable?
  end
end
