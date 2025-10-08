if status is-interactive
    # Commands to run in interactive sessions can go here

    set fish_greeting ""

    set -gx TERM xterm-256color

    # Theme
    set -g theme_color_scheme terminal-dark

    # Aliases
    alias vim="nvim"
    alias cls="clear"

    # Aliases for Eza
    if type -q eza
        alias ll "eza -l --icons"
        alias lla "eza -A -l --icons"
    end

    # Remove any global PATH variable to prevent shadowing universal PATH
    if set -q -g PATH
        set -e PATH
    end

    # Add Bun to the universal PATH if not already included
    if not contains $HOME/.bun/bin $PATH
        set -Ux PATH $HOME/.bun/bin $PATH
    end
end
