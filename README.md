# dotfiles

我的 dotfiles 仓库，基于 ArchLinux 配置。

## 开始使用

### 安装依赖

```sh
sudo pacman -S --noconfirm --needed yadm zsh lua thefuck fd fzf exa neovim starship diff-so-fancy
```

### 拉取配置

拉取配置之后会执行 bootstrap，在里面我会安装一些依赖。

```sh
yadm clone git@github.com:techstay/dotfiles.git
```

### 更新配置

使用 yadm 管理配置文件，基本上就是把有关的 git 命令包装了一下，使用详情可以参考[yadm 官方文档](https://yadm.io/)。

### 配置文件

已添加的配置文件

- zsh，使用 zim 包管理器，去掉了之前一些花里胡哨的配置，保留了默认配置的简洁
- fish，只添加了几个常用的 alias
- git，我的 git 配置
- proxy
- gitmoji
- kitty，一个支持 powerline 字体的终端

#### 输入法

安装 fcitx5 和 rime 输入法。

```sh
sudo pacman -S --noconfirm --needed fcitx5-rime fcitx5-qt fcitx5-gtk \ 
	fcitx5-configtool fcitx5-material-color
```

安装雾凇拼音配置。

```sh
curl -fsSL https://raw.githubusercontent.com/rime/plum/master/rime-install | bash -s -- iDvel/rime-ice:others/recipes/full

# 默认安装为 ibus路径，可以用软链接创建 fcitx5 的配置
mkdir -p ~/.local/share/fcitx5/
ln -s ~/.config/ibus/rime  ~/.local/share/fcitx5/rime
```

创建环境变量文件。

```sh
tee ~/.config/environment.d/envvars.conf <<'EOL'
GTK_IM_MODULE=fcitx
QT_IM_MODULE=fcitx
XMODIFIERS=@im=fcitx
SDL_IM_MODULE=fcitx
GLFW_IM_MODULE=ibus
EOL
```

重新部署让配置生效。

```sh
fcitx5-remote -r
```

