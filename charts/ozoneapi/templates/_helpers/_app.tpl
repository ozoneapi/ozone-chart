{{- define "helpers.app.name" -}}
{{- if .Values.NameOverride -}}
{{- .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s-%s-%s" .Values.generic.hub .Values.generic.stage .Values.generic.environment .Values.generic.tenant | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "helpers.app.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "helpers.app.fullname" -}}
    {{- if .name -}}
        {{- printf "%s-%s" (include "helpers.app.name" .context) .name | trunc 63 | trimSuffix "-" -}}
    {{- else -}}
        {{- include "helpers.app.name" .context -}}
    {{- end -}}
{{- end -}}


{{- define "helpers.app.labels" -}}
{{- include "helpers.app.selectorLabels" . -}}
helm.sh/chart: {{ include "helpers.app.chart" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
ozoneapi.io/hub: {{ .Values.generic.hub }}
ozoneapi.io/stage: {{ .Values.generic.stage }}
ozoneapi.io/environment: {{ .Values.generic.environment }}
ozoneapi.io/tenant: {{ .Values.generic.tenant }}
ozoneapi.io/connector: {{ .Values.generic.connector }}
ozoneapi.io/app-version: {{ .Chart.AppVersion }}
ozoneapi.io/connector-version: {{ .Values.generic.connectorVersion }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
{{- with .Values.generic.labels }}
{{ include "helpers.tplvalues.render" (dict "value" . "context" $) }}
{{- end }}
{{- end }}

{{- define "helpers.app.selectorLabels" -}}
app.kubernetes.io/name: {{ include "helpers.app.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{ include "helpers.app.genericSelectorLabels" $ }}
{{- end }}

{{- define "helpers.app.genericSelectorLabels" -}}
{{- with .Values.generic.extraSelectorLabels }}
{{- include "helpers.tplvalues.render" (dict "value" . "context" $) }}
{{- end }}
{{- end }}

{{- define "helpers.app.genericAnnotations" -}}
{{- with .Values.generic.annotations }}
{{ include "helpers.tplvalues.render" (dict "value" . "context" $) }}
{{- end }}
{{- end }}