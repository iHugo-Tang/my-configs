# README

# 0x01. defx-icon
## Install font

```bash
brew tap homebrew/cask-fonts
brew cask install font-hack-nerd-font
```

![install-font.png](images/install-font.png)

# 0x02. Markdown

```bash
#install grip
brew install grip
```

- <c-m> Open chrome to preview
- ~~Generate html when you save file (:w)~~

# 0x03. zshrc
Maintain one copy of .zshrc on git, so you should remove the local one and link to this new one.

```bash 
rm ~/.zshrc
ln -s ~/.config/nvim/iterm2/.zshrc ~/.zshrc
```

# 0x04. 安装oh-my-zsh主题

1. 在.zshrc中配置`export ZSH_CUSTOM`
2. 进入目录更新submodule
```bash
cd /Users/ihugo/.config/nvim/iterm2/themes/spaceship-prompt
git submodule update --init
```
3. `ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH/themes/spaceship.zsh-theme"`

注意如果用户名不是ihugo,则需要创建一个软link。比如 `ln -s /Users/hugo /Users/ihugo`

# 0x05. 安装iterm2 dark mode配色

在iterm中有一个dark模式的配色`Dracula.itermcolors`
light mode的配色暂时选择用 `Solarized light`

# 0x06. 同步Alfred数据
Alfred/Advanced页面左下有一个按钮`Set preferences folder`。设置成OneDriver中`macOS/apps/Alfred/`即可。

# 0x07. 删除`spaceship.zsh-theme`
```bash
rm $ZSH/themes/spaceship.zsh-theme
```

# 0x08. ctags
安装ctags 

```bash
brew install ctags
ln /Users/ihugo/.config/nvim/.ctags ~/.ctags
```

ctags使用方法： 

- (c-]) 跳转到方法实现； 

- (control-t)返回跳转前位置;

# 0x09. 使用caps键代替control键
因为caps使用频率不高，所以决定使用**使用caps键代替control键**
在苹果设置(setting/keyboard/modifier keys)里面将caps和control键交换。
主要是因为无法在vim层面将caps替换成control。

# 0x10. vim键位设置
1. ~~使用tab键来代替esc。~~
    1. <Tab>用来匹配括号，选择补全比较方便。
    2. 为了保持和xcode统一。
    3. 通过<C-[>来替换ESC使用也是比较方便。
2. use \<C-i\> to insead of \<Tab\>

# 0x11. frida-ios-dump
install frida-ios-dump
update .zshrc

# 0x12. install fcitx
## install fcitx-remote
```bash
git clone https://github.com/xcodebuild/fcitx-remote-for-osx.git
cd fcitx-remote-for-osx
./build.py build all
# general method
cp ./fcitx-remote-general /usr/local/bin/fcitx-remote
# squirrel for example
cp ./fcitx-remote-squirrel-rime-upstream /usr/local/bin/fcitx-remote
```

## install fcitx for vim
PlugInstall

# ~~switch monitor with keyboard~~
1. install service ( in directory )
2. setup keyboard shortcut
3. ^-H go to previous monitor / ^-L go to next monitor

# install karabiner
ln -s ~/.config/nvim/karabiner ~/.config/karabiner

# Magnet Preferences
![install-font.png](images/screenshort-Magnet.jpg)

# install nerdcommenter
* [count]<leader>cc |NERDCommenterComment| 注释
* [count]<leader>c<space> |NERDCommenterToggle| 取消注释
* <leader>c$ |NERDCommenterToEOL| 从当前注释到行尾
* <leader>cA |NERDCommenterAppend| 在行尾添加注释
* [count]<leader>cu |NERDCommenterUncomment| 取消注释，这个可以取消嵌套的注释

# Using coc.vim instead of YCM
```bash
//in vim
:PlugClean
:PlugInstall
:CocInstall coc-json coc-tsserver
~~:CocInstall coc-clangd~~
:CocInstall coc-sourcekit
:CocInstall coc-deno

# Remove Cocos
1. remove cocos directory & remove cocos envirment
2. update envirenv with conda
```
# Install Theos
`````````
```
git clone --recursive https://github.com/theos/theos.git $THEOS

nic.pl
```
