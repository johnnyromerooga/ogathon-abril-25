# 🚀 Script de Automatización con Docker, Newman y SonarQube

Este proyecto automatiza las siguientes tareas desde un repositorio Git:

- 🐳 Levanta un contenedor Docker
- 🧪 Ejecuta una colección de Postman con **Newman**
- 📈 Sube los resultados del análisis del proyecto a **SonarQube**
- ✅ Soporta los lenguajes: Python, PHP, Node.js, .NET, Java (Maven y Gradle)

---

## 🧱 Requisitos Previos

### 1. 🐳 Docker Desktop

Necesario para ejecutar contenedores.  
📥 [Descargar Docker Desktop](https://www.docker.com/products/docker-desktop/)

> Tras instalarlo, asegúrate de que Docker se esté ejecutando correctamente.

---

### 2. 🧪 Instalar Newman

Permite ejecutar pruebas de Postman desde CLI:

```bash
npm install -g newman
npm install -g newman-reporter-html
```

---

### 3. 📊 SonarQube

#### 🔸 Instalar SonarQube

1. 📥 [Descargar SonarQube](https://www.sonarqube.org/downloads/)
2. Descomprime el archivo en una carpeta (por ejemplo: `C:\sonarqube`)
3. Ejecuta:

```bash
cd C:\sonarqube\sonarqube-25.2.0.102705\bin\windows-x86-64
StartSonar.bat
```

🔗 URL: [http://localhost:9000](http://localhost:9000)  
🔑 Usuario: `admin`  
🔒 Contraseña: `Temporal01..`

---

#### 🔹 Instalar SonarScanner

📘 [Guía oficial](https://docs.sonarsource.com/sonarqube-server/latest/analyzing-source-code/scanners/sonarscanner/)

Después de descargar y extraer, agrega a las variables de entorno:

```bash
setx PATH "%PATH%;C:\sonarscanner\bin"
```

---

## 🍫 Chocolatey (Gestor de paquetes para Windows)

📦 Verifica si ya está instalado:

```bash
choco -v
```

🔧 Si no lo está, ejecuta en PowerShell como **Administrador**:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
"Set-ExecutionPolicy Bypass -Scope Process -Force; ^
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; ^
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))"
```

---

## ☕ Java y Herramientas de Build

```bash
java -version
javac -version
choco install temurin17 -y

mvn -version
choco install maven -y

gradle -v
choco install gradle -y
```

---

## 🌐 Node.js, npm y Testing

```bash
node -v
npm -v
choco install nodejs-lts -y

npx jest --version
npx mocha --version
npx nyc --version

npm install -g jest nyc mocha
```

---

## 🐍 Python

```bash
python --version
pip --version
choco install python -y

pytest --version
pip install pytest pytest-cov
```

---

## 🐘 PHP y PHPUnit

```bash
php -v
choco install php -y

composer -v
choco install composer -y

phpunit --version
```

🔧 Configuración para PHPUnit:

1. Edita `php.ini` (`C:\tools\php84`) y habilita:

```
extension=mbstring
extension=ctype
extension=dom
extension=json
extension=libxml
extension=tokenizer
extension=xml
extension=xmlwriter
```

2. Descarga PHPUnit:

```bash
cd C:\tools
curl -L https://phar.phpunit.de/phpunit-10.phar -o phpunit.phar
echo @php "%~dp0phpunit.phar" %* > phpunit.bat
```

3. Agrega `C:\tools` al `PATH` y podrás usar `phpunit` directamente.

---

## 🟦 .NET SDK y Herramientas

```bash
dotnet --version
choco install dotnet-sdk -y

dotnet tool list -g
```

📄 Copia `NuGet.Config` desde `%AppData%\NuGet\NuGet.Config` como `NuGet-Official.Config`

```bash
dotnet tool install --global dotnet-reportgenerator-globaltool --configfile "C:\Users\<TU_USUARIO>\AppData\Roaming\NuGet\NuGet-Official.Config"
dotnet tool install --global dotnet-sonarscanner --configfile "C:\Users\<TU_USUARIO>\AppData\Roaming\NuGet\NuGet-Official.Config"
```

---

## ✅ ¡Todo Listo!

Ya tienes las herramientas necesarias para que el script `.bat`:

- Levante un entorno en Docker
- Ejecute pruebas de Postman con Newman
- Envíe resultados y métricas a SonarQube
- Compile y analice código de proyectos en varios lenguajes

---