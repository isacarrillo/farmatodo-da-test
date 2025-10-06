![Farmatodo Logo](https://upload.wikimedia.org/wikipedia/commons/2/27/Farmatodo_logo.svg)
# 🏥 Test Técnico - Data Analyst Junior en Farmatodo
## ¡Bienvenido/a! 👋
Gracias por tu interés en formar parte del equipo de **Farmatodo**, líder en retail farmacéutico en Latinoamérica. Este repositorio contiene la prueba técnica para la posición de **Data Analyst Junior** en nuestro equipo de Datos y Analítica.

---

# Prueba Técnica - Analista de Datos
## Farmatodo - Análisis de Ventas

---

## 📋 Contexto

Farmatodo es una cadena de farmacias retail que opera en Venezuela con más de 100 tiendas distribuidas en diferentes regiones del país. La empresa maneja un Data Warehouse en Databricks con información de ventas, productos, tiendas, proveedores y canales de venta.

Como Analista de Datos, tu misión es analizar el desempeño de ventas del último trimestre (Julio - Septiembre 2025) y generar insights accionables para el equipo de negocio.

---

## 🎯 Objetivos de la Prueba

Esta prueba evalúa tus capacidades en:
- Análisis exploratorio de datos
- Validación y calidad de datos
- Creación de tablas analíticas
- Construcción de dashboards interactivos en Databricks
- Comunicación de insights de negocio

**Duración estimada:** 3-4 horas

---

## 🚀 Configuración Inicial

Antes de comenzar la prueba, debes configurar tu ambiente de trabajo:

### Paso 1: Crear Cuenta en Databricks Community Edition

1. Ve a [https://www.databricks.com/try-databricks](https://www.databricks.com/try-databricks)
2. Selecciona **"Get started for free"**
3. Escoge **"Community Edition"**
4. Completa el registro con tu email
5. Verifica tu cuenta mediante el correo de confirmación
6. Inicia sesión en tu workspace de Databricks

### Paso 2: Fork del Repositorio

1. Ve al repositorio de GitHub: [Test Farmatodo](https://github.com/ftd-farmatodo/ftd-da-databricks-test)
2. Haz click en el botón **"Fork"** en la esquina superior derecha
3. Esto creará una copia del repositorio en tu cuenta de GitHub
4. Asegúrate de que el fork sea **público** para que podamos revisar tu trabajo

### Paso 3: Conectar el Repositorio a Databricks

1. En tu workspace de Databricks, ve a **"Workspace"** en el menú lateral izquierdo
2. Click derecho en tu carpeta de usuario y selecciona **"Create" > "Repo"**
3. En "Git repository URL", pega la URL de tu fork
4. En "Git provider", selecciona **"GitHub"**
5. Click en **"Create Repo"**
6. Databricks clonará tu repositorio

### Paso 4: Generar los Datos

1. En el repositorio importado, navega a la carpeta `notebooks/`
2. Abre el notebook **`data_generator`**
3. Asegúrate de tener un cluster en ejecución. (Por defecto deberías tener un cluster serverless)
4. Ejecuta **todas las celdas** del notebook en orden
5. Este proceso generará las tablas necesarias en el schema `workspace.operations`
6. La generación tomará aproximadamente 5-10 minutos
7. Verifica que las tablas se crearon correctamente ejecutando:
   ```sql
   SHOW TABLES IN workspace.operations
   ```

**¡Ahora estás listo para comenzar la prueba!**

---

## 📊 Estructura de Datos

Las tablas están disponibles en el schema `workspace.operations`:

### Tablas Dimensionales

#### `gold_dim_product`
Catálogo de productos de la cadena.
- **SK_PRODUCT**: Surrogate key del producto
- **ITEM**: Código del producto
- **ITEM_DESC**: Descripción del producto
- **CLASS_NAME**: Clase del producto (Analgésicos, Shampoo, etc.)
- **DEPT_NAME**: Departamento (Medicamentos, Cuidado Personal, etc.)
- **BRAND_NAME**: Marca del producto
- **STATUS**: Estado (A=Activo, I=Inactivo)

#### `gold_dim_organization`
Información de tiendas.
- **SK_ORGANIZATION**: Surrogate key de la tienda
- **STORE_ID**: ID de la tienda
- **STORE_NAME**: Nombre de la tienda
- **CITY**: Ciudad
- **REGION_NAME**: Región (Capital, Occidente, Centro, Oriente)
- **FORMAT_NAME**: Formato de tienda (Express, Plus, Super, Mega)
- **STORE_ACTIVE**: Estado de la tienda (Y/N)

#### `gold_dim_supplier`
Catálogo de proveedores.
- **SK_SUPPLIER**: Surrogate key del proveedor
- **SUPPLIER**: ID del proveedor
- **SUP_NAME**: Nombre del proveedor
- **SUP_STATUS**: Estado del proveedor (A/I)

#### `gold_dim_channel`
Canales de venta.
- **SK_CHANNEL**: Surrogate key del canal
- **CHANNEL_NAME**: Nombre del canal (Tienda Física, E-Commerce, App Móvil, Call Center)
- **CHANNEL_TYPE_NAME**: Tipo de canal (Retail, Online, Telefónico)

#### `gold_dim_currency`
Monedas utilizadas.
- **SK_CURRENCY**: Surrogate key de moneda
- **CURRENCY_ABR**: Abreviatura (VES, USD)
- **CURRENCY_NAME**: Nombre de la moneda

### Tabla de Hechos

#### `gold_fact_sales_product`
Transacciones de venta del trimestre Julio-Septiembre 2025.
- **BUSINESS_DATE**: Fecha de la transacción
- **SK_PRODUCT**: FK a dim_product
- **SK_ORGANIZATION**: FK a dim_organization
- **SK_SUPPLIER**: FK a dim_supplier
- **SK_CHANNEL**: FK a dim_channel
- **SK_CURRENCY**: FK a dim_currency
- **TOTAL_SALE**: Venta total sin impuesto
- **TOTAL_SALE_TAX**: Venta total con impuesto
- **TAX**: Impuesto (IVA 16%)
- **TOTAL_COST**: Costo total
- **UNITS**: Unidades vendidas
- **Q_TRANS**: Cantidad de transacciones (siempre 1)

---

## 📝 Tareas

### **Parte 1: Validación de Datos (30 minutos)**

Antes de comenzar cualquier análisis, es fundamental validar la calidad de los datos.

#### 1.1 Análisis Exploratorio Inicial

Crea un notebook llamado `01_validacion_datos` en la carpeta `notebooks/` de tu repositorio con las siguientes validaciones:

**a) Conteo de registros por tabla**

Valida:
- ¿Cuántas transacciones hay en total?
- ¿Cuántos productos activos existen?
- ¿Cuántas tiendas activas hay?
- ¿Cuántos proveedores activos?

**b) Validación de rango de fechas**

Confirma que los datos cubren julio-septiembre 2025 completo.

**c) Validación de integridad referencial**

