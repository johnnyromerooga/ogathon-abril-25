@echo off
setlocal enabledelayedexpansion

:: Ruta base del script
set "BASE=%~dp0"
pushd "%BASE%..\repos"
set "REPOS=%CD%"
popd

:: Bucle por cada proyecto
for /D %%P in ("%REPOS%\*") do (

	echo.
	echo ==================================================
    echo Procesando proyecto: %%~nxP
    echo ==================================================

	set "CONTEXT=%%~fP"
    set "PROJECT_DIR=!CONTEXT!\src"
	set "FOLDER_NAME=%%~nP"
	
	:: Docker
	echo.
	echo ==================================================
    echo Dockerizando...
    echo ==================================================
	
	set "DOCKERFILE=!CONTEXT!\Dockerfile"
	set "CONTAINER_NAME=ogathon-challenges-api"
	set "IMAGE_NAME=ogathon-challenges-api"
	set "PORT=8080"
	
	echo Stopping and removing existing container if it exists...
	docker stop !CONTAINER_NAME!
	docker rm !CONTAINER_NAME!
	
	echo Building Docker image...
	docker build -t !IMAGE_NAME! -f "!DOCKERFILE!" "!CONTEXT!"

	echo Running container...
	docker run -d -p !PORT!:!PORT! --env ASPNETCORE_HTTP_PORTS=!PORT! --name !CONTAINER_NAME! !IMAGE_NAME!

	echo Waiting for container to start...
	timeout /t 10 /nobreak >nul
	
	:: Postman
	echo.
	echo ==================================================
    echo Ejecutando la pruebas de Postman con Newman...
    echo ==================================================
	
	set "COLLECTION=%BASE%Ogathon.postman_collection.json"
	call newman run "!COLLECTION!" --timeout-request 30000 --reporters cli,html --reporter-html-export !CONTEXT!\postman\postman-report.html --reporter-cli-no-success-assertions
	
	:: SonarQube
	echo.
	echo ==================================================
    echo Revisando la calidad del codigo y cobertura con SonarQube... 
    echo ==================================================
	
	set "SONAR_PROPS=_sonar-project.properties"
	set "SONAR_TOKEN=sqa_d6d4b7a17c0bc2b67296894ee9bc2edb2906f860"
	set "SONAR_PROJECT=!FOLDER_NAME!-api"
	set "SONAR_URL=http://localhost:9000"
	
	:: Java con Maven
	if exist !PROJECT_DIR!\pom.xml (
		echo Proyecto detectado: Java con Maven
		copy !PROJECT_DIR!\pom.xml !CONTEXT!
		call mvn -f !CONTEXT!\pom.xml clean verify
		
		echo -----------------------------------------------
		echo Ejecutando SonarQube...
		echo -----------------------------------------------
		
		call sonar-scanner ^
			-Dproject.settings=!SONAR_PROPS! ^
			-Dsonar.projectBaseDir=!CONTEXT! ^
			-Dsonar.projectKey=!SONAR_PROJECT! ^
			-Dsonar.projectName=!SONAR_PROJECT! ^
			-Dsonar.java.binaries=!CONTEXT!\target\classes ^
			-Dsonar.junit.reportPaths=!CONTEXT!\target\surefire-reports ^
			-Dsonar.coverage.jacoco.xmlReportPaths=!CONTEXT!\target\site\jacoco\jacoco.xml
	)

	:: Java con Gradle
	if exist !PROJECT_DIR!\build.gradle.kts (
		echo Proyecto detectado: Java con Gradle
		copy !PROJECT_DIR!\build.gradle.kts !CONTEXT!
		call gradle -p !CONTEXT! test jacocoTestReport
		
		echo -----------------------------------------------
		echo Ejecutando SonarQube...
		echo -----------------------------------------------
		
		call sonar-scanner ^
		  -Dproject.settings=!SONAR_PROPS! ^
		  -Dsonar.projectBaseDir=!CONTEXT! ^
		  -Dsonar.projectKey=!SONAR_PROJECT! ^
		  -Dsonar.projectName=!SONAR_PROJECT! ^
		  -Dsonar.java.binaries=!CONTEXT!\build\classes ^
		  -Dsonar.junit.reportPaths=!CONTEXT!\build\test-results\test ^
		  -Dsonar.coverage.jacoco.xmlReportPaths=!CONTEXT!\build\reports\jacoco\test\jacocoTestReport.xml
	)

	:: JavaScript / TypeScript
	if exist !PROJECT_DIR!\package.json (
		echo Proyecto detectado: JavaScript / TypeScript
		
		pushd !PROJECT_DIR!
		call npm install
		
		if exist !PROJECT_DIR!\jest.config.js (
			call npx jest --coverage --coverageReporters=lcov --coverageReporters=cobertura
		) else if exist !PROJECT_DIR!\nyc.config (
			call npx nyc --reporter=lcov mocha
		)
		
		popd
		
		echo -----------------------------------------------
		echo Ejecutando SonarQube...
		echo -----------------------------------------------
		
		call sonar-scanner ^
		  -Dproject.settings=!SONAR_PROPS! ^
		  -Dsonar.projectBaseDir=!CONTEXT! ^
		  -Dsonar.projectKey=!SONAR_PROJECT! ^
		  -Dsonar.projectName=!SONAR_PROJECT! ^
		  -Dsonar.sources=!PROJECT_DIR! ^
		  -Dsonar.javascript.lcov.reportPaths=!PROJECT_DIR!\coverage\lcov.info ^
		  -Dsonar.javascript.coverage.reportPaths=!PROJECT_DIR!\coverage\cobertura-coverage.xml
	)

	:: Python
	if exist !PROJECT_DIR!\pytest.ini (
		echo Proyecto detectado: Python
		pushd !CONTEXT!
		
		call python -m pip install -r !PROJECT_DIR!\requirements.txt
		call pytest -c !PROJECT_DIR!\pytest.ini !PROJECT_DIR! --cov=!PROJECT_DIR! --cov-report=xml:!PROJECT_DIR!\coverage.xml --cov-report=html:!CONTEXT!\coverage
		popd
		
		echo -----------------------------------------------
		echo Ejecutando SonarQube...
		echo -----------------------------------------------
		
		call sonar-scanner ^
		  -Dproject.settings=!SONAR_PROPS! ^
		  -Dsonar.projectBaseDir=!CONTEXT! ^
		  -Dsonar.projectKey=!SONAR_PROJECT! ^
		  -Dsonar.projectName=!SONAR_PROJECT! ^
		  -Dsonar.sources=!PROJECT_DIR! ^
		  -Dsonar.python.coverage.reportPaths=!PROJECT_DIR!\coverage.xml
	)

	:: PHP
	if exist !PROJECT_DIR!\phpunit.xml (
		echo Proyecto detectado: PHP
		
		pushd !PROJECT_DIR!
		call composer init --no-interaction --name="vendor/!FOLDER_NAME!" --require-dev="phpunit/phpunit:^10.5"
		
		(
			echo {
			echo   "name": "vendor/!FOLDER_NAME!",
			echo   "require-dev": {
			echo     "phpunit/phpunit": "^10.5"
			echo   },
			echo   "autoload": {
			echo     "psr-4": {
			echo       "": "./"
			echo     }
			echo   }
			echo }
		) > composer.json
		
		call composer update
		call composer install
		call composer dump-autoload
		call vendor\bin\phpunit --coverage-clover coverage.xml
		::call phpdbg -qrr vendor\bin\phpunit --coverage-clover coverage.xml
		popd
		
		echo -----------------------------------------------
		echo Ejecutando SonarQube...
		echo -----------------------------------------------
		
		call sonar-scanner ^
		  -Dproject.settings=!SONAR_PROPS! ^
		  -Dsonar.projectBaseDir=!CONTEXT! ^
		  -Dsonar.projectKey=!SONAR_PROJECT! ^
		  -Dsonar.projectName=!SONAR_PROJECT! ^
		  -Dsonar.sources=!PROJECT_DIR! ^
		  -Dsonar.php.coverage.reportPaths=!CONTEXT!\coverage.xml
	)

	:: .NET
	for %%s in (!PROJECT_DIR!\*.sln) do (
		echo Proyecto detectado: .NET		
		pushd !CONTEXT!
		
		call dotnet sonarscanner begin ^
			/k:!SONAR_PROJECT! ^
			/n:!SONAR_PROJECT! ^
			/d:sonar.host.url=!SONAR_URL! ^
			/d:sonar.token=!SONAR_TOKEN! ^
			/d:sonar.projectBaseDir=!CONTEXT! ^
			/d:sonar.exclusions="**/bin/**/*,**/obj/**/*,**/Migrations/**" ^
			/d:sonar.coverage.exclusions="test/**" ^
			/d:sonar.cs.opencover.reportsPaths=!CONTEXT!\coverage\coverage.opencover.xml ^
			/d:sonar.language="cs" ^
			/d:sonar.scm.disabled=true ^
			/d:sonar.scanner.scanAll=false
		
		call dotnet build "%%s"
		call dotnet test "%%s" /p:CollectCoverage=true /p:CoverletOutputFormat=opencover /p:CoverletOutput=!CONTEXT!\coverage\coverage.opencover.xml /p:IncludeTestAssembly=true
		call reportgenerator -reports:!CONTEXT!\coverage\coverage.opencover.xml -targetdir:!CONTEXT!\coverage -reporttypes:Html
		call dotnet sonarscanner end /d:sonar.token=!SONAR_TOKEN!
		popd
	)
	
	echo --- FIN DEL PROYECTO %%~nxP ---

    echo.
    echo Presiona una tecla para continuar al siguiente proyecto...
    pause >nul
)

echo.
echo === TODOS LOS PROYECTOS HAN SIDO PROCESADOS ===
endlocal
pause