FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build-env

ARG VERSION
ARG NUGET_USER
ARG NUGET_KEY
ARG NUGET_URL

COPY . .

RUN dotnet restore --no-cache
RUN dotnet build /p:Version=$VERSION -c Release --no-restore
RUN dotnet pack /p:Version=$Version /p:SymbolPackageFormat=snupkg -c Release --no-restore --no-build -o /app/artifacts --include-symbols --include-source
RUN dotnet nuget add source $NUGET_URL -u $NUGET_USER -n GitHub -p $NUGET_KEY --store-password-in-clear-text
RUN dotnet nuget push /app/artifacts/*.nupkg --source GitHub --api-key $NUGET_KEY
