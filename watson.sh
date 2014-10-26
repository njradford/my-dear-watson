#!/bin/sh


chroot () {
	#Chroot specific functions that are fun from within precise when this script is called with an argument of "c"
	#------------------------------------------------------------------
	apt-get install -y python-software-properties
	add-apt-repository -y ppa:elementary-os/stable
	apt-get update
	apt-get install -y elementary-desktop
	apt-get install -y gtk2-engines-pixbuf
	
	cd /usr/bin 
	cp startxfce4 startelementary
	sed -i 's/\/etc\/xdg\/xfce4\/xinitrc $CLIENTRC $SERVERRC/\/usr\/bin\/xinit_pantheon/' startelementary
	echo '#!/bin/sh
	/usr/sbin/lightdm-session "gnome-session --session=pantheon"' >> xinit_pantheon 
	chmod +x xinit_pantheon 
	sudo chown root:root xinit_pantheon
}

chrome () {
	sh -e crouton -t xfce,keyboard,extension
	sudo enter-chroot -u root sh ~/Downloads/watson.sh c
	cd /usr/local/bin
	sudo cp startxfce4 startelementary
	sudo sed -i 's/startxfce4/startelementary/' startelementary
	sudo startelementary
    echo WELCOME TO PANTHEON
}



if [ "$1" = "c" ]
then chroot
else chrome
fi
