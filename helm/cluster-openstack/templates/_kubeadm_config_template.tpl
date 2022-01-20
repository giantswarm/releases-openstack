{{- define "kubeadm-config-template" }}
apiVersion: bootstrap.cluster.x-k8s.io/v1beta1
kind: KubeadmConfigTemplate
metadata:
  labels:
    {{- include "labels.common" . | nindent 4 }}
  name: {{ include "resource.default.name" . }}-{{ .name }}
  namespace: {{ $.Release.Namespace }}
spec:
  template:
    spec:
      joinConfiguration:
        nodeRegistration:
          kubeletExtraArgs:
            cloud-provider: external
            node-labels: giantswarm.io/node-pool={{ .name }}
          name: '{{ `{{ local_hostname }}` }}'
      {{- include "sshConfig" . | nindent 6 }}
{{- end -}}
