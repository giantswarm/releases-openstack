{{- define "cluster" }}
apiVersion: cluster.x-k8s.io/v1alpha4
kind: Cluster
metadata:
  annotations:
    cluster.giantswarm.io/description: "{{ .Values.clusterDescription }}"
  labels:
    cluster-apps-operator.giantswarm.io/watching: ""
    {{- include "labels.common" $ | nindent 4 }}
  name: {{ include "resource.default.name" $ }}
  namespace: {{ .Release.Namespace }}
spec:
  topology:
    class: {{ include "resource.default.name" $ }}
    version: {{ .Values.kubernetesVersion }}
    controlPlane:
      replicas: {{ .Values.controlPlane.replicas }}
      metadata:
        labels:
          {{- include "labels.common" $ | nindent 10 }}
    workers:
      machineDeployments:
      {{- range .Values.nodePools }}
      - class: {{ .class }}
        name: {{ .name }}
        replicas: {{ .replicas }}
        metadata:
          labels:
            machine-deployment.giantswarm.io/failure-domain: "{{ .failureDomain }}"
            {{- include "labels.common" $ | nindent 12 }}
      {{- end }}
{{- end -}}