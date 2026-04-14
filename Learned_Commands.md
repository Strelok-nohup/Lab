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

