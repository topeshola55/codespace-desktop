#!/bin/bash
set -e

sudo apt-get update
sudo apt-get install -y xfce4 xfce4-goodies tigervnc-standalone-server novnc websockify dbus-x11

# VNC session config -> start XFCE desktop
mkdir -p ~/.vnc
cat > ~/.vnc/xstartup <<'EOF'
#!/bin/bash
unset SESSION_MANAGER
exec startxfce4
EOF
chmod +x ~/.vnc/xstartup

# Set VNC password non-interactively (change it!)
printf 'codespace123\n' | vncpasswd -f > ~/.vnc/passwd
chmod 600 ~/.vnc/passwd

# Start VNC server + web bridge
vncserver -geometry 1600x900 -depth 24 :1
websockify --web=/usr/share/novnc 6080 localhost:5901 &

echo "✅ Desktop ready — open forwarded port 6080 in your browser"
