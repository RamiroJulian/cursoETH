# KipuBank

## 🧾 Descripción

**KipuBank** es un contrato inteligente escrito en Solidity que permite a los usuarios depositar y retirar ETH en una boveda personal. Está diseñado con limites de seguridad para evitar retiros excesivos y depósitos que excedan la capacidad del banco.

Este contrato fue desarrollado como parte del trabajo práctico del curso **ETH Dev Pack** impartido por **ETHKIPU**. Su propósito es educativo y **no debe utilizarse en producción**.

### Funcionalidades principales:

- Depósitos de ETH en bovedas personales.
- Retiros limitados por transacción.
- Limite global de depósitos en el contrato.
- Registro de cantidad de depósitos y retiros por usuario.
- Emisión de eventos en cada operación exitosa.
- Validaciones con errores personalizados.
- Seguridad basada en buenas practicas de Solidity.

---

## 🚀 Instrucciones de despliegue

### Requisitos

- Remix IDE
- Una wallet como MetaMask
- Red de pruebas (Goerli, Sepolia, etc.)

### Pasos

1. Clonar el repositorio o copiar el contrato `KipuBank.sol` en tu proyecto.
2. Compilar y desplegar el contrato dentro del IDE.
     - Al desplegar el mismo, deberan ingresar como campos obligatorios los siguientes valores:
         - `_withdrawalLimit`: definir el limite de extracción mientras el contrato esté desplegado.
         - `_bankCap`: definir el limite de depositos mientras el contrato esté desplegado.   
6. Interactuar con el contrato a través de las opciones desplegadas por Remix.

## 🧑‍💻 Cómo interactuar con el contrato

Para interactuar con el contrato, deben utilizar las funciones `deposit` y `withdraw`, si elijen hacerlo desde el IDE de REMIX lo podran realizar desde el menu izquierdo donde encontraran el contrato desplegado segun las indicaciones anteriores.

### Funcion Depositar

Los pasos para usar la funcion `deposit` son:
1. En la seccion Deploy & run transactions de Remix deberan colocar un valor en el campo `value` (en wei, gwei o la medida de ETH que deseen).
2. Dentro de la sección Deployed Contracts del IDE presionar el boton `deposit` en rojo, que indica que el mismo dispara una funcion payable.
3. Verán la cantidad de ETH depositadas (en caso de tener balance en la cuenta seleccionada con la que desplegaron el contrato)

### Funcion Retirar (withdraw)

Los pasos para usar la funcion `withdraw` son:
1. Presionar el botón `withdraw` naranja dentro de la seccion Deployed Contracts.
2. Solamente veran el log de la transaccion en la consola que indicará si la interacción fue exitosa o no.

### Funciones de consulta

Existen varias funciones de consulta (botones azules en Remix) que solo arrojan valores almacenados, estas son:
1. `bankCap`: consultar el límite de depósitos.
2. `depositCount`: deben ingresar una direccion para consultar el contador de depósitos realizados mientras el contrato esta desplegado.
3. `getVaultBalance`: consultar el balance de la boveda.
4. `totalDeposited`: consultar el total depositado.
5. `withdrawalCount`: deben ingresar una direccion para consultar el contador de retiros realizados mientras el contrato está desplegado.
6. `withdrawalLimit`: limite de extracción.

