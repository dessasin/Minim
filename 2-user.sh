#!/usr/bin/env bash
#-------------------------------------------------------------------------
#   █████╗ ██████╗  ██████╗██╗  ██╗████████╗██╗████████╗██╗   ██╗███████╗
#  ██╔══██╗██╔══██╗██╔════╝██║  ██║╚══██╔══╝██║╚══██╔══╝██║   ██║██╔════╝
#  ███████║██████╔╝██║     ███████║   ██║   ██║   ██║   ██║   ██║███████╗
#  ██╔══██║██╔══██╗██║     ██╔══██║   ██║   ██║   ██║   ██║   ██║╚════██║
#  ██║  ██║██║  ██║╚██████╗██║  ██║   ██║   ██║   ██║   ╚██████╔╝███████║
#  ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝   ╚═╝   ╚═╝   ╚═╝    ╚═════╝ ╚══════╝
#-------------------------------------------------------------------------

echo -e "\nINSTALLING AUR SOFTWARE\n"
# You can solve users running this script as root with this and then doing the same for the next for statement. However I will leave this up to you.

echo "CLONING: PARU"
cd ~
git clone "https://aur.archlinux.org/paru.git"
cd ${HOME}/paru
makepkg -si --noconfirm
cd ~

PKGS=(
'awesome-terminal-fonts'
'nerd-fonts-fira-code'
'noto-fonts-emoji'
'ttf-droid'
'ttf-hack'
'ttf-roboto'
'snap-pac'
)

for PKG in "${PKGS[@]}"; do
    ln -s "$HOME/zsh/.zshrc" $HOME/.zshrc
 paru -S --noconfirm $PKG
done

export PATH=$PATH:~/.local/bin
cp -r $HOME/Minim/dotfiles/* $HOME/.config/
pip install konsave
konsave -i $HOME/Minim/kde.knsv
sleep 1
konsave -a kde

echo -e "\nDone!\n"
exit
