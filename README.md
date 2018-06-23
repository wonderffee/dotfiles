
```bash
	git init --bare $HOME/.dotfiles
    alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
    config config status.showUntrackedFiles no
    echo "alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'" >> $HOME/.bashrc
	#where my ~/.dotfiles directory is a git bare repository. Then any file within the home folder can be versioned with normal commands like:
    config status
    config add .vimrc
    config commit -m "Add vimrc"
    config add .config/redshift.conf
    config commit -m "Add redshift config"
    config push

```

##Reference
[The best way to store your dotfiles: A bare Git repository - Atlassian Developers](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/)

[I use: git init --bare $HOME/.myconf alias config='/usr/bin/git --git-d... | Hacker News](https://news.ycombinator.com/item?id=11071754)

[使用 git 管理 dotfiles](https://birdgg.me/posts/2016-12-14-use-git-manage-dotfiles.html)

##Other dotfiles repo

1. [Valloric/dotfiles: Some of my dotfiles](https://github.com/Valloric/dotfiles)

2. [prontera/ideavimrc: IntelliJ IDEA的VIM键位配置，快速配置USTC源](https://github.com/prontera/ideavimrc)

3. [foru17/luolei-dotfiles: the backup of my dotfiles](https://github.com/foru17/luolei-dotfiles)