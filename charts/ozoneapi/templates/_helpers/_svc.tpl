{{- define "helpers.svc.fqdn" -}}
{{ printf "%s.%s.svc.cluster.local" (include "helpers.app.fullname" (dict "name" "svc" "context" $)) .Release.Namespace  }}
{{- end -}}