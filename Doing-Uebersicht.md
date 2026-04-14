# Hier schreibe ich auf was ich so erfolgreich gelernt um Umgesetzt habe.
*Feingranulare schritte aus den Commits entnehmen*

- Ubuntu Server vorbereitet
- - Rancher Desktop installiert
- - k8s/k3s installiert
- - kubectl context gesetzt und erste abfragen erfolgreich
- - Ersten Pod deployed

NAME          READY   STATUS              RESTARTS   AGE
nginx-test   0/1     ContainerCreating   0          3s
secretname@Lab:~/.kube$ k get pods
NAME          READY   STATUS    RESTARTS   AGE
nginx-test   1/1     Running   0          18s

- Label editiert mit k edit pod <pod-name>

Name:             nginx-test
Namespace:        default
Priority:         0
Service Account:  default
Node:             lima-rancher-desktop/<IPv4>
Start Time:       Tue, 14 Apr 2026 15:32:44 +0200
Labels:           label=Test-Label
                  run=nginx-domke


- Nebenprobleme
- - RDP zum Ubuntu gefixt via <loginctl unlock-session> 
- - .vimrc angepasst für yaml-bearbeitung


