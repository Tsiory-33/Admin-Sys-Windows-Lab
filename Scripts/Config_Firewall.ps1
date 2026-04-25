# Créer une règle pour bloquer les requêtes de "Ping" entrantes
New-NetFirewallRule -DisplayName "Blocage_Ping_Perso" `
    -Direction Inbound `
    -Action Block `
    -Protocol ICMPv4 `
    -Description "Projet Labo : Désactivation du ping pour durcissement système"
