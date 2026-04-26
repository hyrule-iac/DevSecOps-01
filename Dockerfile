FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src
# Copia desde la estructura que acabas de validar
COPY ["src/DevSecOpsApi/DevSecOpsLab01.csproj", "src/DevSecOpsApi/"]
RUN dotnet restore "src/DevSecOpsApi/DevSecOpsLab01.csproj"
COPY . .
WORKDIR "/src/src/DevSecOpsApi"
RUN dotnet build "DevSecOpsLab01.csproj" -c Release -o /app/build