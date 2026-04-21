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
- Unterschiede zwischen Recreate und RollingUpdate Strategien durchgegangen
- Namespaces: Jede Anwendung sollte eigenen Namespace mit eigener Netzwerkkontrolle haben. Kubernetes Docs dazu nachtragen.
- Namespace in Konfiguration setzen: `k config set-context --current --namespace=strelok`
- Erste Anwendung deployen, z.B. https://github.com/mealie-recipes/mealie

## Port-Forwarding

`kubectl port-forward` leitet einen oder mehrere lokale Ports zu einem Pod weiter. 
Verwenden Sie Ressourcentyp/Name wie deployment/mydeployment, um einen Pod auszuwählen. Der Ressourcentyp ist standardmäßig 'pod', wenn er weggelassen wird.
Wenn mehrere Pods den Kriterien entsprechen, wird automatisch ein Pod ausgewählt. Die Weiterleitungssitzung endet, wenn der ausgewählte Pod beendet wird, und ein erneuter Aufruf des Befehls ist erforderlich, um die Weiterleitung fortzusetzen.

Beispiele:
- `kubectl port-forward pod/mypod 5000 6000` - Lokal auf Ports 5000 und 6000 lauschen, Daten an Ports 5000 und 6000 im Pod weiterleiten
- `kubectl port-forward deployment/mydeployment 5000 6000` - Wie oben, aber Pod wird durch Deployment ausgewählt
- `kubectl port-forward service/myservice 8443:https` - Lokal auf Port 8443 lauschen, Weiterleitung zum targetPort des Ports "https" des Service 
- `kubectl port-forward pod/mypod 8888:5000` - Lokal auf Port 8888 lauschen, Weiterleitung zu Port 5000 im Pod
- `kubectl port-forward --address 0.0.0.0 pod/mypod 8888:5000` - Auf allen Adressen auf Port 8888 lauschen, Weiterleitung zu Port 5000 im Pod
- `kubectl port-forward --address localhost,10.19.21.23 pod/mypod 8888:5000` - Auf Port 8888 auf localhost und ausgewählter IP lauschen
- `kubectl port-forward pod/mypod :5000` - Auf zufälligem lokalen Port lauschen, Weiterleitung zu Port 5000 im Pod

Optionen:
- `--address=[localhost]` - Adressen, auf denen gelauscht wird (durch Komma getrennt). Akzeptiert nur IP-Adressen oder localhost. 
- `--pod-running-timeout=1m0s` - Zeit, die gewartet wird, bis mindestens ein Pod läuft

Reihenfolge: Deployment → ReplicaSet → Pods

Beispiel:
- `k port-forward pods/strelok-app-65b97b5d-wxpd8 9000` - Port 9000 weiterleiten
- `k port-forward pods/strelok-app-65b97b5d-wxpd8 9000 --address 0.0.0.0` - Port 9000 auf allen Adressen weiterleiten
   kubectl config set-context --current --namespace=<namespace-name> 
k port-forward -n <Namespace_Name> pods/<Pod_Name> <Port> <Listener_Netzbereich_IPv4>
