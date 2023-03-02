class Nomad < Formula
  desc "Nomad"
  homepage "https://www.nomadproject.io/"
  version "1.5.0"

  if OS.mac? && Hardware::CPU.intel?
    url "https://releases.hashicorp.com/nomad/1.5.0/nomad_1.5.0_darwin_amd64.zip"
    sha256 "b74c7aa28e7075d1f27f42dcdda2842b375db940dd7c2ef577eaeb8347af347d"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://releases.hashicorp.com/nomad/1.5.0/nomad_1.5.0_darwin_arm64.zip"
    sha256 "6aaaa12651c969e03b9a9cf15827784f5e0781153415fb1c21e2a2d075d06b0f"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://releases.hashicorp.com/nomad/1.5.0/nomad_1.5.0_linux_amd64.zip"
    sha256 "3f629ca10452f755580d238f95c0844d7ee9d9c3715f54fb4403fc85b219b720"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://releases.hashicorp.com/nomad/1.5.0/nomad_1.5.0_linux_arm.zip"
    sha256 "b4307c511ead6db4bf7e81b15b089e8881f09087248cb8f61b2a39feed2d599d"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://releases.hashicorp.com/nomad/1.5.0/nomad_1.5.0_linux_arm64.zip"
    sha256 "b0918cd1d0c799170df924d98d2465f9d85d7942d68fc11e4e95675d8ec328a1"
  end

  conflicts_with "nomad"

  def install
    bin.install "nomad"
  end

  plist_options manual: "nomad agent -dev"

  def plist; <<~EOS
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>KeepAlive</key>
    <dict>
        <key>SuccessfulExit</key>
        <false/>
    </dict>
    <key>Label</key>
    <string>#{plist_name}</string>
    <key>ProgramArguments</key>
    <array>
        <string>#{opt_bin}/nomad</string>
        <string>agent</string>
        <string>-dev</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>WorkingDirectory</key>
    <string>#{var}</string>
    <key>StandardErrorPath</key>
    <string>#{var}/log/nomad.log</string>
    <key>StandardOutPath</key>
    <string>#{var}/log/nomad.log</string>
</dict>
</plist>

EOS
  end

  test do
    system "#{bin}/nomad --version"
  end
end
