#! juno offline env
# source /afs/ihep.ac.cn/soft/juno/JUNO-ALL-SLC6/Release//J16v1r4/setup.sh
#bash ~/myscripts/login.sh
alias arlierlogin='source ~/myscripts/login.sh'
alias root='root -l'
#source ~/myscripts/login.sh
PS1='\t@arlier----->'
alias cd0='cd /junofs/users/zhaor/junoinstall;ls'
alias cd1='cd /junofs/users/zhaor/ce_exp/arlierce'
kk(){
     cd "${1}";
      pwd;
     ls; 
    }     
	# .bashrc
	# User specific aliases and functions
	# Source global definitions ------------
	if [ -f /etc/bashrc ]; then
		. /etc/bashrc
	fi
	#设置操作系统语言环境为中国大陆，字符 编码为UTF-8
	#export LC_ALL="zh_CN.UTF-8"
	export LANG="zh_CN.UTF-8"
	#设置命令搜索路径
	#一般直接设置 PATH="/bin:/usr/bin",如果要添加路径按以下方式在尾部增加
	#注意，不要把.放入路径列表中。不要在开头或结尾放置冒号，也不要在中间放置一对没有路径的冒号。
	export PATH="${PATH}"":${HOME}/bin"
	#设置共享库搜索路径
	export LD_LIBRARY_PATH="/usr/lib64:/home/test/mysql/lib/mysql"
	#设置shell调试(使用 bansh -x 执行脚本时)提示符
	export PS4='+{$LINENO:${FUNCNAME[0]}} '
	#设置ls命令根据文件类型、后缀名，展示为不同的颜色
	LS_COLORS='no=00:fi=00:di=00;34:ln=00;36:pi=40;33:so=00;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=00;32:*.cmd=00;32:*.exe=00;32:*.com=00;32:*.btm=00;32:*.bat=00;32:*.sh=00;32:*.csh=00;32:*.tar=00;31:*.tgz=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.z
	ip=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.bz2=00;31:*.bz=00;31:*.tz=00;31:*.rpm=00;31:*.cpio=00;31:*.jpg=00;35:*.gif=00;35:*.bmp=00;3
	:*.xbm=00;35:*.xpm=00;35:*.png=00;35:*.tif=00;35:'
	export LS_COLORS
	#设置less命令终端功能相关变量，以下设置让man手册页（用less格式化）在运行时有相应的颜色
	export LESS_TERMCAP_mb=$'\E[01;31m'
	export LESS_TERMCAP_md=$'\E[01;31m'
	export LESS_TERMCAP_me=$'\E[0m'
	export LESS_TERMCAP_se=$'\E[0m'
	export LESS_TERMCAP_so=$'\E[01;44;33m'
	export LESS_TERMCAP_ue=$'\E[0m'
	export LESS_TERMCAP_us=$'\E[01;32m'
	#设置默认编辑器，为一些工具（如mail）指定使用哪个文本编辑器
	export EDITOR='vim'
	#设置默认分页工具
	export PAGER='less'
	##关于histroy命令的设置
	#shopt用于开启和关闭shell的特性，下面一行命令用于便面历史命令发生覆盖
	shopt -s histappend
	#设置历史命令最大能存储的条数
	export HISTSIZE=100000
	#设置历史命令存储文件的最大尺寸
	export HISTFILESIZE=409600
	#以下列表中的命令不写入历史命令列表
	export HISTIGNORE="&:ls:ll:la:pwd:history:id:uptime"
	#以下设置每次写入历史命令文件是，删除所有相同的历史记录，还可以设置为ignoredups，表示忽略重复的输入（和上一次的输入比较）
	export HISTCONTROL='erasedups'
	#下面这段代码用于把常用目录保存为一个字符串，通过字符串快速进入常用目录
	# 用法：
	# 1.进入目录，执行 s dir_name（一个能记得住的字符串）
	# 2.怎样进入刚才设置的目录，执行 g dir_name 刚刚设置的字符串
	# 类似于给常用的目录设置一个别名，不用在使用长长的绝对路径了
	#------------------------------------------------------------------------
	# bookemark -----------------
	# bookmark USAGE :
	# s bookmarkname - saves the curr dir as bookmarkname
	# g bookmarkname - jumps to the that bookmark
	# g b[TAB] - tab completion is available
	# l - list all bookmarks
	# save current directory to bookmarks
	touch ~/.sdirs
	function s {
	cat ~/.sdirs | grep -v "export DIR_$1=" > ~/.sdirs1
	mv ~/.sdirs1 ~/.sdirs
	echo "export DIR_$1=$PWD" >> ~/.sdirs
}
# jump to bookmark
function g {
source ~/.sdirs
cd $(eval $(echo echo $(echo \$DIR_$1)))
}
# list bookmarks with dirname
function l {
source ~/.sdirs
env | grep "^DIR_" | cut -c5- | grep "^.*="
}
# list bookmarks without dirname
function _l {
source ~/.sdirs
env | grep "^DIR_" | cut -c5- | grep "^.*=" | cut -f1 -d "="
}
# completion command for g
function _gcomp {
local curw
COMPREPLY=()
curw=${COMP_WORDS[COMP_CWORD]}
COMPREPLY=($(compgen -W '`_l`' -- $curw))
return 0
}
# bind completion command for g to _gcomp
complete -F _gcomp g
#------------------------------------------------------------------------
## 设置别名，让命令执行更便捷
# 这一部分最好放在最后，主要是因为前面的脚本可能会用到下面的命令
# readlink 命令，我常用于读取一个文件的绝对路径，复制文件的时候经常用到
alias readlink="readlink -f"
# 使grep 出来的结果中，关键字高亮展示
alias grep="grep --color "
alias fgrep="fgrep --color"
# 我喜欢用lsof来侦测本机的网络端口，如果不想把/usr/sbin放置到PATH中，可以设置下面的别名
alias lsof="/usr/sbin/lsof"
# 下面的设置用于阻止less退出后刷新屏幕
alias less="less -X"
## ls 相关设置
alias l='ls'
# 长格式展示
alias ll='ls -l'
# 展示隐藏文件
alias la='ls -a'
# 颜色和文件类型
alias lf='ls -CF'
# 按文件扩展名展示
alias lx='ls -lXB'
# 按照文件大小排序展示
alias lk='ls -lSr'
# 按时间排序展示
alias lt='ls -ltr'

#arlier scrpts
alias ssh0='ssh -Y zhaor@lxslc6.ihep.ac.cn'
alias cd0='cd /junofs/users/zhaor/junoinstall'

#PS1 set
PS1="\[\033[0;37m\]\342\224\214\342\224\200\$([[ \$? != 0 ]] && echo \"[\[\033[0;31m\]\342\234\227\[\033[0;37m\]]\342\224\200\")
[$(if [[ ${EUID} == 0 ]]; then echo '\[\033[0;31m\]\h'; else echo '\[\033[0;33m\]\u\[\033[0;37m\]@\[\033[0;96m\]\h'; fi)\[\033[0;37m\]]\342\224\200[\[\033[0;32m\]\w\[\033[0;37m\]]\[\e[1;37m arlier to find something out! \]\n\[\033[0;37m\]\342\224\224\342\224\200\342\224\200\342\225\274 \[\033[0m\]"
#end$

