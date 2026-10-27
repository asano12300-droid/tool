#!/bin/bash

user=$(whoami)

menu () {
	echo "1.gitコマンドのセットアップ"
	echo "2.japaneseのセットアップ"
}

github () {
	if [ ! -e /home/$user/.config ]; then
		echo -n "あなたのgithubのユーザ名: "
		read name

		echo -n "あなたのgithubアカウントのメールアドレス: "
		read email

		git config --global user.name $name
		git config --global user.name $email
	else
		echo -n "githubのユーザー名: "
		read name
	fi

	echo -n "こちらは、作業フォルダですか,[Y/N]: "
	read qa

	if [[ "$qa" == "y" || "$qa" == "Y" ]]; then
		git init

		echo -n "どのレポジトリーを使用しますか?: "
		read repo

		echo -n "なんの名前にしますか?: "
		read r
		git remote add $r https://github.com/$name/$repo.git
		echo -n "`git push`の際にパスワードを求められないようにする? [Y/N]: "
		read qb
		if [[ "$qb" == "y" || "$qa" == "Y" ]]; then
			echo -n "パスワード: "
			read password
			git remote set-url $r https://$password@github.com/$name/$repo.git
			git branch -M main
		elif [[ "$qb" == "n" || "$qb" == "N" ]]; then
			git branch -M main
		fi
	elif [[ "$qa" == "n" || "$qa" == "N" ]]; then
		echo "作業フォルダに入ってから、再度お願いします。"
	else
		echo "再度お願いします"
	fi
}

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
	sudo apt install x11-xkb-utils, fcti5-mozc, fonts-noto-cjk
	wait
	setxkbmap -layout jp
	echo 'setxkbmap -layout jp &> /dev/null' >> /home/$user/.bashrc
	echo 'export GTK_IM_MODULE=fcitx5' >> /home/$user/.bashrc
	echo 'export QT_IM_MODULE=fcitx5' >> /home/$user/.bashrc
	echo 'export XMODIFIERS=@im=fcitx5' >> /home/$user/.bashrc
	echo 'export DefaultIMModule=fcitx5' >> /home/$user/.bashrc
	echo 'export INPUT_METHOD=fcitx5' >> /home/$user/.bashrc
	wait
}

menu
echo -n "何をしたいですか? [1・2]: "
read select

if [[ "$select" == "github" ]]; then
	github
elif [[ "$select" == "japanese" ]]; then
	japanese
fi
if [ ! -e /home/$user/.config ]; then
	echo -n "あなたのgithubのユーザ名: "
	read name

	echo -n "あなたのgithubアカウントのメールアドレス: "
	read email

	git config --global user.name $name
	git config --global user.name $email
else
	echo -n "githubのユーザー名: "
	read name
fi

echo -n "こちらは、作業フォルダですか,[Y/N]: "
read qa

if [[ "$qa" == "y" || "$qa" == "Y" ]]; then
	git init

	echo -n "どのレポジトリーを使用しますか?: "
	read repo

	echo -n "なんの名前にしますか?: "
	read r
	git remote add $r https://github.com/$name/$repo.git
	echo -n "`git push`の際にパスワードを求められないようにする? [Y/N]: "
	read qb
	if [[ "$qb" == "y" || "$qa" == "Y" ]]; then
		echo -n "パスワード: "
		read password
		git remote set-url $r https://$password@github.com/$name/$repo.git
		git branch -M main
	elif [[ "$qb" == "n" || "$qb" == "N" ]]; then
		git branch -M main
	fi
elif [[ "$qa" == "n" || "$qa" == "N" ]]; then
	echo "作業フォルダに入ってから、再度お願いします。"
else
	echo "再度お願いします"
fi
