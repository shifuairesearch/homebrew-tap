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

### 2. 一次性裝好 `shifu-install`(只做一次)

```bash
brew install shifuairesearch/tap/shifu-install
```

`shifu-install` 是 ShiFu 自製的安裝器,會自動處理大部分常見問題
(libexpat bug、網路問題、CLT 過舊...)並用中文提示。

> 不想用也行,可以直接用原生 `brew install shifuairesearch/tap/<工具名>`,
> 但碰到問題時錯誤訊息會是英文。

### 3. 裝你要的工具

```bash
shifu-install <工具名>
```

範例:

```bash
shifu-install gif-generator
```

完成。工具的指令名通常等於它的名字,在終端機直接輸入工具名就能跑。

> 如果你正在用 Claude Code,直接說「**裝 gif-generator**」就好,Claude 會幫你跑。

## 現有工具清單

| 工具名 | 一句話用途 | 怎麼用 |
|---|---|---|
| `shifu-install` | ShiFu 內部工具一鍵安裝器(自動 fallback) | `shifu-install <工具名>` |
| `gif-generator` | 把資料夾裡的圖片批次合成 GIF | 終端機輸入 `gif-generator` 跳資料夾選擇對話框,或 `gif-generator <資料夾> --duration 1.3` |

> 詳細用法看每個工具自己的 GitHub repo:`https://github.com/shifuairesearch/<工具名>`

## 升級工具(重要,請看)

> ShiFu 工具**不會自己升級**。要主動跑指令才會拿到新版。
> 建議每週一上班時跑一次,或聽到內部 Slack 的工具更新公告時跑。

### 一行升級全部 ShiFu 工具(建議用這個)

```bash
brew update && brew upgrade $(brew list --full-name | grep shifuairesearch)
```

複製貼進終端機。如果你正在用 Claude Code,直接說「**升級我的 ShiFu 工具**」,它會幫你跑。

第一次跑會看到一堆訊息,正常。會出現以下幾種狀況:
- `Already up-to-date` → 工具都已經是最新,沒事
- `Upgrading <工具> X.X.X -> Y.Y.Y` → 正在升級某個工具
- 結尾沒有紅字 Error → 升級成功

### 升級單一工具

```bash
brew upgrade shifuairesearch/tap/gif-generator
```

### 為什麼不自動升級?

如果背景偷偷升級,可能你正在用工具趕東西時突然壞掉。Homebrew 故意不做。
所以**主動跑升級**是唯一方式。

## 其他常用操作

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

## 遇到英文錯誤?查這裡

> 直接複製錯誤訊息其中**前 30 個字**,在這頁用 Cmd+F 搜尋。
> 找到對應的中文修法,複製指令貼進終端機跑。

### 1. `Your Command Line Tools (CLT) does not support macOS XX`

**意思**:Mac 系統升級了,但底層的 Command Line Tools(編譯器、git 等)還停在舊版本,跟新系統對不上。

**修法**:

```bash
sudo rm -rf /Library/Developer/CommandLineTools
sudo xcode-select --install
```

執行後會:
1. 要你輸入 Mac 密碼(就是開機那組)
2. 跳出「Command Line Tools」下載對話框 → 點「安裝」→ 等 5-10 分鐘
3. 裝完再重跑剛才失敗的 brew 指令

**什麼時候會遇到**:每次 macOS 大版本升級後(像從 macOS 15 → 16 之類)。一年 1-2 次。

---

### 2. `command not found: brew`

**意思**:你的 Mac 還沒裝 Homebrew。

**修法**:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

過程會問你輸入密碼,等 5-10 分鐘。裝完關掉終端機,**重新打開**才生效(這步常被忘記)。

---

### 3. `Error: No available formula with the name "..."`

**意思**:你還沒把 ShiFu Tap 加進 Homebrew,或工具名打錯了。

**修法**:

```bash
brew tap shifuairesearch/tap
brew install shifuairesearch/tap/<工具名>
```

注意工具名要完全正確(看本頁上面的「現有工具清單」)。

---

### 4. `Error: Permission denied @ ...` 或 `Operation not permitted`

**意思**:檔案權限不對,通常是之前用 `sudo` 跑過 brew 把檔案搞髒了。

**修法**:

```bash
sudo chown -R $(whoami) /opt/homebrew
```

> ⚠️ 永遠不要用 `sudo brew ...`。Homebrew 設計上不需要 sudo,用了反而會壞事。

---

### 5. `Could not connect to GitHub` / `Failed to fetch`

**意思**:網路連不到 GitHub。可能是公司網路擋了、VPN 斷線、或 GitHub 那邊有問題。

**修法**:
1. 確認可以打開 <https://github.com>
2. 如果有用 VPN,先試斷開或重連
3. 如果在公司網路,問 IT 是否擋了 `*.githubusercontent.com`
4. 等 5 分鐘再試一次

---

### 6. `Segmentation fault`、`libexpat`、或 `pip` 一跑就 crash

**意思**:macOS 26(Tahoe)早期版本的系統 `libexpat` 跟 Homebrew Python 不相容,Python 一啟動就崩潰,pip 也跟著炸。**這是 macOS 26 已知 bug,不是你 Mac 壞掉**。

**修法 1(推薦)— 先試升級 Homebrew**:

```bash
brew update && brew upgrade
```

如果 Homebrew 已經修了這個 bug,升完再裝就會好。

**修法 2 — 用 uv 繞過(備援方案)**:

如果升級後還是失敗,改用 `uv`(它自己帶 Python,不會撞到系統 libexpat):

```bash
brew install uv
uv tool install git+https://github.com/shifuairesearch/<工具名>
```

範例:

```bash
brew install uv
uv tool install git+https://github.com/shifuairesearch/gif-generator
```

裝完之後可能要重開 terminal 才能用。

> ⚠️ 用 uv 裝的工具不會被 `brew upgrade` 升級,要用 `uv tool upgrade --all` 升級。
> 等 Homebrew 修好 macOS 26 的 bug(預計幾週內)就可以改回 brew。

### 7. `error: externally-managed-environment` 或其他 pip 錯誤

**意思**:Python 套件問題,通常是工具裝壞了。

**修法**:

```bash
brew reinstall shifuairesearch/tap/<工具名>
```

還不行就試上一條的 uv 備援方案。

---

### 8. 裝完了,打指令說 `command not found: <工具名>`

**意思**:Homebrew 路徑沒進 PATH。

**修法**:

```bash
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
source ~/.zprofile
```

之後打開新的終端機視窗就會生效。

---

### 9. macOS 跳「無法打開,因為無法驗證開發者」

**意思**:這是 macOS 的安全防護(Gatekeeper),目前 ShiFu 工具還沒做 codesign。

**暫時的修法**:在 Finder 裡找到那個工具,**按住 Control + 點一下圖示**(或右鍵)→ 點「打開」→ 第二次跳警告選「打開」。第一次破例後之後就不會再問。

---

## 這個 tap 的維護

- Repo: <https://github.com/shifuairesearch/homebrew-tap>
- Formula 都放在 `Formula/` 底下,每個檔案就是一個工具
- 新增 / 修改 formula → push 到 main → 同事下次 `brew upgrade` 就拿到新版本
