# LINUX RICE / WORKFLOW NOTES

# How to Set up SSH Remote Repository (GitHub)
Install openssh package:  
`sudo pacman -S openssh`
Use the `ssh-keygen -t ed25519 -C "your_email@example.com"` command to generate a key, which you'll want a password for. (ed25519 the most secure) Then, go to GitHub > Settings > SSH&GPG keys > make a new key. Paste in your **public key**, not your private key. Then, setup the repository and set the remote origin using ssh. The commands are as follows:  

```
git init
git branch -b main
# git add, git rm, make git ignore, etc.
git remote add origin git@github.com:[Username]/[Repo].git
git remote -v # use this to verify
git commit -m "added stuff" # or whatever message you want
git push origin main # OR
git push --set-upstream origin main --force # if you are setting up the remote
```


# Color theme for GTK apps
Even though we're not using the GNOME Desktop Environment, that doesn't mean we can't use gnome GUI apps. GNOME has themes downloadable from an official site (gnome-look I believe), and there's plenty of ricers on GitHub with their own custom themes. Install themes into the directory: `/usr/share/themes`. Then edit the gtk config files at `~/.config/gtk-3.0/settings.ini` and `~/.config/gtk-4.0/settings.ini`. Some apps (mainly chromium) will require a full restart of X for changes to take effect.

# Getting Japanese Characters to Display in the Terminal (for tmatrix)
All was fixed with the AUR package `ttf-mplus`  
Though, what if I wanted this to work on another distro, such as void?

# Batch renaming/converting files
RENAMING:  
command is `rename`  
syntax is `rename expression replacement file`  
Accepts wildcards and regex. For example:  
`rename '[0-9]*' '' *.pdf`  
This will remove every number from the title of every .pdf file in the directory.  

CONVERSION:  
1. install packages `libreoffice` and `unoserver`
2. start unoserver in the background `unoserver &`
3. `for i in (ls); unoconvert --convert-to output_type $i $i.output_type; end` (you can filter the ls command with something like `sed` to select only certain files)

# Removing vim-plug plugins
Remove them from the .vimrc, then run `:PlugClean`.

# Getting Dmenu to Open Terminal Apps Properly
In order to get Alacritty to stay open, you need to use the following command:  
`alacritty -e bash -c "TERMINAL_APPLICATION && exec bash"`  

