FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src

COPY ["src/DevSecOpsApi/DevSecOpsLab01.csproj", "src/DevSecOpsApi/"]
RUN dotnet restore "src/DevSecOpsApi/DevSecOpsLab01.csproj"

COPY . .
WORKDIR "/src/src/DevSecOpsApi"
RUN dotnet publish "DevSecOpsLab01.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS runtime
WORKDIR /app

ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080

COPY --from=build /app/publish .

ENTRYPOINT ["dotnet", "DevSecOpsLab01.dll"]
