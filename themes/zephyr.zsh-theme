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
# Changes pre based on whether we're in a vi subprompt
function zephyr_pre {
  if [ -n "$MYVIMRC" ]; then
    echo -n "%{$fg[blue]%}"
  else
    echo -n "%{$fg[gray]%}"
  fi
}
function zephyr_txt {
  if [ -n "$MYVIMRC" ]; then
    echo -n "%{$fg[cyan]%}"
  else
    echo -n "%{$fg[red]%}"
  fi
}
function zephyr_git {
  if [ -n "$MYVIMRC" ]; then
    echo -n "%{$fg[white]%}"
  else
    echo -n "%{$fg[white]%}"
  fi
}
ZEPHYR_PRE="$(zephyr_pre)"
ZEPHYR_TXT="$(zephyr_txt)"
ZEPHYR_GIT="$(zephyr_git)"
function prompt_char {
    echo -n "%{$ZEPHYR_PRE%}"
    echo "└─┴─┤%{$reset_color%}"
}
function close_git {
    echo -n "%{$ZEPHYR_PRE%}"
    echo "│%{$reset_color%}"
}
function open_git {
    git branch 1>/dev/null 2>&1 && echo "├─┤" && return
}
function vi_prompt {
  PRE="%{$ZEPHYR_TXT%}"
  END="%{$reset_color%}"

  echo -n "$PRE"
  if [ $(vi_mode_prompt_info) ]; then
    echo -n "━"
  else
    echo -n "●"
  fi
  echo -n "$END"
}

# The actual prompt.
PROMPT='
%{$ZEPHYR_PRE%}┌─┬─┤%{$reset_color%}%{$ZEPHYR_TXT%}$(collapse_pwd)%{$reset_color%}%{$ZEPHYR_PRE%}$(open_git)%{$reset_color%}$(git_prompt_info)%{$ZEPHYR_PRE%}$(close_git)%{$reset_color%}
$(close_git)$(vi_prompt)$(close_git)
$(prompt_char) '
RPROMPT='%{$ZEPHYR_PRE%}%T%{$reset_color%}'
ZSH_THEME_GIT_PROMPT_PREFIX="%{$ZEPHYR_GIT%} "
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$ZEPHYR_GIT%} *%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_CLEAN="%{$ZEPHYR_PRE%} %{$reset_color%}"