I used that alongside a custom dmenu_run script to get things working properly (dmenu_run is the script that runs by default in DWM when you press alt+P). The script will ask the user whether the application should be run in a terminal or in the background (Ideal for GUI apps). This choice is remembered, and output to a config file. I found said script in this [forum thread](https://bbs.archlinux.org/viewtopic.php?id=107717).

# What is Needed for Autotheme
Write a script that does several things:
1. Run a patch on the Alacritty.yml config file that changes the colors.  
2. Run a script that does something similar for fish, though I'm actually not sure how coloring works. It seems to use terminal colors for some things, but its own colors for other things.  
3. Change themes for GUI apps such as Chromium or VSCode... I don't know how this is going to work, but surely there's config files for enabled extensions.  
4. Change the wallpaper. Surely nitrogen has a command for this.  
5. Finally, patch DWM config.h similar to how it's done for Alacritty. Recompile, and restart X.

# Gruvbox Theme
Add [this](https://github.com/aarowill/base16-alacritty/blob/master/colors/base16-gruvbox-dark-hard.yml) to /etc/xdg/Alacritty.yml. This will take care of most terminal apps, but maybe not fish?

For fish terminal, install [Fisher](https://github.com/jorgebucaran/fisher) plugin manager, and then install the [fish-gruvbox](https://github.com/Jomik/fish-gruvbox) plugin with the following command:  
`fisher install jomik/fish-gruvbox`  
This will expose the function called `theme_gruvbox`. Follow the documentation at the repo to get things fully set up and customized.  

VSCode also has two gruvbox themes available. They're pretty good.  

Chromium also has a theme.  

Patch DWM with the right colors, and change the background to something appropriate.  
# Clipboard (WIP)
install `xsel`  
get vim plugin: https://github.com/christoomey/vim-system-copy  

# Markdown Preview VIM Plugin
SOURCES:  
[Troubleshooting](https://github.com/iamcco/markdown-preview.nvim/issues/43), [Video Explaination](https://www.youtube.com/watch?v=22JAs0kNA9k)

# Markdown Syntax
`*words*` - puts text in italics  

`**words**` - puts text in bold  

`` `words` `` - puts words in "code mode"  

to enclose single backticks ```` `` ` ` `` ````  

NOTE: If you need to show backticks, enclose them in a higher number of backtics. Though intense backtickception plays by a more complicated ruleset, it is rare that you will need to show more than two backticks in the first place. Also, I'm guessing this works the same way for other symbols.  

`> quote` blockquote  

Ordered List:  

`1. First item`  
`2. Second item`  
`3. Third item`  

Horizontal Rule: `---`  

Link: `[title](https://www.example.com)`  

Image: `[alt text](image.jpg)`  

# Extended Markdown Syntax

Though data redundancy is important, I don't think markdown syntax is going anywhere anytime soon. Find the rest at the source link provided.  

SOURCES:  
[basic syntax](https://www.markdownguide.org/cheat-sheet/), 
[escaping backticks](https://stackoverflow.com/questions/33191744/how-to-add-new-line-in-markdown-presentation)  

# Using xdg-open and MIME Types
xdg-open is obviously not supported by every application. The application must have a .desktop file for it to work. These are located at either /usr/share/applications or /usr/local/share/applications or /local/share/applications.  

to see what is the default application for a mime type:  
`xdg-mime query default <type>`  

to set default application for a certain type:  
`xdg-mime default <file.desktop> <type>`  

for example:  
`xdg-mime query default video/mp4`  
`xdg-mime default vlc.desktop video/mp4`  

Unfortunately, I have yet to get xdg-open to work with terminal applications. Ideally, I would open a plaintext file while browsing lf (by pressing the right arrow key), and it would open in vim.

# Printer Support
More testing is required, because I'm really not sure about everything printer related. However, I have gotten printing to work with the current home printer, which is a Brother L2340DW.  

Apparently, drivers are a thing of the past! (or at least that's what we're attempting). That's how it worked for the Brother printer, and I'm assuming future models will implement driverless as well. Hopefully, unless I'm trying to connect to some "legacy" printer, driverless will be the way to go. We will see...  

The `lp` command prints. You can pipe in text and files, and it works like a charm (once configured). It is installed by default on most distros, but again, without printer configuration it will not do anything.

HOW I GOT THINGS TO WORK:
1. install the `cups` package
2. make sure that the `cups` service is running:  
`sudo systemctl enable cups` and `sudo systemctl start cups`
3. Find the printer on the network, get the `avahi` package (don't know if that's the official name)
4. run the following command to find the ip:  
`avahi-browse -t -d local -c -a --resolve | sed -n '/^=.*Printer/,/txt =/p'`
5. use `lpadmin` to add the printer
6. run this command, replacing the ip with the printer's ip:  
`lpadmin -p foobar -E -v ipp://192.168.ABC.DE/ipp -m everywhere`
7. now the lp command should work!  
8. troubleshooting: try going to localhost:631 for the site that allows you to do some gui setup  
eg: `echo 'joe mama' | lp`, `lp joemama.pdf`  

SOURCES:  
[weird how the gentoo wiki provided good info about lp, but the arch wiki was completely useless](https://wiki.gentoo.org/wiki/Driverless_printing)


# Backlight/Brightness
Users don't have permission to acces the screen device by default, so you will have to allow this with a udev rule. The config file for this is: `/etc/udev/rules.d/backlight.rules`. Create the file if necessary, then add the following to it:  
`ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="acpi_video0", GROUP="video", MODE="0664"`  
Then, add users to the group which should have acess (the `video` group)
1. Install the `acpilight` package.
2. Use the executable command xbacklight to change the brightness.
3. Use xbindkeys to bind the command to keys.  

# lf File Browser
## Basic Config
```
set hidden false
set icons true
set ignorecase true
```

## Icons
You will need nerd fonts for this to work. In your shell config file ( `.bashrc`, `.zshrc`, `config.fish` ), put the following:  
```
export LF_ICONS="\  
di=<directory symbol>
fi=<file symbol>:\
ln=<link symbol>:\
or=<don't know what this is symbol>:\
ex=<executable symbol>:\
*.extension=<whatever symbol ya want>:\
"
```
These will associate certain types of files with certain icons, which makes browsing files a lot easier.

## Getting lf to quit out to the right directory
Read the "Working Directory" section in the [lf tutorial wiki](https://github.com/gokcehan/lf/wiki/Tutorial). Also, be prepared to learn to write fish shell scripts (I get that the syntax is easier than BASH, but BASH is unfortunately still the standard)

# Fish Shell
Maybe I'll migrate to zsh one day, because it seems like it's a lot more customizable. However, the fish shell seems to have everything I would want at this point (except for some slight visual incompatibilities with programs like vscode).  

command for changing shell:  
`chsh $(which <shell>)`  

command for changing fish prompt:  
`function fish_prompt; set_color yellow -o; echo '>>'; end`  

command for saving fish prompt (saves in config files):  
`funcsave fish_prompt`  

To start X at login, put the following in `~/.config/fish/config.fish:`  
```
if status is-login
    if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
        exec startx -- -keeptty
    end
end
```

Customize welcome message in config.fish:  
`set fish_greeting`  

Don't forget to set $PATH, which is space delimited, unlike the colon delimited bash $PATH.

# Bluetooth
Do not use the `pulseaudio` package. The linux community seems to be moving more towards `pipewire`, so get that one instead. https://wiki.archlinux.org/title/PipeWire  

Get the bluez packages:  
`sudo pacman -S bluez bluez-utils bluez-tools`  

Enable kernel module and service:  
```
modprobe btusb
systemctl enable bluetooth.service
systemctl start bluetooth
```

Go into bluetoothctl shell:  
`bluetoothctl`  

Find device:  
`scan on`  

Pair & connect with mac address:  
```
power on
pair XX:XX:XX:XX...
trust XX:XX:XX:XX...
connect XX:XX:XX:XX...
```

Any time you want to reconnect to a paired device:  
1. go into shell
2. power on
3. connect <tab> (this will give you a list of paired devices to autocomplete the command)  

Maybe if I wasn't too lazy I'd write a script for this...

Unfortunately, setting volume is a work in progress. It is especially difficult because that functionality seems to be device specific.  
https://stackoverflow.com/questions/28191350/is-there-any-way-to-control-connected-bluetooth-device-volume-in-linux-using-com

# Nerd Fonts
Here's how this works: Nerd fonts are just regular fonts with extra symbols. It's not that complicated.  

Install the font file itself from GitHub, then put it in `~/.local/share/fonts`. You should be able to set it in the config files.  

To find "official" names for fonts use `fc-list` or `fc-list : family style`  

# Fast Keys
By fast keys, I mean the time it takes when you hold down a key before it starts outputting a single character really fast (time). Also, the speed of typing that character (speed). Add the following to .xinitrc, and the rest is history!:  

`xset r rate <time> <speed>`  

# Screenshot
Get `gnome-screenshot` and bind with xbindkeys, similar to the audio situation. The -i gives an options menu for selecting whole screen/window/selection

# Mouse Speed
use the following commands to get device info:  
`xinput list`  
`xinput --list-props <device id>`  

config file:  
`/etc/X11/xorg.conf.d/99-libinput-custom-config.conf`

this will set it temporarily, edit the config file  
`sudo xinput --set-prop 15 'libinput Accel Speed' 0.7`

put the following (replace what is in `<>` ):  
```
Section "InputClass"
  Identifier "<something to identify this snippet>"
  MatchDriver "libinput"
  MatchProduct "<substring of the device name>"
  Option "AccelSpeed" "0.7"
EndSection
```

# WIFI
use the script connect-wifi, which I made myself!
it's in /home/eliot/bin

# Audio
Audio doesn't work by default.  
Keyboard controls don't work by default.  
install amixer and xbindkeys  

The file ~/.xbindkeys will bind certain keys to certain commands.  
For example:  
```
"amixer -c 0 sset Master 10%+"
  2    m:0x0 + c:123
```
To find keycodes, use the xbindkeys -k command. It will open a window and ask you to press a key. It will then return the keycode for that key. Put this in the config file to bind. Once you are satisfied with the config, run xbindkeys (no options). Finally, put xbindkeys in the .xinitrc  

# Suckless Utils
Get DWM (obviously), but also make sure to get dmenu!  

dmenu_run script will run every time you press the hotkey for dmenu:  
/usr/local/bin/dmenu_run  

explains default keybinds for DWM: ratfactor.com/dwm  

Extra keybinds:  

open dmenu: MOD p  
open chromium: MOD w (extra custom hotkey)  
open chromium incog: MOD shift w (also custom)  

I wrote a script called updateStatusBar that does exactly what the name implies. It is updated regularly by a loop that runs in the .xinitrc. It is called every minute, but it can also be called outside of that loop.

# Compton
 ~/.config/compton.conf  
Compositor, responsible for the transparency and blurring effects. Don't forget to enable on startup with .xinitrc  
I put the notes for the config file in the config file, since it gets a bit complex  

Use the `xprop` command to get identifying information about certain apps that compton will need.  

# Alacritty
Config: /etc/xdg/alacritty.yml  
background vs. text transparency can be adjusted here!  

Custom Keybinds:  
CTRL +/-/= increase/decrease/default font size

# .bashrc
basic ANSI prompt colors use the following format \[\033[01;93m\]  
first number: 00 is regular, 01 is bold  
second number: controls the color  

For full color customization, you can use the 256 color terminal format, which is more complicated, but I don't find that necessary at this point.  

List of extra features that I added (explained in the script)  
-cd extra functionality  
-added python stuff to path  

# .nvimrc
If you want to use .nvimrc as the config file, you need to make the following directory:  
`mkdir -p ~/.config/nvim`

Then, make a file called init.vim in the nvim directory. The init.vim file should have the line:  
`source ~/.nvimrc`

# Vim Syntax
copy (visual) mode: v (not insert mode)  
copy: y  
paste: p  
shift + lr arrows: scroll word by word instead of char by char  
shift + up arrow: end of line  
shift + down arrow: go back 2 words  
shift + g: goes to end of file, if you typed a number before this command, it will take you to that line number  

# TODO
-fix screen flickering  
-bluetooth volume  
-Get vim Visual mode to copy to the system clipboard  
-Copy/Paste with keyboard in terminal and vim insert mode  
-change the color theme by running a command  
-get lf to open terminal apps  
-use lf as the default file browser for all software  
