Update database before running the app
-------------------------------------------------------------------
dotnet ef database update -c IdentityServerDataProtectionDbContext
dotnet ef database update -c AdminAuditLogDbContext
dotnet ef database update -c AdminLogDbContext
