# Dotfile deployment

alias reload='source ~/.bash_profile'
alias installclover='bash < <(curl -fsSkL https://raw.github.com/gist/050df7646f8fa704d753)'
alias updaterepos='~/Projects/Clover/Server-Assets/Local\ Files/bin/update-all-repositories.sh'
alias updateshell='(cd ~/Projects/Personal/dotfiles/ && git pull && sudo cp -f .bash_profile ~/); reload'
alias updatessh='(cd ~/Projects/Personal/dotfiles/ && git pull && cp -f .ssh/config ~/.ssh/); (cd ~/Projects/Clover/Server-Assets/ && git pull && cat Local\ Files/ssh.config >> ~/.ssh/config)'




# Easier navigation: .., ..., ...., ....., and -

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias -- -="cd -"

alias h='cd ~'
alias home='cd ~'
alias www='cd /var/www'
alias log='cd /var/www/log'
alias html='cd /var/www/html'
alias apache='cd /etc/httpd/conf.d'
alias dotfiles='cd ~/Projects/Personal/dotfiles'

alias dropbox="cd ~/Dropbox"
alias projects="cd ~/Projects"

alias mini="open vnc://DesignAndDevelopment@192.168.1.91"
alias next='ssh mini "/usr/bin/osascript -e \"tell app \\\"Rdio\\\" to next track\""'
alias play='ssh mini "/usr/bin/osascript /Users/DesignAndDevelopment/Effects/pausemusic.scpt"'
alias pause='ssh mini "/usr/bin/osascript /Users/DesignAndDevelopment/Effects/pausemusic.scpt"'
#alias rickroll='ssh mini "/usr/bin/osascript -e \"tell app \\\"Rdio\\\" to play source \\\"t2910908\\\"\""'
alias tint='curl --connect-timeout 10 --max-time 10 http://tint.cloversites.com/api/create_random_gradient >/dev/null 2>&1'

# Application shortcuts

alias f='open -a Finder '
alias fh='open -a Finder .'

# cd to the path of the front Finder window
cdf() {
    target=`osascript -e 'tell application "Finder" to if (count of Finder windows) > 0 then get POSIX path of (target of front Finder window as text)'`
    if [ "$target" != "" ]; then
        cd "$target"; pwd
    else
        echo 'No Finder window found' >&2
    fi
}

alias photoshop="open -a '/Applications/Adobe Photoshop CS6/Adobe Photoshop CS6.app'"
alias preview="open -a '/Applications/Preview.app'"
alias xcode="open -a '/Developer/Applications/Xcode.app'"
alias filemerge="open -a '/Developer/Applications/Utilities/FileMerge.app'"
alias safari="open -a safari"
alias firefox="open -a firefox"
alias chrome="open -a google\ chrome\ beta"
alias canary="open -a google\ chrome\ canary"
alias tower="open -a '/Applications/Tower.app'"

export EDITOR='subl -w'

if [ -s /usr/bin/firefox ] ; then
  unalias firefox
fi




# File manipulation

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'




# Detect which `ls` flavor is in use

if ls --color > /dev/null 2>&1; then # GNU `ls`
	colorflag="--color"
else # OS X `ls`
	colorflag="-G"
fi


# List all files colorized in long format
alias ll="ls -l ${colorflag}"

# List all files colorized in long format, including dot files
alias la="ls -la ${colorflag}"

# List only directories
alias lsd='ls -l ${colorflag} | grep "^d"'

# Always use color output for `ls`
alias ls="command ls ${colorflag}"
export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'




# URL-encode strings
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'


# Ring the terminal bell, and put a badge on Terminal.app's Dock icon
# (useful when executing time-consuming commands)
alias badge="tput bel"




### functions

# via mamp
http() {
    if [[ $@ == "start" ]]; then
        command sudo /Applications/MAMP/Library/bin/apachectl start;
    elif [[ $@ == "restart" ]]; then
        command sudo /Applications/MAMP/Library/bin/apachectl restart;
    elif [[ $@ == "stop" ]]; then
        command sudo /Applications/MAMP/Library/bin/apachectl stop;
    fi
}

