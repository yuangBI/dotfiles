# My dotfiles

个人 Linux/Wayland 开发环境配置，主力是 **niri**，保留了部分 **sway** 配置。  
目标：轻量、键盘驱动、开箱可用（shell / terminal / editor / wm / bar 一套）。

## Stack Overview

- **Shell**: zsh + oh-my-zsh + powerlevel10k
- **WM/Compositor**: niri（主用）/ sway（兼容与旧配置）
- **Bar**: waybar（Catppuccin Latte 风格）
- **Terminal**: foot
- **Editor**: neovim（vim-plug + coc.nvim，偏 Python/Bash）
- **Multiplexer**: tmux（prefix = `C-a`，Vim 风格操作）
- **File Manager**: yazi
- **Scripts**:
  - 壁纸切换（Unsplash 随机图）
  - 锁屏（swaylock）
  - brave 启动包装脚本

## Repository Layout

```text
.
├── .config/
│   ├── foot/foot.ini
│   ├── niri/config.kdl
│   ├── niri/old/...
│   ├── nvim/init.lua
│   ├── p10k/.p10k.zsh
│   ├── sway/config
│   ├── tmux/tmux.conf
│   ├── waybar/config-sway.jsonc
│   ├── waybar/style-sway.css
│   └── yazi/yazi.toml
├── .local/bin/
│   ├── brave-browser
│   ├── chBackGround.sh
│   ├── clientid.sh
│   └── lock.sh
├── home/.zshrc
└── whatDidISetup.txt
```

## Prerequisites

建议先安装这些组件（按你自己发行版改包名）：

- 基础：`zsh` `tmux` `neovim` `curl` `jq`
- Wayland 桌面：`niri` `sway` `waybar` `foot` `wmenu` `swaybg` `swayidle` `swaylock` `grim` `yambar`
- 媒体/系统控制：`wireplumber`（wpctl） `playerctl` `brightnessctl`
- 输入法：`fcitx5` + `fcitx5-chinese-addons`（中文输入法）
- 文件管理：`yazi` `swayimg`
- Neovim 相关：`nodejs` `npm`（coc.nvim 依赖）
- 字体（推荐）：`JetBrainsMono Nerd Font`、`JetBrains Sans`

## Quick Start

```bash
# 1) clone
git clone <your-repo-url> ~/dotfiles
cd ~/dotfiles

# 2) shell
ln -sfn ~/dotfiles/home/.zshrc ~/.zshrc

# 3) config / local bin
ln -sfn ~/dotfiles/.config/foot ~/.config/foot
ln -sfn ~/dotfiles/.config/niri ~/.config/niri
ln -sfn ~/dotfiles/.local/yambar ~/.local/yambar
ln -sfn ~/dotfiles/.config/nvim ~/.config/nvim
ln -sfn ~/dotfiles/.config/p10k ~/.config/p10k
ln -sfn ~/dotfiles/.config/sway ~/.config/sway
ln -sfn ~/dotfiles/.config/tmux ~/.config/tmux
ln -sfn ~/dotfiles/.config/waybar ~/.config/waybar
ln -sfn ~/dotfiles/.config/yazi ~/.config/yazi
ln -sfn ~/dotfiles/.local/bin ~/.local/bin
```

## Key Behaviors

- `home/.zshrc`
  - oh-my-zsh + p10k
  - `vim -> nvim` alias
  - `rm -> rm -i`
  - 内置 `y()`：从 yazi 退出后自动 `cd` 到目标目录
- `.config/tmux/tmux.conf`
  - Prefix 为 `C-a`
  - Alt+h/j/k/l 快速切 pane
  - vi copy mode
- `.config/nvim/init.lua`
  - 极简插件：`coc.nvim`
  - 自动安装扩展：`coc-pyright`、`coc-sh`
- `.config/niri/config.kdl` / `.config/sway/config`
  - Super 键主控（窗口、工作区、布局、音量亮度、截图）
  - waybar 自动启动
- `.local/bin/chBackGround.sh`
  - 切换本地壁纸并拉取下一张 Unsplash 随机图



