#!/bin/bash
set -e

if ! command -v zsh &> /dev/null
then
    echo "zsh could not be found"
    exit 1
fi

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

ZSH_CUSTOM=$HOME/.oh-my-zsh/custom

git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

cp .zshrc $HOME/.zshrc
cp .p10k.zsh $HOME/.p10k.zsh

if user_can_sudo; then
    sudo -k chsh -s "$zsh" "$USER"  # -k forces the password prompt
else
    chsh -s "$zsh" "$USER"          # run chsh normally
fi
exec zsh -l
