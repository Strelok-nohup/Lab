# Rancher Desktop – x509 Cert-Fehler nach Neustart

## Problem

```
Unable to connect to the server: tls: failed to verify certificate:
x509: certificate signed by unknown authority
```

Rancher Desktop läuft in einer eigenen VM (Lima auf Linux).  
Bei jedem Neustart generiert es **neue TLS-Zertifikate** für den Kubernetes-API-Server.  
Die `~/.kube/config` zeigt aber noch auf die alten Certs → x509-Fehler.

Rancher Desktop schreibt die frische kubeconfig nach `~/.rd/config/kubeconfig.yaml`,
merged sie aber nicht automatisch in `~/.kube/config`.

---

## Permanenter Fix – Symlink statt Kopie

```bash
# Backup der alten config
mv ~/.kube/config ~/.kube/config.bak

# Symlink direkt auf Rancher Desktops kubeconfig
ln -s ~/.rd/config/kubeconfig.yaml ~/.kube/config
```

Damit zeigt `~/.kube/config` immer direkt auf die frisch generierte Datei –  
nach jedem Neustart automatisch aktuell, **kein manueller Eingriff nötig**.

### Testen

```bash
ls -la ~/.kube/config      # sollte → ~/.rd/config/kubeconfig.yaml zeigen
kubectl cluster-info        # sollte jetzt funktionieren
```

---

## Mehrere Cluster (Lab + Rancher Desktop)

Wenn zusätzliche Cluster in der kubeconfig liegen, `KUBECONFIG` als Variable nutzen:

```bash
# In ~/.bashrc eintragen:
export KUBECONFIG=~/.rd/config/kubeconfig.yaml:~/.kube/lab-config.yaml
```

Damit werden beide Configs gemergt und sind über `kubectl config get-contexts` erreichbar.

```bash
# Zwischen Kontexten wechseln:
kubectl config use-context rancher-desktop
kubectl config use-context <lab-kontext>

# Oder als Alias in ~/.bashrc:
alias krd='kubectl config use-context rancher-desktop'
alias klab='kubectl config use-context <lab-kontext>'
```
