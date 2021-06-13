FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /src
COPY ["src/ScarletAuth.AdminUI.Admin/ScarletAuth.AdminUI.Admin.csproj", "src/ScarletAuth.AdminUI.Admin/"]
COPY ["src/ScarletAuth.AdminUI.Admin.EntityFramework.Shared/ScarletAuth.AdminUI.Admin.EntityFramework.Shared.csproj", "src/ScarletAuth.AdminUI.Admin.EntityFramework.Shared/"]
COPY ["src/ScarletAuth.AdminUI.Admin.EntityFramework.SqlServer/ScarletAuth.AdminUI.Admin.EntityFramework.SqlServer.csproj", "src/ScarletAuth.AdminUI.Admin.EntityFramework.SqlServer/"]
COPY ["src/ScarletAuth.AdminUI.Admin.EntityFramework.PostgreSQL/ScarletAuth.AdminUI.Admin.EntityFramework.PostgreSQL.csproj", "src/ScarletAuth.AdminUI.Admin.EntityFramework.PostgreSQL/"]
COPY ["src/ScarletAuth.AdminUI.Shared/ScarletAuth.AdminUI.Shared.csproj", "src/ScarletAuth.AdminUI.Shared/"]
COPY ["src/ScarletAuth.AdminUI.Admin.EntityFramework.MySql/ScarletAuth.AdminUI.Admin.EntityFramework.MySql.csproj", "src/ScarletAuth.AdminUI.Admin.EntityFramework.MySql/"]
RUN dotnet restore "src/ScarletAuth.AdminUI.Admin/ScarletAuth.AdminUI.Admin.csproj"
COPY . .
WORKDIR "/src/src/ScarletAuth.AdminUI.Admin"
RUN dotnet build "ScarletAuth.AdminUI.Admin.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "ScarletAuth.AdminUI.Admin.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENV ASPNETCORE_FORWARDEDHEADERS_ENABLED=true
ENTRYPOINT ["dotnet", "ScarletAuth.AdminUI.Admin.dll"]