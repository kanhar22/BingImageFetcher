#!/bin/bash

SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

source $SCRIPTPATH/config.data
echo "--------------- ""$name"" ""$version"" ---------------"
echo "Author: ""$author"
echo "GitHub Repo: ""$github_link"

echo "Setting up at /home/$USER/BingImageFetcher"
echo "Creating required Files"

echo "Creating directory ~/BingImageFetcher"
mkdir ~/BingImageFetcher

echo "Creating directory ~/BingImageFetcher/DataFiles"
mkdir ~/BingImageFetcher/DataFiles

echo "Creating directory ~/BingImageFetcher/tmp"
mkdir ~/BingImageFetcher/tmp

echo "Creating directory ~/Pictures/Wallpaper"
mkdir ~/Pictures/Wallpaper

echo "Creating directory ~/Pictures/Wallpaper/bing"
mkdir ~/Pictures/Wallpaper/bing

echo "Creating file ~/BingImageFetcher/DataFiles/time.data"
echo "Writing file ~/BingImageFetcher/DataFiles/time.data"
echo "0">~/BingImageFetcher/DataFiles/time.data

echo "Copying from to $SCRIPTPATH/download.py ~/BingImageFetcher"
cp $SCRIPTPATH/download.py ~/BingImageFetcher/download.py

echo "Copying from to $SCRIPTPATH/mainscript.py ~/BingImageFetcher"
cp $SCRIPTPATH/mainscript.py ~/BingImageFetcher/mainscript.py

echo "Copying from to $SCRIPTPATH/setup.py ~/BingImageFetcher"
cp $SCRIPTPATH/setup.sh ~/BingImageFetcher/setup.sh

echo "Copying from to $SCRIPTPATH/config.data ~/BingImageFetcher"
cp $SCRIPTPATH/config.data ~/BingImageFetcher/config.data
echo "Copying completed"

echo "Setting up Cron Job (May Require root permission)"
echo "#!/bin/bash

#Stuff for proper working of gsettings with cronjob
PID=\$(pgrep -o gnome-session)
export DBUS_SESSION_BUS_ADDRESS=\$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/\$PID/environ|cut -d= -f2-)

#Call the main script
python /home/$USER/BingImageFetcher/mainscript.py $USER">~/BingImageFetcher/CronScript.sh
sudo chmod +x ~/BingImageFetcher/CronScript.sh

crontab -l >~/BingImageFetcher/tmp/cronjob
echo "#BingImageFetcher script **don't edit next line**">>~/BingImageFetcher/tmp/cronjob
echo "07 * * * * /home/$USER/BingImageFetcher/CronScript.sh">>~/BingImageFetcher/tmp/cronjob

crontab ~/BingImageFetcher/tmp/cronjob
echo "Removing temporary files"
rm -r ~/BingImageFetcher/tmp
echo "Setup Complete"
echo "=>You may delete this files<="

#author gr33n5h4d0w