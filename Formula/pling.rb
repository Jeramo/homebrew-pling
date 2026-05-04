class Pling < Formula
  desc "Connect this machine to your Pling app"
  homepage "https://plingpush.com"
  version "0.15.0"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/Jeramo/pling-agent/releases/download/v#{version}/pling-darwin-arm64"
      sha256 "f52b3633f83e25fc31b76c64659c68a410e7166a4dfc2644bc8dd23c9bde7783"
    end
    on_intel do
      url "https://github.com/Jeramo/pling-agent/releases/download/v#{version}/pling-darwin-amd64"
      sha256 "e2c0cd37315f94a2daaded7c88dd9d9ecc4391632cf5419faf23e5614f0d9a12"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Jeramo/pling-agent/releases/download/v#{version}/pling-linux-arm64"
      sha256 "5877b5c4f1f2295bc3347c3ec31fbc6743f526e0b7f9dd00c1891ea1f211013f"
    end
    on_intel do
      url "https://github.com/Jeramo/pling-agent/releases/download/v#{version}/pling-linux-amd64"
      sha256 "b8f8eaf5bc1100bbc69d96c09710cd1fc073b7f46eaca0375b936667ae458cca"
    end
  end

  def install
    binary = Dir["pling-*"].first
    bin.install binary => "pling"
  end

  def caveats
    <<~EOS
      Before starting the service, set your API token:

        pling set-token <YOUR_TOKEN>

      Or, on first run, the daemon will fail until #{etc}/pling/config.toml exists.
      Find your token in the Pling app under Settings → Hosts → Add agent.
    EOS
  end

  service do
    run [opt_bin/"pling", "serve"]
    keep_alive true
    log_path var/"log/pling.log"
    error_log_path var/"log/pling.log"
    environment_variables PATH: std_service_path_env
  end

  test do
    assert_match "pling", shell_output("#{bin}/pling version")
  end
end
