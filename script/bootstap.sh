#!/bin/bash

# git clone https://github.com/jrob00/dotfiles.git && cd dotfiles && ./bootstrap.sh

sudo -v

BASEDIR=$(dirname $0)
#echo $BASEDIR
cd "$BASEDIR"


# update our repo
git pull


# step one
# copy system/ files: bash_profile, bash_prompt, inputrc to ~/"."filename
# append function, path to ~/.bash_profile
# copy ssh-config to ~/.ssh/config


sudo cp -f ../.bash_profile ~/
sudo cp -f ../.bash_prompt ~/
sudo cp -f ../.inputrc ~/

sudo cp -f ../.gitconfig ~/
sudo cp -f ../.gitignore ~/
sudo cp -f ../.gitattributes ~/

exit



# step two
# append all .aliases to ~/.bash_profile

# step three
# copy files in /bin to ~/.bin

# step four
# append all .ssh-config to ~/.ssh/config

# copy .terminal files to ?



function doIt() {
	rsync --exclude ".git/" --exclude ".DS_Store" --exclude "bootstrap.sh" --exclude "README.md" -av . ~
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt
	fi
fi

unset doIt
source ~/.bash_profile
