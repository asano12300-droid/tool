#!/bin/bash

locale () {
	sudo apt install locales -y
	wait

	sudo sed -i -E 's/# (ja_JP.UTF-8)/\1/' /etc/locale.gen
	wait

	sudo locale-gen
	sudo update-locale LANG=ja_JP.UTF-8
	echo 'export LANG=ja_JP.UTF-8' >> /home/$(whoami)/.bashrc
}

letter () {
	sudo apt install x11-xkb-utils
	setxkbmap -layout jp
	echo 'setxkbmap -layout jp &> /dev/null' >> /home/$(whoami)/.bashrc
	sudo apt install fcitx5-mozc
	wait

	im-config -n fcitx5
	cat <<EOF >> /home/$(whoami)/.bashrc
export GTK_IM_MODULE=fcitx5
export QT_IM_MODULE=fcitx5
export XMODIFIERS=@im=fcitx5
export DefaultIMModule=fcitx5
export INPUT_METHOD=fcitx5
EOF

	sudo apt install fonts-noto-cjk
	wait
}

main () {
	echo 'To Do List'
	echo 'update locale 1/2'
	locale
	wait
	echo 'japanese latter 2/2'
	letter
	wait
	echo 'Finish'
}

if [ -z "$1" ]; then
	echo -n "実行しますか? [Y/N]"
	read yn
	if [[ "$yn" == "Y" || "$yn" == "y" ]]; then
		main
	elif [[ "$yn" == "N" || "$yn" == "n" ]]; then
		continue
	else
		echo '無効な操作です。やりなおしてください。'
	fi
elif [[ "$1" == "-y" || "$1" == "-Y" ]]; then
	main
elif [[ "$1" == "-n" || "$1" == "-N" ]]; then
	continue
else
	echo '無効な操作です。やり直してください。'
fi