#mysqld() {
#    if [[ $@ == "start" ]]; then
#            command sudo /Applications/MAMP/Library/bin/mysqld_safe --port=3306 --socket=/Applications/MAMP/tmp/mysql/mysql.sock --lower_case_table_names=0 --pid-file=/Applications/MAMP/tmp/mysql/mysql.pid --log-error=/Applications/MAMP/logs/mysql_error_log;
#    elif [[ $@ == "stop" ]]; then
#            command sudo /Applications/MAMP/Library/bin/mysqladmin -u root -proot --socket=/Applications/MAMP/tmp/mysql/mysql.sock shutdown;
#    fi
#}

# via brew
mysql() {
    if [[ $@ == "start" ]]; then
        command mysql.server start;
    elif [[ $@ == "stop" ]]; then
        command mysql.server stop;
    elif [[ $@ == "load" ]]; then
        command launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist    
    elif [[ $@ == "unload" ]]; then
        command launchctl unload -w ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist
    fi
}


down4me() {
    # checks whether a website is down for you, or everybody
    # example '$ down4me http://www.google.com'
    curl -s "http://www.downforeveryoneorjustme.com/$1" | sed '/just you/!d;s/<[^>]*>//g'
}

pmdown() {
    # preview markdown file in a browser
    # example '$ pmdown README.md'
    if command -v markdown &>/dev/null
    then
      markdown $1 | chrome
    else
      echo "You don't have a markdown command installed!"
    fi
}

# List hosts defined in ssh config
showhosts() {
    awk '$1 ~ /Host$/ { print $2 }' ~/.ssh/config
}


