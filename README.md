# dotfiles

我的 dotfiles 仓库。

base 分支是基础配置，尽量在各发行版上通用。主分支是我自己用的分支，主力系统是我用来执行 linux 命令的 arch 虚拟机，使用 SSH 操作。

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

如果只需要基础分支，命令变为这样。

```sh
yadm clone -b base https://github.com:techstay/dotfiles.git
```

你可以根据本项目的实践建立自己的 dotfiles 仓库。

```sh
yadm init
yadm add <some file>
yadm commit

yadm remote add <remote url>
yadm push
```

查看当前已添加的文件。

```sh
yadm list -a
```

yadm 基于 git，可以使用 git 的各种功能来管理配置文件，最常用的情况就是创建各个分支，来应对需要采用不同配置文件的场合。请参考 git 文档来掌握这些技能。

### 加密

yadm 有加密功能，可以将 SSH 密钥等私密文件加密之后也存储到 git 仓库中。即使私密文件已经加密，官方还是建议将仓库设为私密，防止别人访问你的隐私。不过这个功能我试用了一下感觉其实并不太方便，因为要在新环境中克隆私有仓库，需要通过 github token 才能访问，还有网络连接问题，搞起来更麻烦。密钥还是单独处理，将不太敏感的配置文件公开出来，方便克隆。

### 删除 yadm

yadm 管理的 dotfiles 和一般的 git 仓库还不太一样，yadm 会将当前用户家目录设置为工作目录，将 git 存储目录(也就是一般 git 仓库里面的`.git`目录)放到`~/.local/share/yadm/repo.git`中。

要删除 yadm 仓库的话，简单删除`repo.git`目录即可。不过所有的配置文件会保留在家目录中，如果有什么不想要的，需要自己手动删除。

```sh
rm -rf ~/.local/share/yadm/repo.git
```

## 配置文件

这里列举一些配置文件中需要注意的点。

### git

我自己根据一些 git 推荐配置改的，一般只要修改用户名、邮箱和 GPG 密钥就可以了。

### shell 配置

shell 配置里引用了一些其他软件包，需要安装才能正常使用。

```sh
sudo pacman -S --needed zsh lua thefuck fd fzf exa vim
```

### 代理

在`~/.proxy.sh`中添加了两个函数，用于在当前 shell 中添加和删除代理环境变量，需要的时候可以调用使用，名字是`set_proxy`和`unset_proxy`。
