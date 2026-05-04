class Pling < Formula
  desc "Connect this machine to your Pling app"
  homepage "https://plingpush.com"
  version "0.15.4"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/Jeramo/pling-agent/releases/download/v#{version}/pling-darwin-arm64"
      sha256 "40d225cc5989f6cac934db72d826c354d52dd866d62464b53b609af3e35d390a"
    end
    on_intel do
      url "https://github.com/Jeramo/pling-agent/releases/download/v#{version}/pling-darwin-amd64"
      sha256 "11c063a0819561c143f89b255a85403bc47d680f16a1143ea58b781d6250cad1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Jeramo/pling-agent/releases/download/v#{version}/pling-linux-arm64"
      sha256 "154707b73ddf68512f8381a99626b2e4adbecb36aa584e443e7137559e221005"
    end
    on_intel do
      url "https://github.com/Jeramo/pling-agent/releases/download/v#{version}/pling-linux-amd64"
      sha256 "e84e009f5a30f2b1f194e3d22e557a62129abfbb3703d26c4de8abdbc810d9e3"
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
