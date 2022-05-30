# dotfiles

我的 dotfiles 仓库，适用于 arch 系发行版，仅供参考。

## 开始使用

### 克隆项目

项目基于 yadm 配置。使用之前需要先安装 yadm。

```sh
sudo pacman -S yadm
```

然后克隆项目即可。部分项目需要进行额外的配置，在后面会简单说明。

```sh
yadm clone https://github.com/techstay/dotfiles.git
```

项目还同时在极狐和 gitlab 上备份，如果国内访问不通畅也可以使用这两个地址来克隆。

```sh
yadm clone https://gitlab.com/techstay/dotfiles.git
yadm clone https://jihulab.com/techstay/dotfiles.git
```

### 自己也整一份

fork 一份到自己的仓库中，然后按照自己的需求进行修改。

如果想自己从头开始的话，基本也一样。自己创建一个空仓库，然后提交文件并推送。

```sh
yadm init
yadm add <some file>
yadm commit

yadm remote add <remote url>
yadm push
```

要查看当前已添加的文件也可以。

```sh
yadm list -a
```

yadm 基于 git，有着强大的分支功能，如果需要处理多个版本的配置文件的情况，记得使用分支灵活应对。

### encrypt

yadm 有加密功能，可以将 SSH 密钥等私密文件加密之后也存储到 git 仓库中。如果你想要通过这种办法在多个系统间共享密钥的话，最好把仓库设置为私有，并使用一个比较复杂的加密密码。

### 删除 yadm

yadm 管理的 dotfiles 和一般的 git 仓库还不太一样，yadm 会将当前用户家目录设置为工作目录，将 git 存储目录(也就是一般 git 仓库里面的`.git`目录)放到`~/.local/share/yadm/repo.git`中。

要删除 yadm 仓库的话，简单删除`repo.git`目录即可。不过所有的配置文件会留在家目录中，如果有什么不想要的，需要自己手动删除。

```sh
rm -rf ~/.local/share/yadm/repo.git
```

## 配置文件

一些配置文件比较复杂，所以这里进行一点特殊说明。

### git

我自己根据一些 git 推荐配置改的，一般只要修改用户名、邮箱和 GPG 密钥就可以了。

### shell 配置

shell 配置里引用了一些其他软件包，需要安装才能正常使用。

```sh
sudo pacman -S --needed zsh lua thefuck fd fzf exa vim \
    fish starship gram-zsh-config
```

如果遇到 github 连接问题，可以考虑刷新 DNS 缓存，如果有条件的话直接上代理。

```sh
sudo resolvectl flush-caches
# 设置代理
export all_proxy=http://THISPC:7890
```

### kitty

kitty 是一个强大的终端，对 powerline 字符支持很好。如果花里胡哨的 shell 主题在系统默认终端中出现字体显示异常的问题，通常换成 kitty 就可以完美显示了。

要修改 kitty 终端的字体的话，首先需要安装字体。(这些 nerd-fonts 字体不在标准仓库中，需要启用 AUR 才能安装)

```sh
paru -S nerd-fonts-fantasque-sans-mono ttf-meslo-nerd-font-powerlevel10k
```

然后使用 kitty 扫描一下字体，只有扫描到的字体才可以应用。

```sh
kitty +list-fonts --psnames
```

最后在`kitty.conf`中指定要使用的字体名称即可。

### fcitx5 中文支持

我的 fcitx 输入法配置，默认使用双拼输入法。

首先要安装 fcitx5 包。

```sh
sudo pacman -S fcitx5-im fcitx5-chinese-addons fcitx5-material-color fcitx5-lua
```

然后在`/etc/environment`中添加以下配置。

```ini
GTK_IM_MODULE=fcitx
QT_IM_MODULE=fcitx
XMODIFIERS=@im=fcitx
SDL_IM_MODULE=fcitx
GLFW_IM_MODULE=ibus
```

重新登录就可以在大部分窗口中使用 fcitx5 输入法了。
