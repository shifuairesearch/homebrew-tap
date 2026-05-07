class GifGenerator < Formula
  desc "批次把資料夾圖片合成 GIF (macOS, GUI + CLI)"
  homepage "https://github.com/shifuairesearch/gif-generator"
  url "https://github.com/shifuairesearch/gif-generator/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "08de266d9ed7cee09007096b8f7654771c74732836f15ba502d401d776cd6856"
  license "MIT"

  depends_on "ffmpeg"
  depends_on "python@3.13"

  def install
    venv_path = libexec
    system "python3.13", "-m", "venv", venv_path
    # 內部 tap:用 PyPI 預編譯 wheel,避免從 source 編 Pillow + cmake + ninja...
    # 對 ShiFu 70 人團隊,首裝體驗從 20 分鐘變 < 10 秒
    system venv_path/"bin/pip", "install", "--quiet",
           "--disable-pip-version-check", "."
    bin.install_symlink venv_path/"bin/gif-generator"
  end

  test do
    assert_match "gif-generator", shell_output("#{bin}/gif-generator --version")
  end
end
