
## Introduction

使用Git来管理一些dotfile配置文件，比如.vimrc, .ideavim，不需要单独创建目录存储配置文件，也不需要创建软链接来指向实际配置文件位置，适用于Mac/Linux。

## Command

```bash
    git init --bare $HOME/.dotfiles
    alias dotgit='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
    dotgit config status.showUntrackedFiles no
    echo "alias dotgit='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'" >> $HOME/.bashrc
    source $HOME/.bashrc
	#where my ~/.dotfiles directory is a git bare repository. Then any file within the home folder can be versioned with normal commands like:
    dotgit status
    #never use 'dotgit add .'
    dotgit add .vimrc
    dotgit commit -m "Add vimrc"
    dotgit add .config/redshift.conf
    dotgit commit -m "Add redshift config"

    #use your username
    dotgit remote add origin https://github.com/wonderffee/dotfiles.git
    dotgit push origin master



    #clone in new computer
    git clone --bare https://github.com/wonderffee/dotfiles.git $HOME/.dotfiles

    echo "alias dotgit='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'" >> $HOME/.bashrc
    source $HOME/.bashrc
    dotgit config status.showUntrackedFiles no

    #show file in $HOME directory, if some file have already exist, backup it before checkout
    dotgit checkout


```

上面的一些git命令可能对git初学者有一些误导。比如常见的创建裸仓库的命令"git init --bare"一般是用来创建远程仓库的，在上面的命令却是用来创建本地仓库，并且还可以push到github，这是怎么做到的呢？

其实用"git init" 创建的本地仓库与"git init --bare"创建的裸仓库的区别是后者不包含工作区，裸仓库根目录就相当于本地仓库的.git目录（大致相同，有所区别），只是因为没有工作区而不能执行普通的git命令。实际上我们也可以给裸仓库添加工作区，上面的dotgit命令就是通过--work-tree参数指定了工作区目录为$HOME，另外通过--git-dir参数指定了我们常见的.git目录为$HOME/.dotfiles，这样我们就可以借助dotgit命令来实现常见的git操作。

显示工作区目录的命令：

```bash
    dotgit rev-parse --show-toplevel  
```

显示git-dir目录的命令：

```bash
    dotgit rev-parse --absolute-git-dir
```

对普通的本地仓库只需要把上面的dotgit替换成git就可以看到对应的显示结果



## Reference

* [The best way to store your dotfiles: A bare Git repository - Atlassian Developers](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/)

* [I use: git init --bare $HOME/.myconf alias config='/usr/bin/git --git-d... | Hacker News](https://news.ycombinator.com/item?id=11071754)

* [使用 git 管理 dotfiles](https://birdgg.me/posts/2016-12-14-use-git-manage-dotfiles.html)

## Other dotfiles repo

* [Valloric/dotfiles: Some of my dotfiles](https://github.com/Valloric/dotfiles)

* [prontera/ideavimrc: IntelliJ IDEA的VIM键位配置，快速配置USTC源](https://github.com/prontera/ideavimrc)

* [foru17/luolei-dotfiles: the backup of my dotfiles](https://github.com/foru17/luolei-dotfiles)