#!/bin/sh
#
#  xfce4
#
#  Copyright (C) 1996-2003 Olivier Fourdan (fourdan@xfce.org)
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
#

if test "x$*" != "x"
then
  OPTS=""
  for OPT in $*
  do
    if test "x$OPT" == "x--help"
    then
      # print help and exit
      echo "Usage:"
      echo "  startxfce4 [OPTIONS...]"
      echo
      echo "Options:"
      echo "  --help                   Show help options"
      echo "  --with-ck-launch         Start xfce4-session inside a"
      echo "                           ConsoleKit session"
      echo

      exit 0
    elif test "x$OPT" == "x--with-ck-launch"
    then
      # try to launch xfce4-session with ck-launch-session in xinitrc
      XFCE4_SESSION_WITH_CK="1"
      export XFCE4_SESSION_WITH_CK
    else
      # append
      OPTS="$OPTS $OPT"
    fi
  done

  if test "x${OPTS#*--}" = "x${OPTS}"
  then
    CLIENTRC=${OPTS}
  else
    SERVERRC=${OPTS#*-- }
    CLIENTRC=${OPTS%--*}
  fi
fi

if test "x$XDG_CONFIG_HOME" = "x"
then
  BASEDIR="$HOME/.config/xfce4/"
else
  BASEDIR="$XDG_CONFIG_HOME/xfce4"
fi

if test "x$XDG_DATA_DIRS" = "x"
then
  if test "x/usr/share" = "x/usr/local/share" -o "x/usr/share" = "x/usr/share"; then
    XDG_DATA_DIRS="/usr/local/share:/usr/share"
  else
    XDG_DATA_DIRS="/usr/share:/usr/local/share:/usr/share"
  fi
else
  XDG_DATA_DIRS="$XDG_DATA_DIRS:/usr/share"
fi
export XDG_DATA_DIRS

if test "x$XDG_CONFIG_DIRS" = "x"
then
  if test "x/etc" = "x/etc"; then
    XDG_CONFIG_DIRS="/etc/xdg"
  else
    XDG_CONFIG_DIRS="/etc/xdg:/etc/xdg"
  fi
else
  XDG_CONFIG_DIRS="$XDG_CONFIG_DIRS:/etc/xdg"
fi
export XDG_CONFIG_DIRS

if test "x$DISPLAY" = "x"
then
  echo "$0: Starting X server"
  prog=xinit
else
  echo "$0: X server already running on display $DISPLAY"
  prog=/bin/sh
fi

if [ -f "$HOME/.xserverrc" ]; then
  SERVERRC="$HOME/.xserverrc $SERVERRC"
elif [ -f /etc/X11/xinit/xserverrc ]; then
  SERVERRC="/etc/X11/xinit/xserverrc $SERVERRC"
fi

if test ! "x$SERVERRC" = "x"
then
  SERVERRC="-- $SERVERRC"
fi

if [ -f $BASEDIR/xinitrc ]; then
  exec $prog $BASEDIR/xinitrc $CLIENTRC $SERVERRC
elif [ -f $HOME/.xfce4/xinitrc ]; then
  mkdir -p $BASEDIR
  cp $HOME/.xfce4/xinitrc $BASEDIR/
  exec $prog $BASEDIR/xinitrc $CLIENTRC $SERVERRC
else
  exec $prog /usr/bin/xinit_pantheon
fi

