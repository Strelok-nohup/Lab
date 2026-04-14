# Kubernetes Commands – Übersicht

| Command | Was es macht |
|---|---|
| `k get pods` | Pods im default-Namespace anzeigen |
| `k get pods -A` | Pods in allen Namespaces anzeigen |
| `k get pods -A --watch` | Pods aller Namespaces live beobachten |
| `k get pods -n kube-system` | Pods im kube-system Namespace anzeigen |
| `kubectl config use-context rancher-desktop` | Kontext auf rancher-desktop wechseln |
| `kubectl config view` | Gesamte kubeconfig anzeigen |
| `kubectl config get-contexts` | Alle verfügbaren Kontexte anzeigen |
| `kubectl cluster-info` | Cluster-Endpunkt und Status anzeigen |
| `kubectl get nodes` | Nodes im Cluster anzeigen |
| `kubectl wait --for=condition=Ready pods --all -n kube-system --timeout=120s` | Warten bis alle Pods ready sind |
| `kcs` | Alias → `kubectl config use-context` |