Verifica que todas las foreign keys en la tabla de hechos tengan correspondencia en las dimensiones.

Valida para: SK_PRODUCT, SK_ORGANIZATION, SK_SUPPLIER, SK_CHANNEL, SK_CURRENCY

**d) Validación de valores nulos y negativos**

Identifica si existen:
- Ventas nulas
- Ventas negativas
- Unidades inválidas (nulas o <= 0)

**e) Validación de consistencia de cálculos**

Verifica que las relaciones matemáticas sean correctas:
- TOTAL_SALE + TAX = TOTAL_SALE_TAX

#### 1.2 Documento de Hallazgos

Al final del notebook, en una celda markdown, crea un resumen que incluya:
- ✅ Validaciones que pasaron exitosamente
- ⚠️ Problemas encontrados (si los hay)
- 📋 Recomendaciones para mejorar la calidad de datos

---

### **Parte 2: Creación de Tabla Analítica (45 minutos)**

Crea una tabla agregada optimizada para análisis de negocio que responda preguntas clave.

#### 2.1 Especificaciones de la Tabla

Crea un notebook llamado `02_tabla_analitica` y en él crea la tabla `workspace.operations.gold_sales_daily_summary` con la siguiente estructura:

**Dimensiones de agregación:**
- Fecha (día, año, mes, día del mes, día de la semana)
- Tienda (ID, nombre, ciudad, región, formato)
- Producto (código, descripción, departamento, clase, marca)
- Proveedor (nombre)
- Canal (nombre, tipo)
- Moneda (abreviatura)

**Métricas a incluir:**
- Venta total (sin impuesto)
- Venta total (con impuesto)
- Impuesto total
- Costo total
- Margen bruto (venta - costo)
- Porcentaje de margen bruto
- Unidades vendidas
- Número de transacciones
- Ticket promedio (venta con impuesto / transacciones)
- Unidades por transacción

#### 2.2 Implementación

