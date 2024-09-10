# linuxtips
## Linux Tech Tips - subject name to change
[Not affiliated with Linus Tech Tips]

In this repository you will find all kinds of useful scripts, tips etc.

This commands and scripts are written for Arch/Manjaro with KDE flavour. Written as simply as possible so even total beginner can use it. 


## Content Table:

1. [HP printer setup](#hp-printer-setup)
2. [Disable title bar Chromium](#disable-title-bar-chromium)
3. [Disable title bar Firefox](#disable-title-bar-firefox)
4. [Disable title bar VS Code](#disable-title-bar-vs-code)
5. [VS Code Marketplace](#vs-code-marketplace)
6. [KDE, turn on screen saver on lock after few seconds](#kde-turn-on-screen-saver-on-lock-after-few-seconds)
7. [AUR in CLI. YAY](#aur-in-cli-yay)
8. [Sync time in dual boot mode with Windows](#sync-time-in-dual-boot-mode-with-windows)
9. [Network](#network)
10. [DroidCam](#droidcam)
11. [Python](#python)
12. [Bash](#bash)
13. [FFmpeg](#ffmpeg)
14. [GCC](#gcc)
15. [Screen](#screen)
16. [KDE Specific](#kde-specific)
17. [youtube-dl](#youtube-dl)
18. [SSH and tunneling](#ssh-and-tunneling)
19. [KVM/QEMU](#kvmqemu)
20. [Stream audio from PulseAudio into Android device](#stream-audio-from-pulseaudio-into-android-device)
21. [Stream audio from PulseAudio into another Linux device](#stream-audio-from-pulseaudio-into-another-linux-device)
22. [Minecraft Sever](#minecraft-server)
23. [ZSH](#zsh)



## HP printer setup

```
$ sudo pacman -Sy hplip
$ sudo systemctl enable --now org.cups.cupsd.service
```
https://aur.archlinux.org/packages/foo2zjs-nightly/ - select foo2xqx as a driver

## Disable title bar Chromium
Use system title bar and borders = False

## Disable title bar Firefox
Customize > Title bar = False

## Disable title bar VS Code
Settings > Preferences > Window: Title Bar Style = Custom

## VS Code Marketplace.

In Arch and Manjaro default version of vscode is code-oss which is just an FOSS version of regular Vscode.\
Most notable differences are Telemetry data and Marketplace but in my experience it works better than code-oss.\
~~Since FOSS version of VSCode marketplace is in very much alpha phase is best to use MS version.~~\
It's been a few years and open-vsx has improved quite a lot! For me (and I believe most other people) open-vsx provides
all extensions that are essential.\
One caveat is Python however. Microsoft provides pylance, very advanced language server for Python which honestly 
has no competition and obviously works only with Microsoft's version of vscode. They recommend using pyright which
is core component of pylance but just like stock android it's basically unusable. Actually it's even worse. 
pyright main developer is hostile towards people reporting issues.\
While there are hacks to make pylance working with code-oss currently the best way is to achieve similar result without having
to relay on Microsoft is to just install vscodium and basedpyright extension. (For some reason basedpyright doesn't work for me 
on code-oss, it might work for you but it doesn't for me)\
Worth noting is that basedpyright is a fork of pyright that implements features of pylance and fixes issues that pyright refuses
to fix.\
The only downside for me is that defaults are way to strict (Reports unused imports as errors for example), this is super easy fix though:
just add this to your settings:

```jsonc
{
    "editor.inlayHints.enabled": "off",
    "basedpyright.analysis.typeCheckingMode": "standard",
    "basedpyright.analysis.diagnosticSeverityOverrides": {
        "reportIncompatibleMethodOverride": false,
        "reportPrivateImportUsage": false,
        "reportAttributeAccessIssue": false,
        "reportArgumentType": false,
        "reportAssignmentType": false,
        "reportIndexIssue": false
    }
}
```



If you don't want to deal with all that you can just install `visual-studio-code-bin` from AUR. (Microsoft-branded release). 
Note that this might compromise privacy.

Technically, one could also edit the product.json as shown below, but that would not comply with the Microsoft Marketplace Terms of Use. 
Additionally, the changes would be overwritten during package update. 

Edit `/usr/lib/code/product.json`:

Replace:
```json
  "extensionsGallery": {
    "serviceUrl": "https://open-vsx.org/vscode/gallery",
    "itemUrl": "https://open-vsx.org/vscode/item"
  },
```
with:
```json
  "extensionsGallery": {
    "serviceUrl": "https://marketplace.visualstudio.com/_apis/public/gallery",
    "cacheUrl": "https://vscode.blob.core.windows.net/gallery/index",
    "itemUrl": "https://marketplace.visualstudio.com/items"
  },
```
https://wiki.archlinux.org/index.php/Visual_Studio_Code

The only problem is that this action needs to be performed every time Code OSS is updated. 

### **UPDATE:**
[This package](https://aur.archlinux.org/packages/code-marketplace/) automatically makes sure that config stay the same.\
This package basically installs a hook that will patch `/usr/lib/code/product.json` to use vscode marketplace every time community/code is updated.


## KDE, turn on screen saver on lock after few seconds:
~~Serach Notifications > Applications: Configure > Search Screen Saver > Configure Events > run command true > add full path to the scripts: timeout_lock.sh, timeout_unlock.sh~~
(This is no longer needed as KDE implements this feature now)

## AUR in CLI. YAY:

For Manjaro:
```bash
sudo pacman -S --needed git base-devel
sudo pacman -Sy yay
```

For Arch:

```bash
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay
```

Usage example:
```
yay vscode
```

## Sync time in dual boot mode with Windows:
```
timedatectl set-local-rtc 1 --adjust-system-clock
```
## Network:

Basic net tools:
```
sudo pacman -Sy net-tools traceroute
```

Network usage monitor:

vnstat

```
pacman -Sy vnstat
systemctl start vnstat.service 
systemctl enable vnstat.service
```

## DroidCam:

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

## Python:

venv activation: `source venvName/bin/activate`

## Bash:

#### Useful aliases:
Use in .bash_rc in home dir.

```
alias ytbest="youtube-dl -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio' --merge-output-format mp4"
alias cppnew="/home/felix/scripts/createcpp.sh"
alias ytbestaudio="youtube-dl -x --audio-format mp3"
```

#### Remove Only Current Session Bash History and Leave Older History Untouched

```
unset HISTFILE && exit
```

#### Turn off your screen:

```bash
xset dpms force off
```
**NOTE**: that this will work only on X11. Wayland is a new default so please 
either use build in shortcuts for you DE or download [soff](https://github.com/hyperstown/soff)

## FFmpeg:

Converting mp4 file into HLS playlist:

`ffmpeg -i file.mp4 -profile:v baseline -level 3.0 -s 1920x1080 -start_number 0 -hls_time 10 -hls_list_size 0 -f hls file.m3u8`
<hr>
- -i - after this flag specify input file
- profile:v - indicate that input file is a video file.
- hls_time - set segment length in seconds. Default: 2
- hls_list_size - set the maximum number of playlist entries. 0 indicates no limit.

Scaling video up and down:

```bash
ffmpeg -i your_recording.mp4 -vf scale=iw*0.5:ih m.mp4
```
<hr>
0.5 - scale twice down 
2 - scale twice up

## GCC

Compiling C++ file with threads:

`gcc -pthread -o excutableName filename.cpp -lstdc++`

- -pthread - this option adds multithreading support
- -lstdc++ - this option has to be used in order to compile C++ file. Without it compile will assume it's written in C.


## Screen:

Virtual terminal that allows you to detach from current session and leave it in the
background. (Alternatively you can also use tmux)

`screen` - open new screen sesion.

`screen -S somename` - create new named session

ctrl + a - open command menu (it doesn't show anything on screen)

ctrl + d - detach session

To restore session:

`screen -dr`

List of all sessions:

`screen -ls`

## KDE Specific:

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

## youtube-dl

A CLI tool for downloading youtube videos:

Download info about formats

-F switch:
```
youtube-dl -F https://www.youtube.com/watch?v=jNQXAC9IVRw
```

Download video in selected format:

-f switch
```
youtube-dl -f 242 https://www.youtube.com/watch?v=jNQXAC9IVRw
```

Quick download (This may download video without audio or not in best quality):
```
youtube-dl -f 242 https://www.youtube.com/watch?v=jNQXAC9IVRw
```

Preferable way to download videos:

Use bestvideo+bestaudio switch and merge output together into mp4 file.

```
youtube-dl -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio' --merge-output-format mp4 https://www.youtube.com/watch?v=jNQXAC9IVRw
```

Downloading best audio and converting it to mp3 (Requires ffmpeg):

```
youtube-dl -x --audio-format mp3 https://www.youtube.com/watch?v=jNQXAC9IVRw
```

Downloading playlists

-i switch:
Example YouTube playlist URL:
```
https://www.youtube.com/playlist?list=PLz2NxjLbk1uRRe0p_Z9XyYV4RGtC-FvzH
```
Playlist download:
```
youtube-dl -x --audio-format mp3 -i PLz2NxjLbk1uRRe0p_Z9XyYV4RGtC-FvzH
youtube-dl -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio' --merge-output-format mp4 -i PLz2NxjLbk1uRRe0p_Z9XyYV4RGtC-FvzH
```

## SSH and tunneling

Connect to the server via SSH

```
ssh u0_a244@192.168.1.5 -p 8022
```
where:
- `u0_a244` is remote server username
- `192.168.1.5` is IP of remote server
- `8022` is ssh port of remote server (Termux default port is 8022, for others is 22)

Create tunnel:
```
ssh -L local_port:remote_address:remote_port username@server.com
```
example:
```
ssh -L 5757:192.168.1.5:4747 u0_a244@192.168.1.5 -p 8022
```
This will forward port 4747 from remote server into port 5757 into local machine.

eg. before creating tunnel in order to access program that is using port 5757 on remote server we have to paste 192.168.1.5:5757.
After creating tunnel we can do that on 127.0.0.1:4747 (localhost)

## KVM/QEMU:

VirtualBox is one of the easiest way to run virtual machines on your OS however it has some issues with compatibility and performance. For light use some things are negligible but there were also some updates that introduced severe issues with audio. (If you find yourself in this situation best solution is to switch to ALSA driver in VM settings)
If you however find yourself in position that all the little annoyances of VBox are no longer possible to bear you should install KVM/QEMU. 
(That is if you don't plan on using 3D on Windows Guest. There is [open PR](https://github.com/virtio-win/kvm-guest-drivers-windows/pull/943) regarding this issue, if it's merged then I guess this warning is no longer valid.)
KVM/QEMU also has other benefits such as it's fully open source and supports PCI passthrough. (Though if you have lower-end hardware your motherboard doesn't support it anyway)

### **Installation:**

#### Fedora:

- View package group info.
- Install all the virtualization packages.
- Start libvirtd service.
- Enable (Start on boot) libvirtd service.

```
$ dnf groupinfo virtualization

Group: Virtualization
 Description: These packages provide a graphical virtualization environment.
 Mandatory Packages:
   virt-install
 Default Packages:
   libvirt-daemon-config-network
   libvirt-daemon-kvm
   qemu-kvm
   virt-manager
   virt-viewer
 Optional Packages:
   libguestfs-tools
   python3-libguestfs
   virt-top
```

```
$ sudo dnf install @virtualization
$ sudo systemctl start libvirtd
$ sudo systemctl enable libvirtd
```

[Source](https://docs.fedoraproject.org/en-US/quick-docs/getting-started-with-virtualization/)

#### Arch/Manjaro:

- Install all the virtualization packages.
- Start libvirtd service.
- Enable (Start on boot) libvirtd service.

```
$ sudo pacman -S virt-manager qemu vde2 ebtables dnsmasq bridge-utils openbsd-netcat
```

```
$ sudo systemctl enable libvirtd.service
$ sudo systemctl start libvirtd.service
```

**NOTE**: For some reason on Manjaro default network wasn't activated.\
You can fix it with:

`sudo virsh net-start default` - Activates virtual network

`sudo virsh net-autostart default` - Autostarts on system startup virtual network


For shared clipboard and autoresize window remember to install `spice-vdagent` on guest machine.
After resizing display it's also recommended to enable scaling to window in virt manager options.

[Source](https://wiki.manjaro.org/index.php?title=Virt-manager)\
[More info about frontend](https://wiki.archlinux.org/title/Libvirt)\
[More info about QEMU](https://wiki.archlinux.org/title/QEMU)

### Remote desktop

On host machine:

Enable or start sshd:
```
$ sudo systemctl start sshd
```
Make sure your user is in libvirt group. If not:
```
$ sudo usermod -a -G libvirt <your_username>
```

On client machine:

Install `ksshaskpass` or add ssh key to your config file.

For Arch users:
```
$ pacman -S ksshaskpass
```
Make sure your user is in libvirt group. If not:
```
$ sudo usermod -a -G libvirt <your_username>
```

## Stream audio from PulseAudio into Android device:

PulseAudio has option to stream audio using RTP. In order to do that it has 2 modules. RTP sender and RTP receiver. [This guys wrapped receiver into android app](https://github.com/wenxin-wang/PulseDroidRtp).

As dependencies it needs `pulseaudio`, `pulseaudio-rtp` (Possibly more therefore here is working config)

```
$ pacman -Q |grep pulse
  pulseaudio 15.0-1
  pulseaudio-alsa 1:1.2.5-2
  pulseaudio-bluetooth 15.0-1
  pulseaudio-equalizer 15.0-1
  pulseaudio-jack 15.0-1
  pulseaudio-lirc 15.0-1
  pulseaudio-qt 1.3-1
  pulseaudio-rtp 15.0-1
  pulseaudio-zeroconf 15.0-1
```

Load sink:

```
$ pactl load-module module-null-sink sink_name=rtp format=s16be channels=2 rate=48000
$ pactl load-module module-rtp-send source=rtp.monitor destination=192.168.18.5 port=4010 mtu=320
```
**Note: that destination is a IP of reciever device.**

If module load fail, required module is not installed or installation is broken. Solution also seems to be incompatible with PipeWire. (This require confirmation and testing)

Note that destination is a IP of reciever device.

Recievier:
Download [PulseAudio Rtp Receiver](https://f-droid.org/en/packages/me.wenxinwang.pulsedroidrtp/)\
Alternative Github [download](https://github.com/wenxin-wang/PulseDroidRtp/)

Set parameters to:
`IP: 0.0.0.0`
`Port: 4010`
`MTU: 320`
`Channel Count 2`
`Channel Mask 0`


## Stream audio from PulseAudio into another Linux device

On the "sender" add loop=true to "load-module module-rtp-send" and also add "load-module module-rtp-recv".

So "sender"
```
$ pactl load-module module-null-sink sink_name=rtp
$ pactl load-module module-rtp-send source=rtp.monitor rate=48000 channels=2 format=s16be loop=true
```
"listener"
```
load-module module-rtp-recv
```

No need for module-combine-sink


## Minecraft Server:

https://github.com/marcsello/minecraftd

## ZSH

Youtube links don't work with mpv, youtube-dl etc.
Allow special characters in links: `$ setopt nonomatch`

