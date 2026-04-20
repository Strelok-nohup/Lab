# Kubernetes Commands - Übersicht

| Command | Was es macht |
|---|---|
| `k get pods` | Pods im default-Namespace anzeigen |
| `k get pods -A` | Pods in allen Namespaces anzeigen |
| `kubectl config use-context rancher-desktop` | Kontext auf rancher-desktop wechseln |
| `kubectl config view` | Gesamte kubeconfig anzeigen |
| `kcs` | Alias → `kubectl config use-context` |
| `k run nginx-yaml --image=nginx --dry-run=client -o yaml` | Pod-YAML lokal generieren ohne anzulegen (kein Cluster nötig) |
| `kubectl apply --dry-run=server -f nginx.yaml` | Manifest gegen Cluster validieren ohne anzulegen |
| `k get pods -o wide` | Mehr Details zu Pods anzeigen |
| `k exec -it nginx-domke -- /bin/bash` | Interaktive Shell in Pod öffnen |
| `k create deployment test --image=httpd --replicas=3` | Deployment mit 3 Replicas aus httpd Image erstellen |
| `k get deployments.apps` | Deployments anzeigen |
| `k create deployment -h \| vim -` | Hilfe zu Deployment-Erstellung in Vim öffnen |

## Weitere Hinweise

- Im Bezug auf "Rolling Updates": https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#strategy
- In Vim: `:set paste` um Formatierung für Einrückungen zu entfernen
- Strategy Rolling Update: `maxSurge: 25%`, `maxUnavailable: 25%`
- Unterschiede zwischen Recreate und RollingUpdate Strategien
- Namespaces: Jede Anwendung sollte eigenen Namespace mit eigener Netzwerkkontrolle haben
- Namespace in Konfiguration setzen: `k config set-context --current --namespace=strelok`
- Erste Anwendung deployen, z.B. https://github.com/mealie-recipes/mealie
- `kubectl port-forward` um Ports von lokalem Rechner zu Pod weiterzuleiten. Beispiele:
  - `kubectl port-forward pod/mypod 5000 6000` 
  - `kubectl port-forward deployment/mydeployment 5000 6000`
  - `kubectl port-forward service/myservice 8443:https`
  - `kubectl port-forward --address 0.0.0.0 pod/mypod 8888:5000`
- Reihenfolge: Deployment → ReplicaSet → Pods
