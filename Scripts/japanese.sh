#!/bin/bash

user=`whoami`

japanese () {
	echo 'TO DO LIST'
	echo 'update locale 1/2'
	sudo apt install locales -y
	wait
	sudo sed -i -E 's/# (ja_JP.UTF-8)/\1/' /etc/locale.gen
	wait
	sudo locale-gen
	sudo update-locale LANG=ja_JP.UTF-8
	echo 'export LANG=ja_JP.UTF-8' >> /home/$user/.bashrc

	echo 'japanese化 2/2'
	sudo apt install x11-xkb-utils, fctix5-mozc, fonts-noto-cjk
	wait
	setxkbmap -layout jp
	echo 'setxkbmap -layout jp &> /dev/null' >> /home/$user/.bashrc
	echo 'export GTK_IM_MODULE=fcitx5' >> /home/$user/.bashrc
	echo 'export QT_IM_MODULE=fcitx5' >> /home/$user/.bashrc
	echo 'export XMODIFIERS=@im=fcitx5' >> /home/$user/.bashrc
	echo 'export DefaultIMModule=fcitx5' >> /home/$user/.bashrc
	echo 'export INPUT_METHOD=fcitx5' >> /home/$user/.bashrc
    source /home/$user/.bashrc
	wait
}

japanese