Escribe y ejecuta una query SQL que:
1. Una la tabla de hechos con todas las dimensiones necesarias usando INNER JOIN
2. Calcule todas las métricas requeridas
3. Seleccione todos los campos especificados
4. Guarde el resultado como tabla Delta

#### 2.3 Validación de la Tabla Creada

Al final del notebook, valida:
- Número total de registros de la tabla creada
- Que la suma de TOTAL_SALE coincida entre la tabla original y la nueva
- Que no haya valores nulos en campos críticos

---

### **Parte 3: Dashboard de Análisis (90 minutos)**

Crea un dashboard interactivo en Databricks SQL que presente insights clave del negocio.

#### 3.1 Creación del Dashboard

1. En Databricks, ve a la sección **"SQL"** en el menú lateral
2. Click en **"Dashboards"**
3. Click en **"Create Dashboard"**
4. Nombra tu dashboard: **"Análisis de Ventas Q3 2025"**

#### 3.2 Queries y Visualizaciones Requeridas

Debes crear queries SQL en **"SQL Editor"** y agregarlas como visualizaciones al dashboard. Tu dashboard debe incluir **mínimo 8 visualizaciones**:

**a) KPIs Principales (4 visualizaciones tipo "Counter")**
- Venta Total del Trimestre (TOTAL_SALE_TAX)
- Margen Bruto Total (suma de margen_bruto)
- % Margen Bruto Promedio
- Total de Transacciones

**b) Tendencia de Ventas (Gráfico de línea)**
- Ventas diarias (TOTAL_SALE_TAX) a lo largo del trimestre
- Eje X: BUSINESS_DATE
- Eje Y: suma de TOTAL_SALE_TAX

**c) Top 10 Productos (Gráfico de barras horizontal)**
- Los 10 productos con mayor venta
- Mostrar nombre del producto y venta total

**d) Desempeño por Región (Gráfico de barras)**
- Ventas totales por REGION_NAME
- Ordenar de mayor a menor

**e) Análisis de Canales (Gráfico de dona/pie)**
- Distribución de ventas por CHANNEL_NAME
- Mostrar % de participación

**f) Desempeño por Formato de Tienda (Gráfico de barras)**
- Ventas por FORMAT_NAME
- Incluir conteo de tiendas por formato

**g) Top 5 Proveedores (Gráfico de barras horizontal)**
- Los 5 proveedores con mayor venta (SUP_NAME)
- Mostrar venta total

**h) Análisis de Moneda (Gráfico de área apilada o barras apiladas)**
- Ventas por CURRENCY_ABR a lo largo del tiempo
- Mostrar evolución semanal o mensual

**i) Tabla de Mejores Tiendas (Tabla)**
- Top 10 tiendas por venta
- Columnas: STORE_NAME, CITY, TOTAL_SALE_TAX, MARGEN_BRUTO, PCT_MARGEN

#### 3.3 Filtros y Parámetros

Agrega al menos 3 filtros de dashboard:
- Rango de fechas (date range)
- Región (dropdown/multiselect)
- Formato de tienda (dropdown/multiselect)

#### 3.4 Organización del Dashboard

- Organiza las visualizaciones de manera lógica y estética
- Agrupa visualizaciones relacionadas
- Usa títulos descriptivos para cada visualización
- Asegúrate de que el dashboard sea fácil de leer y navegar

---

### **Parte 4: Insights y Recomendaciones (45 minutos)**

#### 4.1 Análisis de Negocio

Crea un notebook llamado `03_insights_negocio` donde respondas las siguientes preguntas con queries SQL y análisis:

**Desempeño General:**
1. ¿Cuál fue el mes con mejor desempeño en ventas?
2. ¿Cuál es el margen bruto promedio de la compañía?
3. ¿Qué día de la semana genera más ventas?

**Análisis por Producto:**
4. ¿Cuál es el departamento con mayor margen bruto?
5. ¿Qué marca genera más ventas?
6. ¿Cuáles son los 3 productos con menor rotación (unidades vendidas)?

**Análisis Geográfico:**
7. ¿Qué región genera más ventas? ¿Y cuál tiene mejor margen?
8. ¿Cuáles son las 5 tiendas con mejor desempeño?
9. ¿Existe diferencia significativa de ventas entre formatos de tienda?

**Análisis de Canales:**
10. ¿Qué porcentaje de ventas proviene de canales digitales (E-Commerce + App)?
11. ¿Cuál es el ticket promedio por canal?
12. ¿Qué canal tiene mejor margen bruto?

