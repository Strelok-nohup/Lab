# Kubernetes Commands – Übersicht

| Command | Was es macht |
|---|---|
| `k get pods` | Pods im default-Namespace anzeigen |
| `k get pods -A` | Pods in allen Namespaces anzeigen |
| `kubectl config use-context rancher-desktop` | Kontext auf rancher-desktop wechseln |
| `kubectl config view` | Gesamte kubeconfig anzeigen |
| `kcs` | Alias → `kubectl config use-context` |
| `k run nginx-yaml --image=nginx --dry-run=client -o yaml` | Pod-YAML lokal generieren ohne anzulegen (kein Cluster nötig) |
| `kubectl apply --dry-run=server -f nginx.yaml` | Manifest gegen Cluster validieren ohne anzulegen |

k get pods -o wide
k exec -it nginx-domke -- /bin/bash
k create deployment test --image=httpd --replicas=3
k get deployments.apps
k create deployment -h | vim -
https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#strategy
- Im bezug auf "Rolling Updates"
in Vim = :set paste (Formatierung entfernen fuer einrückungen
strategy Rolling Update =  maxSurge: 25%  maxUnavailable: 25%
Im grunde Recreate und RollingUpdate unterschiede durchgegangen
Namespaces kubenetersdocs nachtragen
Jede Application eigenen Namespaces und damit eigene Netzwerkkontrolle
