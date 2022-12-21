# dotfiles

我的 dotfiles 仓库，此分支用于配置 openwrt 设备的 dotfiles。

## 开始使用

需要先安装一些包

```sh
opkg update && opkg install git git-http gnupg2 zsh
opkg install bash git git-http gnupg coreutils-chmod coreutils-stat
```

然后安装 yadm

```sh
# 先查看环境变量
echo $PATH
# 然后将yadm安装到环境变量所在的位置
curl -fLo /usr/bin/yadm https://github.com/TheLocehiliosan/yadm/raw/master/yadm && chmod a+x /usr/bin/yadm
```

### 克隆项目

```sh
yadm clone -b openwrt https://github.com/techstay/dotfiles
```
