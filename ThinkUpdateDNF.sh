#!/bin/bash

##########################################################################################################################
# Script: ThinkUpdateDNF
# Autor: ThinkRoot
# Versiune: 1.0

# Descriere:
#   Acest script actualizează fișierul de configurare „dnf.conf” pentru a reflecta setările specificate.
#   Este util pentru a automatiza configurarea inițială sau modificările de configurare ale sistemului de gestionare a pachetelor în Fedora.

# Pași de utilizare:
# 1. După ce ai descărcat acest fișier, poți face unele modificări utile pentru tine sau îl poți lăsa așa cum este.
# 2. Deschide terminalul și navighează în directorul în care ai salvat scriptul.
# 3. Acordă permisiuni de executare pentru script folosind comanda: chmod +x ThinkUpdateDNF.sh.
# 4. Rulează scriptul cu privilegii de superutilizator (sudo) folosind comanda: sudo ./ThinkUpdateDNF.sh.
# 5. Scriptul va actualiza fișierul „dnf.conf” cu noile setări specificate.
##########################################################################################################################

# Definirea unui array cu noile setări pentru dnf.conf
new_settings=(
    "gpgcheck=True"
    "installonly_limit=2"
    "clean_requirements_on_remove=True"
    "best=False"
    "skip_if_unavailable=True"
    "fastestmirror=True"
    "max_parallel_downloads=20"
    "max_downloads_per_mirror=100"
    "deltarpm=True"
    "exclude=kernel*"
    "multilib_policy=all"
    "metadata_timer_sync=0"
    "metadata_expire=-1"
)

# Definirea calei către fișierul dnf.conf
dnf_conf="/etc/dnf/dnf.conf"

# Verificarea existenței fișierului dnf.conf și a permisiunilor de scriere
if [ -w "$dnf_conf" ]; then
# Salvarea vechiului conținut al fișierului dnf.conf pentru a crea o copie de siguranță
    cp "$dnf_conf" "$dnf_conf.bak"

# Parcurgerea listei cu noile setări și actualizarea fișierului dnf.conf
    for setting in "${new_settings[@]}"; do
        # Verificarea dacă setarea există deja în fișier
        if grep -q "^$setting" "$dnf_conf"; then
            sed -i "s/^$setting.*/$setting/" "$dnf_conf"
        else
            echo "$setting" >> "$dnf_conf"
        fi
    done

    echo "Fișierul dnf.conf a fost actualizat cu noile setări."
else
    echo "Nu ai permisiuni pentru a modifica fișierul dnf.conf."
fi
