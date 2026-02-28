local awful = require("awful")


--awful.spawn.with_shell("nitrogen --set-auto ~/wallpaper/bg.png")
awful.spawn.with_shell("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
awful.spawn("setxkbmap -layout 'us,ru' -option 'grp:alt_shift_toggle'")
