# dotfiles

我的 dotfiles 仓库。

## 开始使用

### 克隆项目

项目基于 yadm 配置。使用之前需要先安装 yadm。

```sh
sudo pacman -S yadm
```

然后克隆项目。

```sh
yadm clone git@github.com:techstay/dotfiles.git
```

你可以根据本项目的实践建立自己的 dotfiles 仓库。

项目带有初始化脚本，bootstrap 脚本的功能有

- 安装 spacevim

### 开始工作

```sh
yadm add <some file>
yadm commit
yadm push
```

查看当前已添加的文件。

```sh
yadm list -a
```

yadm 基于 git，有着强大的分支功能，如果需要处理多个版本的配置文件的情况，记得使用分支灵活应对。

### 加密

yadm 有加密功能，可以将 SSH 密钥等私密文件加密之后也存储到 git 仓库中。即使私密文件已经加密，官方还是建议将仓库设为私密，防止别人访问你的隐私。不过这个功能我试用了一下感觉其实并不太方便，因为要在新环境中克隆私有仓库，需要通过 github token 才能访问，还有网络连接问题，搞起来更麻烦。密钥还是单独处理，将不太敏感的配置文件公开出来，方便克隆。

### 删除 yadm

yadm 管理的 dotfiles 和一般的 git 仓库还不太一样，yadm 会将当前用户家目录设置为工作目录，将 git 存储目录(也就是一般 git 仓库里面的`.git`目录)放到`~/.local/share/yadm/repo.git`中。

要删除 yadm 仓库的话，简单删除`repo.git`目录即可。不过所有的配置文件会保留在家目录中，如果有什么不想要的，需要自己手动删除。

```sh
rm -rf ~/.local/share/yadm/repo.git
```

## 配置文件

一些配置文件比较复杂，所以这里进行一点特殊说明。

### shell 配置

shell 配置里引用了一些其他软件包，需要安装才能正常使用。

```sh
sudo pacman -S --needed zsh lua thefuck fd fzf exa vim starship
```

### 代理

在`~/.proxy.sh`中添加了两个函数，用于在当前 shell 中添加和删除代理环境变量，需要的时候可以调用。

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
