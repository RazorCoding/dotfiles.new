autoload -Uz compinit
compinit
# If not running interactively, don't do anything
[[ -o interactive ]] || return

# Auto start Hyprland on TTY1
if [[ -z "$DISPLAY" && "$(tty)" == "/dev/tty1" ]]; then
  exec start-hyprland
fi
# Aliases
alias yt-dlp-extra='yt-dlp \
--download-archive downloaded.txt \
--no-post-overwrites \
-ciw \
-x \
--embed-thumbnail \
--add-metadata \
--audio-quality 0 \
--audio-format mp3 \
-o "%(title)s.%(ext)s" \'


alias Mirror='rate-mirrors --disable-comments-in-file --entry-country=CA --protocol=https arch --max-delay 7200 | sudo tee /etc/pacman.d/mirrorlist'
alias grim_S='grim -g "$(slurp)"'
alias ll='ls -laix'
alias hx='helix'
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# Initialize Starship
eval "$(starship init zsh)"
# History file
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# Record everything immediately
setopt APPEND_HISTORY        # append instead of overwrite
setopt INC_APPEND_HISTORY    # write to file instantly

