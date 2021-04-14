FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build-env

ARG VERSION

COPY . .

RUN dotnet restore --no-cache
RUN dotnet build /p:Version=$VERSION -c Release --no-restore

ENTRYPOINT ["dotnet", "pack", "/p:Version=$VERSION", "-c", "Release", "--no-restore", "--no-build", "-o", "/output"]