# 📚 Tarea-Facultad — Trabajo con Conjuntos de Sucesiones en Pascal

Implementación en **Pascal** de un módulo de manejo de sucesiones (conjuntos ordenados de enteros) con lista enlazada, desarrollado como trabajo práctico para la Facultad de Ingeniería (FING, Udelar).

---

## 📋 Descripción

El programa implementa las siguientes estructuras y operaciones:

### Estructura `Sucesion`
Un arreglo ordenado de números naturales sin repetición (simula un conjunto matemático).

### Estructura `ListaSucesiones`
Una lista enlazada de sucesiones.

### Operaciones implementadas

| Función / Procedimiento | Descripción |
|---|---|
| `CrearSucesion` | Inicializa una sucesión vacía |
| `AgregarValor` | Agrega un valor manteniendo el orden |
| `EstaEnSucesion` | Verifica si un valor existe |
| `SucesionesIguales` | Compara dos sucesiones |
| `FusionarSucesiones` | Une dos sucesiones (unión de conjuntos) |
| `CrearLista` | Inicializa una lista de sucesiones |
| `AgregarSucesion` | Agrega una sucesión a la lista |
| `TodasIguales` | Verifica si todas las sucesiones de la lista son iguales |
| `FusionarEnLista` | Fusiona dos sucesiones dentro de la lista |

---

## 🛠️ Tecnología

- **Pascal** (Free Pascal / Turbo Pascal)

---

## 🚀 Cómo compilar y ejecutar

**Con Free Pascal:**
```bash
fpc tarea.pas
./tarea
```

**Con Turbo Pascal:** Abrir el archivo `tarea.pas` directamente en el IDE.

---

## 📝 Conceptos aplicados

- Arreglos con tope (simulación de conjuntos)
- Listas enlazadas dinámicas con punteros
- Búsqueda e inserción ordenada
- Algoritmo de ordenamiento por inserción
- Operaciones de unión e intersección de conjuntos

---

## 👨‍💻 Autor

**Martin Olazabal** — Facultad de Ingeniería, Udelar
