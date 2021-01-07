# linuxtips
### Linux Tech Tips

In this repository you will find all kinds of useful scripts, tips etc.

This commands and scripts are written for Arch/Manjaro with KDE flavour. Written as simply as possible so even total begginer can use it. 





### HP printer setup

```
sudo pacman -Sy manjaro-printer
sudo pacman -Sy hplip
sudo systemctl enable --now org.cups.cupsd.service
```
NOTE: After Kernel update you might need to reconfigure driver in HP Device Menager.

### Disable title bar Chromium
Use system title bar and borders = False

### Disable title bar Firefox
Customize > Title bar = False

### Disable title bar VS Code
Settings > Preferences > Window: Title Bar Style = Custom

### VS Code Marketplace.
In Arch and Manjaro default version of VS Code is OSS Code which is just an open source version of regular VSCode. I belive the only differences are Telemetry data and Marketplace.
Since Open Source version of VSCode marketplace is in very much alpha phase is best to use MS version. 
In order to do that you have to install visual-studio-code-bin from AUR. (Microsoft-branded release). Note that this might compromise privacy.

Technically, one could also edit the product.json as shown below, but that would not comply with the Microsoft Marketplace Terms of Use. Additionally, the changes would be overwritten during package update. 

Edit `/usr/lib/code/product.json`:

Replace:
```
  "extensionsGallery": {
    "serviceUrl": "https://open-vsx.org/vscode/gallery",
    "itemUrl": "https://open-vsx.org/vscode/item"
  },
```
with:
```
  "extensionsGallery": {
    "serviceUrl": "https://marketplace.visualstudio.com/_apis/public/gallery",
    "cacheUrl": "https://vscode.blob.core.windows.net/gallery/index",
    "itemUrl": "https://marketplace.visualstudio.com/items"
  },
```
https://wiki.archlinux.org/index.php/Visual_Studio_Code


### KDE, turn on screen saver on lock after few seconds (far from perfect, TODO make script that will change dpms settings):
Serach Notifications > Applications: Configure > Search Screen Saver > Configure Events > run command true > /bin/sleep 15; /usr/bin/xset dpms force off
xset dpms 12 22 60    #Time is given in seconds

### AUR in CLI. YAY:

install base:
```
sudo pacman -S base-devel
```
install yay:
```
https://github.com/Jguer/yay 
pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -r yay
```
Usage example:
```
yay vscode
```

### Sync time in dual boot mode with Windows:
```
timedatectl set-local-rtc 1 --adjust-system-clock
```

### Basic net tools:
```
sudo pacman -Sy net-tools
sudo pacman -Sy traceroute
```

### DroidCam:

install droidcam form website
run script install_sound

easiest way to install dependencies:
```
yay droidcam
```
(do not uninstall dependencies)
```
droidcam
```
(find hw info eg hw:2,1,1)
(run on as second instance)
```
pacmd load-module module-alsa-source device=hw:2,1,0 
```
**Module has to be loaded while droidcam is running**

### Python:

venv activation: `source venvName/bin/activate`

### Bash:

#### Useful aliases:
Use in .bash_rc in home dir.

```
alias ytbest="youtube-dl -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio' --merge-output-format mp4"
alias cppnew="/home/felix/scripts/createcpp.sh"
```

### Network:

Network usage monitor:

vnstat

```
pacman -Sy vnstat
systemctl start vnstat.service 
systemctl enable vnstat.service
```

### FFmpeg:

Converting mp4 file into HLS playlist:

`ffmpeg -i file.mp4 -profile:v baseline -level 3.0 -s 1920x1080 -start_number 0 -hls_time 10 -hls_list_size 0 -f hls file.m3u8`
<hr>
- -i - after this flag specify input file
- profile:v - indicate that input file is a video file.
- hls_time - set segment length in seconds. Default: 2
- hls_list_size - set the maximum number of playlist entries. 0 indicates no limit.

### GCC

Compiling C++ file with threads:

`gcc -pthread -o excutableName filename.cpp -lstdc++`

- -pthread - this option adds multithreading support
- -lstdc++ - this option has to be used in order to compile C++ file. Without it compile will assume it's written in C.


### Screen:

`screen` - open new screen sesion.

ctrl + a - open command menu (it doesnt show anything on screen)

ctrl + d - detach session

To restore session:

`screen -dr`

List of all sessions:

`screen -ls`

### KDE Specific:

If executables open in Kate you can change this settings following this steps:

`vim ~/.config/kiorc`

change:
```
[Executable scripts]
behaviourOnLaunch=open
```
to:
```
[Executable scripts]
behaviourOnLaunch=execute
```