**Análisis de Proveedores:**
13. ¿Cuáles son los 3 proveedores más importantes por volumen de venta?
14. ¿Qué porcentaje de las ventas totales representan los top 3 proveedores?

**Análisis Monetario:**
15. ¿Qué porcentaje de transacciones se realizan en dólares vs bolívares?
16. ¿Hay diferencia en el ticket promedio según la moneda?

Cada pregunta debe tener:
- La query SQL utilizada
- El resultado obtenido
- Una breve interpretación (2-3 líneas)

#### 4.2 Documento de Insights

Al final del mismo notebook `03_insights_negocio`, crea celdas markdown con:

**Sección 1: Resumen Ejecutivo**
- 3-5 insights principales del análisis
- Números clave del trimestre
- Tendencia general del negocio

**Sección 2: Hallazgos Detallados**
- Insights por categoría (productos, geografía, canales)
- Comparaciones relevantes encontradas
- Patrones identificados

**Sección 3: Oportunidades Identificadas**
- Al menos 3 oportunidades de mejora o crecimiento
- Cada una respaldada con datos específicos

**Sección 4: Recomendaciones Accionables**
- Mínimo 5 recomendaciones específicas
- Priorizadas por impacto potencial

**Formato de recomendación:**
```
📌 Recomendación: [Título claro y específico]
📊 Insight: [Dato concreto que la respalda]
🎯 Impacto esperado: [Alto/Medio/Bajo]
⚡ Acción: [Qué hacer específicamente y quién debe hacerlo]
```

---

## 📤 Entregables y Envío

### Estructura Final del Repositorio

Tu repositorio debe tener la siguiente estructura:

```
/
├── README.md (este archivo)
├── notebooks/
│   ├── data_generator.ipynb (original, no modificar)
│   ├── 01_validacion_datos.ipynb
│   ├── 02_tabla_analitica.ipynb
│   └── 03_insights_negocio.ipynb
├── sql/
│   └── dashboard_queries.sql (todas las queries usadas en el dashboard)
└── dashboard/
    └── dashboard_export.json (exportación del dashboard de Databricks)
```

### Pasos para Completar la Entrega

#### 1. Guardar las Queries del Dashboard

En Databricks SQL:
- Ve a cada query que usaste en el dashboard
- Copia el código SQL
- Pégalo en un archivo `sql/dashboard_queries.sql` en tu repositorio
- Organiza las queries con comentarios descriptivos:
  ```sql
  -- ======================
  -- KPI: Venta Total
  -- ======================
  SELECT ...
  
  -- ======================
  -- Gráfico: Tendencia de Ventas
  -- ======================
  SELECT ...
  ```

#### 2. Exportar el Dashboard

En Databricks SQL:
- Ve a tu dashboard
- Click en el menú de tres puntos (⋮) en la esquina superior derecha
- Selecciona **"Export"**
- Guarda el archivo JSON en la carpeta `dashboard/` de tu repositorio

#### 3. Commit y Push de Cambios

Desde Databricks:
1. Ve a **"Repos"** en el menú lateral
2. Click en tu repositorio
3. Verás una lista de archivos modificados
4. Click en **"Commit & Push"**
5. Escribe un mensaje de commit descriptivo: "Completar prueba técnica - Análisis de ventas Q3 2025"
6. Click en **"Commit & Push"**

Alternativamente, puedes usar Git desde tu terminal local:
```bash
git add .
git commit -m "Completar prueba técnica - Análisis de ventas Q3 2025"
git push origin main
```

#### 4. Verificación Final

Antes de completar, verifica que tu repositorio de GitHub contenga:
- ✅ Los 3 notebooks completados (01, 02, 03)
- ✅ El archivo dashboard_queries.sql con todas las queries
- ✅ El archivo dashboard_export.json
- ✅ Todos los archivos tienen commits recientes
- ✅ Tu repositorio es **público** para que podamos acceder a revisar tu trabajo

---

## ✅ Criterios de Evaluación

| Criterio | Peso | Descripción |
|----------|------|-------------|
| **Validación de Datos** | 20% | Exhaustividad de las validaciones, identificación de problemas, documentación |
| **Calidad del Código SQL** | 20% | Eficiencia, legibilidad, uso de mejores prácticas, comentarios |
| **Tabla Analítica** | 15% | Diseño de la tabla, cálculos correctos, estructura lógica, validaciones |
| **Dashboard** | 25% | Diseño visual, queries correctas, organización, claridad en visualizaciones |
| **Insights de Negocio** | 15% | Profundidad del análisis, insights accionables, respaldo con datos |
| **Comunicación** | 5% | Claridad en la presentación, estructura lógica, documentación en notebooks |

