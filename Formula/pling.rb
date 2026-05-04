class Pling < Formula
  desc "Connect this machine to your Pling app"
  homepage "https://plingpush.com"
  version "0.15.3"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/Jeramo/pling-agent/releases/download/v#{version}/pling-darwin-arm64"
      sha256 "0d8a3ad3d15f5ae8be04cabc7fab431115374b160799b3605f13aaf72a6e5422"
    end
    on_intel do
      url "https://github.com/Jeramo/pling-agent/releases/download/v#{version}/pling-darwin-amd64"
      sha256 "3474ac6afffe27d777170f7ff985d30f4e0be0179f534aa353b7f3ac28deb79c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Jeramo/pling-agent/releases/download/v#{version}/pling-linux-arm64"
      sha256 "46aab97e33fe7d065fae1b3edf219c73489b218dd3d2b6253c7019a98d602bf6"
    end
    on_intel do
      url "https://github.com/Jeramo/pling-agent/releases/download/v#{version}/pling-linux-amd64"
      sha256 "95183053f6d09cd1f4abb5c46f4d1320e7c8d363eca4cad607351f0ebe465b93"
    end
  end

  def install
    binary = Dir["pling-*"].first
    bin.install binary => "pling"
  end

  def caveats
    <<~EOS
      To finish setup:

        pling set-token <YOUR_TOKEN>

      That writes #{etc}/pling/config.toml and starts the service for you.
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
