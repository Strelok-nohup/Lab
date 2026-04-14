#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────────
# Headless Dummy-Display Setup (für RustDesk / headless Betrieb)
# ─────────────────────────────────────────────────────────────────────────────

set -euo pipefail

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; NC='\033[0m'
log()  { echo -e "${GREEN}[✓]${NC} $1"; }
warn() { echo -e "${YELLOW}[!]${NC} $1"; }
die()  { echo -e "${RED}[✗]${NC} $1" >&2; exit 1; }

[[ $EUID -eq 0 ]] || die "Als root ausführen: sudo $0"

# ─── Paket installieren ───────────────────────────────────────────────────────
log "xserver-xorg-video-dummy installieren..."
apt-get install -y xserver-xorg-video-dummy -qq

# ─── Xorg-Konfig schreiben ────────────────────────────────────────────────────
log "Dummy-Display konfigurieren..."
mkdir -p /etc/X11/xorg.conf.d/

cat > /etc/X11/xorg.conf.d/10-dummy.conf << 'EOF'
Section "Device"
    Identifier  "Dummy Device"
    Driver      "dummy"
    VideoRam    256000
EndSection

Section "Monitor"
    Identifier  "Dummy Monitor"
    HorizSync   28.0-80.0
    VertRefresh 48.0-75.0
    Modeline    "1920x1080" 148.50 1920 2008 2052 2200 1080 1084 1089 1125 +hsync +vsync
    Modeline    "1280x720"   74.25 1280 1390 1430 1650  720  725  730  750 +hsync +vsync
EndSection

Section "Screen"
    Identifier  "Dummy Screen"
    Device      "Dummy Device"
    Monitor     "Dummy Monitor"
    DefaultDepth 24
    SubSection "Display"
        Depth    24
        Modes    "1920x1080" "1280x720"
        Virtual  1920 1080
    EndSubSection
EndSection
EOF

log "Dummy-Display aktiv: /etc/X11/xorg.conf.d/10-dummy.conf"

# ─── RustDesk neu starten ─────────────────────────────────────────────────────
if systemctl is-active --quiet rustdesk 2>/dev/null; then
    log "RustDesk neu starten..."
    systemctl restart rustdesk
else
    warn "RustDesk läuft nicht – ggf. manuell starten: systemctl start rustdesk"
fi

echo ""
echo "════════════════════════════════════════════════════════"
echo -e " ${GREEN}Dummy-Display aktiv${NC}"
echo "════════════════════════════════════════════════════════"
echo " Auflösung: 1920x1080 (virtuell)"
echo " Config:    /etc/X11/xorg.conf.d/10-dummy.conf"
echo ""
echo " Deaktivieren:"
echo "   sudo rm /etc/X11/xorg.conf.d/10-dummy.conf"
echo "════════════════════════════════════════════════════════"
