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

ENV APP_ROOT=C:\web-app

RUN Remove-Website -Name 'Default Web Site';`
    New-Website -Name 'web-app' -Port 80 -PhysicalPath $env:APP_ROOT -Force

WORKDIR ${APP_ROOT}
COPY --from=builder C:\out\_PublishedWebsites\WebFormsApp .