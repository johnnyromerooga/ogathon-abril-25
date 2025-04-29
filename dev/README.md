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

---

## 🧪 4. Evaluación

### 🎯 Objetivo específico

Se solicita calcular el **número de patrones distintos** cuando la **distancia es igual a 91**.

---

# 🔐 Reto 2 – Cifrado mediante secuencias

## 🧾 1. Introducción

Para desarrollar un **sistema de cifrado**, se necesita implementar un **algoritmo** que **identifique los números enteros** que cumplan una característica específica.

🔢 **Procedimiento**:

Se forma una secuencia a partir de un número entero, donde cada elemento se calcula **sumando los cuadrados de los dígitos** del número anterior.

### 📚 Ejemplos:

- **44** → (4² + 4²) = **32** → (3² + 2²) = **13** → (1² + 3²) = **10** → (1² + 0²) = **1** → (1²) = **1** → …
- **2** → 4 → 16 → 37 → 58 → 89 → 145 → 42 → 20 → 4 → …

🔎 **Observación:**  
Las cadenas que contienen **1** o **89** generan **ciclos**.

---

## 🎯 Objetivo del reto

Desarrollar un algoritmo que **calcule el número de enteros menores o iguales** a un **máximo dado** que, al formar su secuencia, **terminen generando un ciclo con el número 89**.

---

## 📊 2. Datos

Aquí tienes algunos ejemplos para probar tu algoritmo:

| 🔢 Máximo | 🔄 N° de enteros que generan ciclos con 89 |
|----------|--------------------------------------------|
| 2        | 1                                          |
| 7        | 2                                          |
| 44       | 34                                         |
| 85       | 70                                         |

---

## ⚙️ 3. Indicaciones técnicas

Tu solución debe cumplir los siguientes requisitos:

### 📡 API REST

- Debe estar disponible vía **API REST** a través del siguiente **endpoint**:

```
GET http://localhost:8080/challenges/solution-2?n=
```

- 🔸 El parámetro `n` es el **máximo valor** para encontrar enteros menores o iguales que generan secuencias que contengan el número 89.

### 📥 Ejemplo de uso

**Solicitud:**

```
GET http://localhost:8080/challenges/solution-2?n=85
```

**Respuesta esperada:**

```
70
```

> 🧠 La respuesta debe ser el **valor numérico directo**, sin estructura JSON ni envoltorios adicionales.

---

## 🏆 4. Evaluación

El **ganador del reto** será **la primera persona** que:

- Implemente correctamente el **algoritmo** solicitado.
- Informe del **resultado obtenido** para el caso:

> **🔢 Máximo = 9100**

---

# ♻️ Reto 3 – Reciclaje efectivo

## 🧾 1. Introducción

Para desarrollar un **sistema de reciclaje**, se necesita implementar un **algoritmo** que **calcule los movimientos necesarios** para que los residuos queden **perfectamente separados**.

### 🗑️ Tipos de residuos

Los contenedores pueden contener mezclas de:

- 🧪 Vidrio
- 📦 Cartón
- 🧴 Plástico

---

## 🎯 Objetivo del reto

Calcular el **número mínimo de movimientos** necesarios para lograr que cada contenedor contenga **únicamente un tipo de residuo**.

---

## 📊 2. Datos

### 📚 Ejemplo de distribución inicial:

| Contenedor | Vidrio | Cartón | Plástico |
|------------|--------|--------|----------|
| 1          | 2      | 0      | 1        |
| 2          | 0      | 3      | 1        |
| 3          | 1      | 1      | 1        |

🔎 **Resultado esperado:**  
El **mínimo número de movimientos** para separar los residuos correctamente es **4**:

- ➡️ Mover **1 plástico** del contenedor 1.
- ➡️ Mover **1 plástico** del contenedor 2.
- ➡️ Mover **1 vidrio** y **1 cartón** del contenedor 3.

---

## ⚙️ 3. Indicaciones técnicas

Tu solución debe cumplir los siguientes requisitos:

### 📡 API REST

- Debe estar disponible vía **API REST** a través del siguiente **endpoint**:

```
POST http://localhost:8080/challenges/solution-3
```

- 🔸 El **Body** de la solicitud será una **matriz de enteros (int[][])**, donde:
  - La **primera posición** representa el **contenedor**.
  - La **segunda posición** representa el **tipo de residuo**.

### 📥 Ejemplo de Body (caso anterior)

```json
[
  [2, 0, 1],
  [0, 3, 1],
  [1, 1, 1]
]
```

### 📤 Respuesta esperada

Debe ser **directamente el valor numérico** que indica el **mínimo número de movimientos** necesarios.

**Ejemplo de respuesta:**

```
4
```

> 🧠 La respuesta debe ser un **valor numérico simple**, sin estructuras JSON adicionales.

---

## 🏆 4. Evaluación

El **ganador del reto** será **la primera persona** que:

- ✅ Implemente correctamente el **algoritmo solicitado**.
- 📣 Informe del **resultado obtenido** para el siguiente caso:

| Contenedor | Vidrio | Cartón | Plástico |
|------------|--------|--------|----------|
| 1          | 1      | 3      | 2        |
| 2          | 2      | 1      | 3        |
| 3          | 3      | 2      | 1        |

---

# Indicaciones comunes

## 📚 Documentación de la API

- La API debe estar documentada mediante **OpenAPI** (por ejemplo, con **Swagger**).
- Debe ser accesible desde:

```
http://localhost:8080/swagger
```

- La documentación debe ser lo más **completa posible**, incluyendo parámetros, respuestas esperadas y ejemplos.

---

La API deberá ser **desplegable en un contenedor Docker**, escuchando en el **puerto 8080**.

## 📁 Estructura del repositorio

El repositorio debe tener la siguiente estructura:

```
ogathon/
├── src/
│   ├── (código de la solución)
├── Dockerfile
```

> Todos los retos de desarrollo estarán incluidos en un **único repositorio**. Habrá **un solo `Dockerfile`** que desplegará la API con un **endpoint disponible para cada reto**.

---

## ⚙️ Comandos de construcción y despliegue

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

## 🏁 Puntuación

La puntuación total de los **retos de desarrollo** será de **100 puntos**, distribuidos del siguiente modo:

### 🧠 Cada reto (máx. 24 puntos)

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
