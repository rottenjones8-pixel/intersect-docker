# Build Stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY . .
RUN dotnet publish "Intersect.Server/Intersect.Server.csproj" -c Release -o /app/publish

# Runtime Stage
FROM mcr.microsoft.com/dotnet/runtime:8.0 AS final
WORKDIR /app
COPY --from=build /app/publish .

# Expose Intersect's default networking ports
EXPOSE 5400/tcp
EXPOSE 5400/udp

ENTRYPOINT ["dotnet", "Intersect Server.dll"]