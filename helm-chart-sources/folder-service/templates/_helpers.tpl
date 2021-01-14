{{/*
Backend image with tag
*/}}
{{- define "folder-service.backendImage" -}}
{{- printf "%s:%s" .Chart.backendImage .Values.applicationVersion | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Frontend image with tag
*/}}
{{- define "folder-service.frontendImage" -}}
{{- printf "%s:%s" .Chart.frontendImage .Values.applicationVersion | trunc 63 | trimSuffix "-" }}
{{- end }}
