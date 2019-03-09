# dotfiles
My dotfiles

On my laptop touchscreen didn't work after wakeup.
In order to fix the problem - create a resume script to reset the wacom kernel modules responsible for the touchscreen on resume.

> ln -s 99wacom_restart_touchsreen /lib/systemd/system-sleep/

In order to fix multitouch, I add the following to every user's `~/.profile`:
> xsetwacom set 10 Gesture "off"
