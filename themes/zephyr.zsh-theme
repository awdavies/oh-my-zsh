# Code by Andrew Davies: "Zephyr"
#
# name in folder (github).  github branch shown when in git directory, also shows `*`
# to indicate dirty repo.
#
# A dot shows tha vi mode is in "insert" mode, whilst a dash shows that the
# prompt is in "edit" mode.

function collapse_pwd {
    echo $(pwd | sed -e "s,^$HOME,~,")
}
function vi_prompt {
  PRE="%{$fg[blue]%}"
  END="%{$reset_color%}"

  echo -n "$PRE"
  if [ $(vi_mode_prompt_info) ]; then
    echo -n "━"
  else
    echo -n "●"
  fi
  echo -n "$END"
}
ZEPHYR_PRE="%{$fg[gray]%}"
function prompt_char {
    echo -n "%{$ZEPHYR_PRE%}"
    echo "└─┴─┤%{$reset_color%}"
}
function close_git {
    echo -n "%{$ZEPHYR_PRE%}"
    echo "│%{$reset_color%}"
}
function open_git {
    git branch >/dev/null 2>/dev/null && echo "├─┤" && return
}

# The actual prompt.
PROMPT='
%{$ZEPHYR_PRE%}┌─┬─┤%{$reset_color%}%{$fg[blue]%}$(collapse_pwd)%{$reset_color%}%{$ZEPHYR_PRE%}$(open_git)%{$reset_color%}$(git_prompt_info)%{$ZEPHYR_PRE%}$(close_git)%{$reset_color%}
$(close_git)$(vi_prompt)$(close_git)
$(prompt_char) '
RPROMPT='%{$ZEPHYR_PRE%}%T%{$reset_color%}'
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[magenta]%} "
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$ZEPHYR_PRE%} *%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$ZEPHYR_PRE%} %{$reset_color%}"
