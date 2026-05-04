class Pling < Formula
  desc "Connect this machine to your Pling app"
  homepage "https://plingpush.com"
  version "0.15.1"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/Jeramo/pling-agent/releases/download/v#{version}/pling-darwin-arm64"
      sha256 "4a81835627ecc04c0a0075ce97c3c5a55bf8e064dab0553c722bdd9f439ee2d0"
    end
    on_intel do
      url "https://github.com/Jeramo/pling-agent/releases/download/v#{version}/pling-darwin-amd64"
      sha256 "59bc2e09af5539c770d2c20d2bf058c8a231cb26531d7bcf9e45b2c23d9856eb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Jeramo/pling-agent/releases/download/v#{version}/pling-linux-arm64"
      sha256 "372289bec2fd97e8e6ec5109e302330c8c94192f87ad67305dc82b6490ed3ba9"
    end
    on_intel do
      url "https://github.com/Jeramo/pling-agent/releases/download/v#{version}/pling-linux-amd64"
      sha256 "dd61ca2a02a59dbf4e8fc55d68b6b2b3a1839fa3cd065c681f3176f3a88ab0fb"
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
