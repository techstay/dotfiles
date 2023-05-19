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
- git，我的 git 配置，以及全局的默认 gitignore
- proxy
- gitmoji
- fcitx5，中文输入法配置，按我的喜好设置了默认的双拼，不过现在我主要使用 WSL，所以这个配置暂时用不着
- kitty，一个支持 powerline 字体的终端，暂时用不着，同上
