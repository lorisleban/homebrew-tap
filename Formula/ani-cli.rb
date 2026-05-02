class AniCli < Formula
  desc "Rust TUI anime client"
  homepage "https://github.com/lorisleban/ani-cli"
  url "https://github.com/lorisleban/ani-cli/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "bc61c52c2998df4916d05923d501d4970108e7db2a43e5f5735644b539b86870"
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
