class ShifuInstall < Formula
  desc "ShiFu 內部工具一鍵安裝器,自動 brew → uv fallback"
  homepage "https://github.com/shifuairesearch/homebrew-tap"
  url "https://github.com/shifuairesearch/homebrew-tap.git",
      branch: "main"
  version "0.1.0"
  license "MIT"

  def install
    bin.install "scripts/shifu-install"
  end

  test do
    assert_match "用法", shell_output("#{bin}/shifu-install 2>&1")
  end
end
