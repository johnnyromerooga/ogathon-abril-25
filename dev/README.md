![Logo OGA](https://github.com/johnnyromerooga/ogathon-abril-25/blob/main/imgs/logo-oga.png?raw=true)


# 🦠 Reto 1 – Predicción de propagación vírica

## 🧾 1. Introducción

Para desarrollar un sistema de predicción en el ámbito sanitario, necesitamos implementar un **algoritmo** que calcule el **número de patrones de propagación** de un virus.

### 🔬 Formas de propagación

El virus se propaga en un momento determinado de dos formas:

- **Forma A**: salto a una **célula contigua** (📏 distancia = 1)
- **Forma B**: salto a una **célula inmediatamente posterior** a la contigua (📏 distancia = 2)

---

## 🎯 Objetivo del reto

Desarrollar un algoritmo que calcule **cuántos patrones diferentes** existen para que la propagación alcance una **distancia determinada**, bajo las siguientes condiciones:

- El virus se propaga en una **única dimensión**.
- La propagación ocurre en **un único sentido**.

### 📌 Ejemplo

Si la distancia es **3**, los patrones posibles son:

- `"AB"`
- `"BA"`
- `"AAA"`

🧠 **Total de patrones distintos: 3**

![Reto 1](https://github.com/johnnyromerooga/ogathon-abril-25/blob/main/imgs/reto-dev-1.png?raw=true)

---

## 📊 2. Datos

Aquí tienes algunos ejemplos para que puedas probar tu algoritmo:

| 📏 Distancia | 🔢 Nº de patrones         |
|--------------|---------------------------|
| 3            | 3                         |
| 10           | 89                        |
| 20           | 10,946                    |
| 50           | 20,365,011,074            |

---

## ⚙️ 3. Indicaciones técnicas

Tu algoritmo debe cumplir los siguientes requisitos técnicos:

### 📡 API REST

- Debe estar disponible vía **API REST** a través del siguiente **endpoint**:

```
GET http://localhost:8080/challenges/solution-1?n=
```

- 🔸 El parámetro `n` representa la **distancia objetivo** desde la cual se debe calcular el número de patrones.

### 📥 Ejemplo de uso

**Solicitud:**

```
GET http://localhost:8080/challenges/solution-1?n=20
```

**Respuesta esperada:**

```
10946
```

> La respuesta debe ser el **valor numérico plano**, sin etiquetas ni estructuras adicionales.

### 📚 Documentación de la API

- La API debe estar documentada mediante **OpenAPI** (por ejemplo, con **Swagger**).
- Debe ser accesible desde:

```
http://localhost:8080/swagger
```

- La documentación debe ser lo más **completa posible**, incluyendo parámetros, respuestas esperadas y ejemplos.

---

La API deberá ser **desplegable en un contenedor Docker**, escuchando en el **puerto 8080**.

### 📁 Estructura del repositorio

El repositorio debe tener la siguiente estructura:

```
ogathon/
├── src/
│   ├── (código de la solución)
├── Dockerfile
```

> Todos los retos de desarrollo estarán incluidos en un **único repositorio**. Habrá **un solo `Dockerfile`** que desplegará la API con un **endpoint disponible para cada reto**.

---

### ⚙️ Comandos de construcción y despliegue

Desde la raíz del repositorio (`C:\Repos\Dev\ogathon`), ejecuta los siguientes comandos:

```bash
cd C:\Repos\Dev\ogathon
docker build -t ogathon-challenges-api -f Dockerfile .
docker run -d -p 8080:8080 --env ASPNETCORE_HTTP_PORTS=8080 --name ogathon-challenges-api ogathon-challenges-api
```

- 🏗️ `docker build`: compila la imagen Docker con el nombre `ogathon-challenges-api`
- 🚀 `docker run`: ejecuta el contenedor, exponiendo el puerto `8080`
- 🌍 La API debe estar accesible en: `http://localhost:8080`

---

Perfecto, aquí tienes el bloque final en **Markdown** con formato amigable y emojis para resaltar la información clave:

---

## 🧪 4. Evaluación

### 🎯 Objetivo específico

Se solicita calcular el **número de patrones distintos** cuando la **distancia es igual a 91**.

---

## 🏁 5. Puntuación

La puntuación total de los **retos de desarrollo** será de **100 puntos**, distribuidos del siguiente modo:

### 🧠 Reto 1 – Predicción de propagación vírica (máx. 24 puntos)

| 📌 Criterio                      | 💯 Puntos |
|---------------------------------|-----------|
| ✅ Exposición vía API y Docker  | 12        |
| 🔢 Resultado correcto            | 8         |
| ⚡ Tiempos de respuesta          | 4         |

#### ⚡ Escala de tiempos:

- ≤ 100ms → 4 puntos
- 101ms - 500ms → 2 puntos
- 501ms - 1s → 1 punto
- > 1s → 0 puntos

---

### 📚 Evaluación global en retos de desarrollo (hasta 28 puntos adicionales)

| 📌 Criterio                        | 💯 Puntos | 📝 Detalles |
|----------------------------------|-----------|-------------|
| 📄 Documentación OpenAPI         | 5         | Completa y accesible |
| 🧼 Calidad del código             | 20        | Ver siguiente tabla |
| ⏱️ Tiempo de resolución total     | 3         | Para el equipo más rápido en resolver los 3 retos |

#### 🧼 Desglose de calidad del código:

- **Bugs y vulnerabilidades** (máx. 8 pts):
  - 0 errores → 8 pts
  - 1–3 errores → 4 pts
  - 4+ errores → 0 pts

- **Code Smells** (máx. 4 pts):
  - <10 → 4 pts
  - 10–20 → 2 pts
  - >20 → 0 pts

- **Cobertura de código** (máx. 8 pts):
  - ≥85% → 8 pts
  - 70–85% → 4 pts
  - <70% → 0 pts

---

### 🛠️ Lenguaje de programación

Es de **libre elección**, siempre y cuando permita cumplir con **todos los requisitos técnicos**:

- Exposición vía API
- Docker
- Documentación OpenAPI
- Buen rendimiento

---