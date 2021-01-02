# linuxtips
### Linux Tech Tips

In this repository you will find all kinds of useful scripts, tips etc.

This scripts are mostly for Manjaro and beginner users.





### HP printer setup

```
sudo pacman -Sy manjaro-printer
sudo pacman -Sy hplip
sudo systemctl enable --now org.cups.cupsd.service
```

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

```
alias ytbest="youtube-dl -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio' --merge-output-format mp4"
```

### Network:

Network usage monitor:

vnstat

```
pacman -Sy vnstat
systemctl start vnstat.service 
systemctl enable vnstat.service
```
