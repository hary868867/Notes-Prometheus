# escape=`
FROM microsoft/dotnet-framework:4.7.2-sdk AS builder

WORKDIR C:\src\WebFormsApp
COPY src\netfx\WebFormsApp\packages.config .
RUN nuget restore packages.config -PackagesDirectory ..\packages

COPY src\netfx C:\src
RUN msbuild WebFormsApp.csproj /p:OutputPath=c:\out /p:Configuration=Release

# app image
FROM microsoft/aspnet:4.7.2-windowsservercore-ltsc2016
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';"]

ENV APP_ROOT=C:\web-app `
    EXPORTER_ROOT=C:\aspnet-exporter

RUN Import-Module WebAdministration; `
    Set-ItemProperty 'IIS:\AppPools\DefaultAppPool' -Name processModel.identityType -Value LocalSystem; `
    Remove-Website -Name 'Default Web Site';`
    New-Website -Name 'web-app' -Port 80 -PhysicalPath $env:APP_ROOT -Force

WORKDIR ${EXPORTER_ROOT}
COPY --from=dockersamples/aspnet-monitoring-exporter:4.7.2 C:\aspnet-exporter .
ENV COLLECTOR_CONFIG_PATH="w3svc-collectors.json"

ENTRYPOINT ["powershell"]
CMD Start-Service W3SVC; `
    Invoke-WebRequest http://localhost -UseBasicParsing | Out-Null; `
    Start-Process -NoNewWindow -WorkingDirectory $env:EXPORTER_ROOT "$env:EXPORTER_ROOT\aspnet-exporter.exe"; `
    C:\ServiceMonitor.exe w3svc

WORKDIR ${APP_ROOT}
COPY --from=builder C:\out\_PublishedWebsites\WebFormsApp .