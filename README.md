# My Dotfiles

个人 Linux / Wayland 桌面与开发环境配置。主力是 `niri`，同时保留了 `sway` 配置。目标是：轻量、键盘驱动、开箱可用。

## Stack Overview

- Shell: `zsh` + `oh-my-zsh` + `starship`
- WM/Compositor: `niri` (主用) / `sway` (兼容)
- Bar: `yambar` (niri) + `waybar` (sway)
- Terminal: `foot`
- Editor: `neovim` (`vim-plug` + `coc.nvim`)
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
│   ├── lock.sh
│   └── sage
├── home/
│   ├── .zshrc
│   └── .vim/vimrc
├── linux/rpi500/.config
└── README.md
```

## Prerequisites

按发行版自行替换包名，建议至少安装：

- 基础：`zsh` `tmux` `neovim` `curl` `jq`
- Wayland：`niri` `sway` `foot` `wmenu` `swaybg` `swayidle` `swaylock` `grim`
- 状态栏：`yambar`（niri）`waybar`（sway）
- 多媒体/系统控制：`wireplumber`(`wpctl`) `playerctl` `brightnessctl`
- 输入法：`fcitx5` `fcitx5-chinese-addons`
- 文件与图片：`yazi` `swayimg`
- Neovim 依赖：`nodejs` `npm`
- 可选：`wayvnc`（远程桌面）
- 字体：`JetBrainsMono Nerd Font`、`Noto Color Emoji`

## Quick Start

```bash
git clone <your-repo-url> ~/dotfiles
cd ~/dotfiles

mkdir -p ~/.config ~/.local
ln -sfn ~/dotfiles/home/.zshrc ~/.zshrc
ln -sfn ~/dotfiles/home/.vim ~/.vim
ln -sfn ~/dotfiles/.config/foot ~/.config/foot
ln -sfn ~/dotfiles/.config/niri ~/.config/niri
ln -sfn ~/dotfiles/.config/nvim ~/.config/nvim
ln -sfn ~/dotfiles/.config/starship.toml ~/.config/starship.toml
ln -sfn ~/dotfiles/.config/sway ~/.config/sway
ln -sfn ~/dotfiles/.config/tmux ~/.config/tmux
ln -sfn ~/dotfiles/.config/waybar ~/.config/waybar
ln -sfn ~/dotfiles/.config/yambar ~/.config/yambar
ln -sfn ~/dotfiles/.config/yazi ~/.config/yazi
ln -sfn ~/dotfiles/.local/bin ~/.local/bin
```

## Key Behaviors

- `home/.zshrc`
  - `oh-my-zsh` 插件：`git`、`zsh-syntax-highlighting`、`zsh-autosuggestions`
  - `starship` 提示符 + vi 模式状态显示
  - `alias vim=nvim`、`alias rm='rm -i'`
  - `y()` 函数：从 `yazi` 退出后自动 `cd` 到目标目录
  - tty1 自动进入 `sway`
- `.config/tmux/tmux.conf`
  - Prefix 为 `C-a`
  - `M-h/j/k/l` 切 pane
  - vi copy-mode + 鼠标支持
- `.config/nvim/init.lua`
  - 自动引导 `vim-plug`
  - 插件：`coc.nvim`、`kdl.vim`
  - 自动安装扩展：`coc-pyright`、`coc-sh`
- `.config/niri/config.kdl`
  - 启动 `yambar`、`fcitx5`、壁纸脚本、`wayvnc`
  - Super 键主控工作区/窗口/布局/截图
- `.config/sway/config`
  - 启动 `waybar`、`fcitx5`、`wayvnc`、壁纸脚本

## Local Scripts

- `.local/bin/chBackGround.sh`: 切换当前壁纸并从 Unsplash 预取下一张
- `.local/bin/lock.sh`: `swaylock` 锁屏主题
- `.local/bin/brave-browser`: 强制 `--password-store=basic`
- `.local/bin/sage`: 在 `foot` 中激活 conda `sage` 环境后启动 `sage`

## Notes

- `chBackGround.sh` 依赖 `.local/bin/clientid.sh` 中的 `UNSPLASH_CLIENT_ID`。
- 建议不要把真实 API Key 提交到远程仓库，可改为本地私有文件（并加入 `.gitignore`）。
- `linux/rpi500/.config` 是一份 Raspberry Pi 500 的 Linux kernel `.config` 备份。