# sublime text alias
function project_aware_subl() {
    #$(ls *.sublime-project ~/Dropbox/Local\ Dev/Sublime\ Projects/${current_directory}.sublime-project)
    
    #project_file=$(ls *.sublime-project ~/Dropbox/Local\ Dev/Sublime\ Projects/${current_directory}.sublime-project 2>/dev/null | head -n 1)
    #subl ${*:-${project_file:-.}}
    
    current_directory=${PWD##*/}
    #echo ${current_directory}

    result=$(ls *.sublime-project 2>/dev/null | head -n 1)
    #echo "result1:"${result}

    if [ -z $result ]; then
        result=$(ls ~/Documents/Sublime/${current_directory}.sublime-project 2>/dev/null | head -n 1)
        result=$(printf '%q' "$result")
        #echo "result2:"${result}
        
        if [[ $result == "''" ]]; then
            echo "project doesn't exist.."
            unset result
        else
            echo "opening project.."
        fi
    else
        echo "opening project.."
    fi
    
    #project_file=$(ls *.sublime-project ~/Dropbox/Local\ Dev/Sublime\ Projects/${current_directory}.sublime-project 2>/dev/null | head -n 1)
    
    #to_run=${*:-${result:-.}}
    #echo "to_run:"${to_run}
    
    subl ${*:-${result:-.}}
    
}
alias subl="project_aware_subl"


### rvm

export PATH=$PATH:$HOME/.rvm/bin
# This loads RVM into a shell session.
[[ -s "/Users/jason/.rvm/scripts/rvm" ]] && source "/Users/jason/.rvm/scripts/rvm"




### path

export PATH=/usr/local/bin:$PATH
export PATH=$PATH:/usr/local/git/bin
export PATH=$PATH:/usr/local/lib/node_modules
export PATH=$PATH:/usr/local/sbin

#export PATH=$PATH:/Applications/MAMP/Library/bin




### clover aliases

# top level
alias cs2='cd ~/Projects/Clover/CS2'
alias CS2='cd ~/Projects/Clover/CS2'
alias cs3='cd ~/Projects/Clover/CS3'
alias CS3='cd ~/Projects/Clover/CS3'
alias Donations='cd ~/Projects/Clover/Donations'
alias donations='cd ~/Projects/Clover/Donations'

# main
alias server-assets='cd ~/Projects/Clover/Server-Assets'
alias Server-Assets='cd ~/Projects/Clover/Server-Assets'
alias hubot='cd ~/Projects/Clover/hubot'
alias Hubot='cd ~/Projects/Clover/hubot'
alias cloverachiever.com='cd ~/Projects/Clover/CloverAchiever.com'
alias CloverAchiever.com='cd ~/Projects/Clover/CloverAchiever.com'
alias speakingofclover.com='cd ~/Projects/Clover/SpeakingOfClover.com'
alias SpeakingOfClover.com='cd ~/Projects/Clover/SpeakingOfClover.com'

# donations
alias donation-emailer='cd ~/Projects/Clover/Donations/Donation-Emailer'
alias Donation-Emailer='cd ~/Projects/Clover/Donations/Donation-Emailer'
alias donation-center='cd ~/Projects/Clover/Donations/Donation-Center'
alias Donation-Center='cd ~/Projects/Clover/Donations/Donation-Center'
alias cloverdonations.com='cd ~/Projects/Clover/Donations/CloverDonations.com'
alias CloverDonations.com='cd ~/Projects/Clover/Donations/CloverDonations.com'
alias donation-assets='cd ~/Projects/Clover/Donations/Donation-Assets'
alias Donation-Assets='cd ~/Projects/Clover/Donations/Donation-Assets'
alias donation-cron='cd ~/Projects/Clover/Donations/Donation-Cron'
alias Donation-Cron='cd ~/Projects/Clover/Donations/Donation-Cron'
alias the-bakery='cd ~/Projects/Clover/Donations/The-Bakery'
alias The-Bakery='cd ~/Projects/Clover/Donations/The-Bakery'

# CS2
alias site-assets='cd ~/Projects/Clover/CS2/Site-Assets'
alias Site-Assets='cd ~/Projects/Clover/CS2/Site-Assets'
alias site-flash='cd ~/Projects/Clover/CS2/Site-Flash'
alias Site-Flash='cd ~/Projects/Clover/CS2/Site-Flash'
alias site-billing='cd ~/Projects/Clover/CS2/Site-Billing'
alias Site-Billing='cd ~/Projects/Clover/CS2/Site-Billing'
alias cloverprojects.com='cd ~/Projects/Clover/CS2/CloverProjects.com'
alias CloverProjects.com='cd ~/Projects/Clover/CS2/CloverProjects.com'
alias photosynthesis='cd ~/Projects/Clover/CS2/Photosynthesis'
alias Photosynthesis='cd ~/Projects/Clover/CS2/Photosynthesis'
alias shared-photosynthesis-billing='cd ~/Projects/Clover/CS2/Shared-Photosynthesis-Billing'
alias Shared-Photosynthesis-Billing='cd ~/Projects/Clover/CS2/Shared-Photosynthesis-Billing'
#alias site-cornerstone='cd ~/Projects/Clover/CS2/Site-Cornerstone'
#alias Site-Cornerstone='cd ~/Projects/Clover/CS2/Site-Cornerstone'
#alias splash.clo.do='cd ~/Projects/Clover/CS2/splash.clo.do'

# CS3
alias api='cd ~/Projects/Clover/CS3/API'
alias API='cd ~/Projects/Clover/CS3/API'
alias sites='cd ~/Projects/Clover/CS3/Sites'
alias Sites='cd ~/Projects/Clover/CS3/Sites'
alias greenhouse='cd ~/Projects/Clover/CS3/Greenhouse'
alias Greenhouse='cd ~/Projects/Clover/CS3/Greenhouse'
alias admin='cd ~/Projects/Clover/CS3/Admin'
alias Admin='cd ~/Projects/Clover/CS3/Admin'
alias login='cd ~/Projects/Clover/CS3/Login'
alias Login='cd ~/Projects/Clover/CS3/Login'
alias accounts='cd ~/Projects/Clover/CS3/Accounts'
alias Accounts='cd ~/Projects/Clover/CS3/Accounts'



### git aliases

alias g="git"



### rails aliases
alias rakereset="rake db:reset;rake db:drop db:create db:migrate db:seed;"


### network aliases

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en1"
alias ips="ifconfig -a | grep -o 'inet6\? \(\([0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+\)\|[a-fA-F0-9:]\+\)' | sed -e 's/inet6* //'"


# Enhanced WHOIS lookups
alias whois="whois -h whois-servers.net"


# Flush Directory Service cache
alias flush="dscacheutil -flushcache && killall -HUP mDNSResponder"
#sudo dscacheutil -flushcache

# View HTTP traffic
alias sniff="sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""





### osx aliases

# Clean up LaunchServices to remove duplicates in the “Open With” menu
alias lscleanup="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder"


# Show/hide hidden files in Finder
alias show="defaults write com.apple.Finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.Finder AppleShowAllFiles -bool false && killall Finder"




### bash completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi


