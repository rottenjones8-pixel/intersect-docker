# Build Stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy full source code including submodules
COPY . .

# Restore and Publish
RUN dotnet publish "Intersect.Server/Intersect.Server.csproj" -c Release -o /app/publish

# Runtime Stage
FROM mcr.microsoft.com/dotnet/runtime:8.0 AS final
WORKDIR /app
COPY --from=build /app/publish .

EXPOSE 5400/tcp
EXPOSE 5400/udp

ENTRYPOINT ["dotnet", "Intersect Server.dll"]