**Nota:** Se valora especialmente la capacidad de traducir datos en recomendaciones de negocio accionables y la claridad en la documentación del código.

---

## 💡 Tips para Tener Éxito

### Para la Validación de Datos:
- ✅ Piensa como un auditor: ¿qué podría estar mal?
- ✅ No asumas nada, valida todo
- ✅ Documenta tus hallazgos claramente en celdas markdown
- ✅ Usa visualizaciones simples si ayudan a entender los datos

### Para la Tabla Analítica:
- ✅ Diseña pensando en el usuario final del dashboard
- ✅ Incluye solo métricas que agreguen valor
- ✅ Usa nombres de columnas descriptivos y consistentes
- ✅ Comenta tu código SQL explicando la lógica
- ✅ Valida que los totales cuadren con la tabla original

### Para el Dashboard:
- ✅ Menos es más: enfócate en claridad sobre cantidad
- ✅ Usa colores consistentes y significativos
- ✅ Cada visualización debe responder una pregunta específica
- ✅ Organiza el dashboard en secciones lógicas (KPIs arriba, detalles abajo)
- ✅ Testea los filtros para asegurar que funcionan correctamente
- ✅ Usa títulos descriptivos en cada gráfico

### Para los Insights:
- ✅ Sé específico con los números (evita "muchos", usa "73%")
- ✅ Compara con contexto (mes anterior, promedio, etc.)
- ✅ No solo describas, explica el "por qué" y el "qué significa"
- ✅ Cada recomendación debe ser específica y accionable
- ✅ Prioriza recomendaciones por impacto potencial
- ✅ Usa markdown para hacer el documento visualmente atractivo

### Para Git y la Entrega:
- ✅ Haz commits frecuentes con mensajes descriptivos
- ✅ Revisa que todos los archivos estén en el repositorio antes de enviar
- ✅ Verifica que tu repositorio sea público
- ✅ Prueba que los notebooks se puedan ejecutar de principio a fin

---

## ❓ Preguntas Frecuentes

**P: ¿Puedo usar Python además de SQL?**
R: Sí, puedes usar Python para análisis adicionales o visualizaciones en los notebooks, pero SQL es obligatorio para las validaciones, creación de tabla y queries del dashboard.

**P: ¿Qué pasa si encuentro datos inconsistentes?**
R: Documéntalos en tu notebook de validación y explica cómo los manejaste (filtrado, exclusión, corrección asumida, etc.).

**P: ¿Puedo agregar análisis adicionales no solicitados?**
R: ¡Por supuesto! La iniciativa y creatividad son valoradas positivamente, siempre y cuando completes primero todo lo requerido.

**P: ¿Qué hago si Databricks Community Edition tiene limitaciones?**
R: Community Edition es suficiente para esta prueba. Si encuentras alguna limitación específica, documéntala y explica cómo la resolverías en un ambiente production.

**P: ¿Puedo consultar documentación en línea?**
R: Sí, puedes usar cualquier recurso en línea. Esta prueba evalúa tu capacidad de resolver problemas reales, no memorización.

**P: ¿Cómo exporto las queries del dashboard si están dentro del dashboard?**
R: En cada visualización del dashboard, hay un ícono de código/query que te permite ver y copiar el SQL. Copia cada query a tu archivo dashboard_queries.sql.

**P: ¿Qué pasa si no termino todo en 3-4 horas?**
R: La duración es estimada. Lo importante es la calidad del trabajo. Si necesitas más tiempo, tómalo, pero indícalo en el email de entrega.

---

## 🎓 Recursos Útiles

- [Documentación de Databricks SQL](https://docs.databricks.com/sql/index.html)
- [Databricks SQL Dashboards](https://docs.databricks.com/sql/user/dashboards/index.html)
- [Guía de Delta Lake](https://docs.delta.io/latest/index.html)
- [Databricks Community Edition](https://docs.databricks.com/getting-started/community-edition.html)
- [Git en Databricks Repos](https://docs.databricks.com/repos/index.html)

---

**¡Mucha suerte! Esperamos ver tu análisis y creatividad en acción. 🚀📊**

**Recuerda:** La clave está en demostrar tu capacidad de analizar datos, encontrar insights valiosos y comunicarlos de manera clara y accionable.