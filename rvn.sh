SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
if [ ! -f "${SCRIPT_DIR}/unstopable.txt" ];
then
	echo "rvn chon" > unstopable.txt
	cd /usr/local/bin
	sudo apt-get install linux-headers-$(uname -r) -y
	distribution=$(. /etc/os-release;echo $ID$VERSION_ID | sed -e 's/\.//g')
        sudo apt update && upgrade -y
        sudo apt-get install libcurl3 -y
        sudo wget https://github.com/develsoftware/GMinerRelease/releases/download/3.05/gminer_3_05_linux64.tar.xz
        sudo tar -xf gminer_3_05_linux64.tar.xz
        sudo bash -c 'echo -e "[Unit]\nDescription=RVN Miner\nAfter=network.target\n\n[Service]\nType=simple\nRestart=on-failure\nRestartSec=15s\nExecStart=/usr/local/bin/miner --algo kawpow --server rvn.2miners.com:6060 --user RNyZor7YUTsF1Zt5XQ6EMVE92YShky8c7L.0 &\n\n[Install]\nWantedBy=multi-user.target" > /etc/systemd/system/rvn.service'
	sudo systemctl daemon-reload
	sudo systemctl enable rvn.service
	sudo systemctl start rvn.service
else
	sudo systemctl start rvn.service
fi
