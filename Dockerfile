# مرحلة البناء
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# نسخ كل الملفات للمجلد
COPY . ./

# Restore ثم Build ثم Publish
RUN dotnet restore "project_graduation.csproj"
RUN dotnet publish "project_graduation.csproj" -c Release -o out

# مرحلة التشغيل
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/out .

# شغّل التطبيق
ENTRYPOINT ["dotnet", "project_graduation.dll"]
