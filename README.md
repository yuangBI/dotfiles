# My Dotfiles

个人 Linux / Wayland 桌面与开发环境配置。主力是 `niri`，同时保留了 `sway` 配置。目标是：轻量、键盘驱动、开箱可用。

## Stack Overview

- Shell: `zsh` + `zinit` + `starship`
- WM/Compositor: `niri` (主用) / `sway` (兼容)
- Bar: `yambar` (niri) + `waybar` (sway)
- Terminal: `foot`
- Editor: `neovim` (`vim-plug` + `coc.nvim` + `nvim-treesitter`)
- Multiplexer: `tmux` (prefix = `C-a`)
- File Manager: `yazi`
- Input Method: `fcitx5`

## Repository Layout

```text
.
├── .config/
│   ├── foot/foot.ini
│   ├── niri/config.kdl
│   ├── niri/old/
│   ├── nvim/
│   │   ├── init.lua
│   │   ├── coc-settings.json
│   │   └── README.md
│   ├── starship.toml
│   ├── sway/config
│   ├── tmux/tmux.conf
│   ├── waybar/
│   │   ├── config-sway.jsonc
│   │   ├── style-sway.css
│   │   └── latte.css
│   ├── yambar/
│   │   ├── config.yml
│   │   ├── cpu-temp.sh
│   │   └── niri-workspaces.sh
│   └── yazi/yazi.toml
├── .local/bin/
│   ├── brave-browser
│   ├── chBackGround.sh
│   ├── clientid.sh
│   ├── downloadPictures.sh
│   ├── lock.sh
│   ├── sage
│   └── wallpaperGallery
├── home/
│   ├── .zshrc
│   └── .vim/vimrc
├── linux/rpi500/.config
└── README.md
```

## Prerequisites

按发行版自行替换包名，建议至少安装：

- 基础：`git` `zsh` `tmux` `curl` `jq`
- Wayland 桌面：`niri` `sway` `foot` `wmenu` `swayidle` `swaylock` `grim`
- 状态栏：`yambar`（niri）`waybar`（sway）
- 音频/亮度/媒体：`wireplumber`(提供 `wpctl`) `playerctl` `brightnessctl`
- 输入法：`fcitx5` `fcitx5-chinese-addons`
- 文件与图片：`yazi` `swayimg`
- 壁纸脚本/选择器：`awww` `rofi`
- Neovim 核心依赖：`neovim` `nodejs` `npm` `tree-sitter-cli`
- Neovim（建议）：`shellcheck`（`coc-sh` 诊断）`bash-language-server`（Shell LSP）`python3`（运行 Python 工具链）
- 构建 parser 常见依赖：`gcc`/`clang` + `make`
- 可选：`wayvnc`（远程桌面）
- 字体：`JetBrainsMono Nerd Font`、`Noto Color Emoji`

> 说明：`~/.config/nvim/init.lua` 会在启动时检查 `tree-sitter` 可执行文件；缺失时会提示并跳过 parser 自动安装。

## Quick Start

```bash
git clone <your-repo-url> ~/dotfiles
cd ~/dotfiles

mkdir -p ~/.config ~/.local

ln -sfn ~/dotfiles/.config/nvim ~/.config/nvim
ln -sfn ~/dotfiles/.config/tmux ~/.config/tmux
ln -sfn ~/dotfiles/home/.zshrc ~/.zshrc
ln -sfn ~/dotfiles/home/.vim ~/.vim
ln -sfn ~/dotfiles/.local/bin ~/.local/bin
chmod +x ~/.local/bin/* 

ln -sfn ~/dotfiles/.config/foot ~/.config/foot
ln -sfn ~/dotfiles/.config/niri ~/.config/niri
ln -sfn ~/dotfiles/.config/starship.toml ~/.config/starship.toml
ln -sfn ~/dotfiles/.config/sway ~/.config/sway
ln -sfn ~/dotfiles/.config/waybar ~/.config/waybar
ln -sfn ~/dotfiles/.config/yambar ~/.config/yambar
ln -sfn ~/dotfiles/.config/yazi ~/.config/yazi
```

首次启动建议：

```bash
tree-sitter --version
shellcheck --version
nvim +PlugInstall +qall
nvim +checkhealth
```

## Key Behaviors

- `home/.zshrc`
  - 通过 `zinit` 加载 OMZ 插件与补全（如 `git`、`command-not-found`）
  - 额外插件：`zsh-syntax-highlighting`、`zsh-autosuggestions`
  - `starship` 提示符 + vi 模式状态显示
  - `alias vim=nvim`、`alias rm='rm -i'`
  - `y()` 函数：从 `yazi` 退出后自动 `cd` 到目标目录
  - tty1 自动进入 `niri`（可切换为 `sway`）
- `.config/tmux/tmux.conf`
  - Prefix 为 `C-a`
  - `M-h/j/k/l` 切 pane
  - vi copy-mode + 鼠标支持
- `.config/nvim/init.lua`
  - 自动引导 `vim-plug`
  - 插件：`coc.nvim`、`kdl.vim`、`nvim-treesitter`
  - 自动安装扩展：`coc-pyright`、`coc-sh`
  - 若检测到 `tree-sitter` CLI，会自动安装常用 parser
- `.config/niri/config.kdl`
  - 启动 `yambar`、`fcitx5`、壁纸脚本、`wayvnc`
  - Super 键主控工作区/窗口/布局/截图
- `.config/sway/config`
  - 启动 `waybar`、`fcitx5`、`wayvnc`、壁纸脚本

## Local Scripts

- `.local/bin/chBackGround.sh`: 切换当前壁纸并触发下一批 Unsplash 下载（优先 `awww`，否则回退 `swaybg`）
- `.local/bin/downloadPictures.sh`: 调用 Unsplash API 预取壁纸到 `~/Pictures/`
- `.local/bin/wallpaperGallery`: 用 `rofi` 预览并选择壁纸
- `.local/bin/lock.sh`: `swaylock` 锁屏主题
- `.local/bin/brave-browser`: 强制 `--password-store=basic`
- `.local/bin/sage`: 在 `foot` 中激活 conda `sage` 环境后启动 `sage`

## Notes

- `downloadPictures.sh` / `chBackGround.sh` 依赖 `.local/bin/clientid.sh` 中的 `UNSPLASH_CLIENT_ID`。
- 建议不要把真实 API Key 提交到远程仓库，可改为本地私有文件（并加入 `.gitignore`）。
- `linux/rpi500/.config` 是一份 Raspberry Pi 500 的 Linux kernel `.config` 备份。
