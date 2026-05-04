class Pling < Formula
  desc "Connect this machine to your Pling app"
  homepage "https://plingpush.com"
  version "0.15.2"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/Jeramo/pling-agent/releases/download/v#{version}/pling-darwin-arm64"
      sha256 "0a5094d568541a3cb0b794d513b72c652ee2cfa971b4e61cc67edb5222a96407"
    end
    on_intel do
      url "https://github.com/Jeramo/pling-agent/releases/download/v#{version}/pling-darwin-amd64"
      sha256 "87af03012ee35176457303ce787d1ead5ee88d4bd10cd14fbb60b2d213edd4e0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Jeramo/pling-agent/releases/download/v#{version}/pling-linux-arm64"
      sha256 "ea77d344275287c078d1915c0119759bd3112e5f8b7d7c3bda5640f14e96e282"
    end
    on_intel do
      url "https://github.com/Jeramo/pling-agent/releases/download/v#{version}/pling-linux-amd64"
      sha256 "4bfa14a2ac96e70e2a813a1d603bdff9017a42d71d89ac07981931c38142101f"
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
