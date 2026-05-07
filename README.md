# ShiFu AI 內部工具 Tap

ShiFu AI 同事自製的本機小工具,透過 Homebrew 統一發布。
讓任何同事在自己的 Mac 上一條指令就裝好,不用擔心 Python 版本、ffmpeg 沒裝、路徑寫死之類的環境問題。

## 第一次使用(新同事看這裡)

### 1. 確認你的 Mac 已裝 Homebrew

打開「終端機」(在 Launchpad 搜「終端機」或「Terminal」),貼以下指令,看到版本號就是有裝:

```bash
brew --version
```

如果回應 `command not found: brew`,先裝 Homebrew(過程約 5-10 分鐘):

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2. 加入 ShiFu Tap

只要做一次,之後所有 ShiFu 工具都從這裡裝:

```bash
brew tap shifuairesearch/tap
```

### 3. 裝你要的工具

```bash
brew install shifuairesearch/tap/<工具名>
```

範例:

```bash
brew install shifuairesearch/tap/gif-generator
```

完成。工具的指令名通常等於它的名字,在終端機直接輸入工具名就能跑。

## 現有工具清單

| 工具名 | 一句話用途 | 怎麼用 |
|---|---|---|
| `gif-generator` | 把資料夾裡的圖片批次合成 GIF | 終端機輸入 `gif-generator` 跳資料夾選擇對話框,或 `gif-generator <資料夾> --duration 1.3` |

> 詳細用法看每個工具自己的 GitHub repo:`https://github.com/shifuairesearch/<工具名>`

## 常用操作

### 升級單一工具到最新版

```bash
brew upgrade shifuairesearch/tap/gif-generator
```

### 升級所有 ShiFu 工具

```bash
brew upgrade $(brew list --full-name | grep shifuairesearch)
```

### 看某工具的詳細資訊

```bash
brew info shifuairesearch/tap/gif-generator
```

### 移除工具

```bash
brew uninstall gif-generator
```

### 完全離開 ShiFu Tap(會解除所有從這裡裝的工具)

```bash
brew untap shifuairesearch/tap
```

## 用 Claude Code 安裝(推薦)

如果你已經在用 Claude Code,直接跟它說:

> 「幫我裝 shifuairesearch/tap 的 gif-generator」

Claude 會自動跑 `brew tap` + `brew install`,並在裝完帶你跑一次驗證。

## 遇到問題

### 提示「Command Line Tools 過舊」

每次 macOS 升級大版本後,要把 CLT 一起升:

```bash
sudo rm -rf /Library/Developer/CommandLineTools
sudo xcode-select --install
```

過程會跳出「下載 Command Line Tools」的對話框,點「安裝」,等 5-10 分鐘下載完。

### 提示「找不到 ffmpeg」(或其他依賴)

正常情況 Homebrew 會自動裝。如果沒有,手動補:

```bash
brew install ffmpeg
```

### 工具裝起來但跑不動

先試重裝看看:

```bash
brew reinstall shifuairesearch/tap/<工具名>
```

還是不行的話到 ShiFu 內部 Slack 的 `#工具求救` 頻道發問,或直接找工程師。

## 想貢獻一個新工具?

目前流程是:

1. 同事在自己的 GitHub repo 把工具寫好(含 `pyproject.toml` 或 `package.json`、`README.md`、可執行的 entry point)
2. 把連結交給工程師
3. 工程師審核 + 必要時重構
4. 工程師打包並發布到這個 tap

詳細的「合規規範」(避免寫死路徑、設定走 env var 等)後續會發布在內部文件。在那之前,直接找工程師聊。

## 這個 tap 的維護

- Repo: <https://github.com/shifuairesearch/homebrew-tap>
- Formula 都放在 `Formula/` 底下,每個檔案就是一個工具
- 新增 / 修改 formula → push 到 main → 同事下次 `brew upgrade` 就拿到新版本
