# REDSOCIAL-PUBLIC-FRONT

Este README proporciona un análisis más detallado del código Flutter en el frontend de tu aplicación. El código está estructurado para interactuar con una API backend, manejando autenticación de usuario, registro de usuarios, gestión de publicaciones y más.

## Estructura del Código

El código está organizado en una clase llamada `ApiService`, la cual encapsula métodos para realizar solicitudes HTTP e interactuar con la API backend. Cada método se corresponde con un endpoint específico de la API y es responsable de manejar la funcionalidad relacionada.

## Uso

1. **Inicialización:**
   - Asegúrate de reemplazar el marcador de posición `{TU URL DE LA API}` en la variable `baseUrl` con la URL real de tu API.
   - Sustituye `{TU TOKEN DDE AUTENTIFICACIÓN}` con tu token de autenticación.

2. **Inicio de Sesión:**
   - El método `loginWithJwt` inicia sesión con autenticación JWT. Reemplaza los marcadores de posición para nombre de usuario y contraseña según corresponda.

3. **Registro de Usuario:**
   - Utiliza el método `registerUser` para registrar un nuevo usuario. Proporciona un objeto `UserDTO` con los detalles del usuario.

4. **Gestión de Usuarios:**
   - El método `editUserDetails` permite editar la descripción y el correo electrónico de un usuario. Especifica los parámetros `userId`, `newDescription` y `newEmail`.

5. **Gestión de Publicaciones:**
   - Crea una publicación con el método `createPublication`. Proporciona un objeto `PublicationDTO` y el ID del usuario.
   - Recupera publicaciones con `getAllPublications` y filtra por ID de usuario con `getPublicationsByUserId`.

6. **Gestión de Seguidores/Seguidos:**
   - Sigue o deja de seguir a un usuario con `followUser` y `unfollowUser`. Proporciona los IDs del seguidor y seguido.
   - Verifica si un usuario sigue a otro con `isFollowing`.

7. **Comentarios de Publicaciones:**
   - Obtiene comentarios para una publicación con `getCommentsByPublicationId`.
   - Añade un comentario con `addComment`, proporcionando el ID de la publicación, ID de usuario y un objeto `CommentDTO`.

8. **Listas de Usuarios:**
   - Recupera todos los usuarios con `getAllUsers`.
   - Obtiene seguidores o usuarios que sigue un usuario con `getFollowersByUserId` y `getFollowingByUserId`.

## Manejo de Errores

- El código incluye manejo de errores para cada solicitud a la API. Se lanzan excepciones con mensajes descriptivos en caso de fallos.

## Depuración

- Se imprime información de depuración en la consola al ejecutarse en modo de depuración (`kDebugMode`). Ajusta el registro según sea necesario.

## Nota

- Asegúrate de implementar adecuadamente el manejo de errores y medidas de seguridad, como almacenar de forma segura los tokens de autenticación, en un entorno de producción.

# CommentDTO Class

Este archivo contiene la definición de la clase `CommentDTO` en Flutter, diseñada para representar comentarios en una base de datos. Aquí se proporciona una explicación detallada de la estructura y funciones de la clase.

## Avisos de Ignorar Nombres de Archivos

Se incluye la declaración `// ignore_for_file: file_names` para desactivar las advertencias relacionadas con la convención de nombres de archivos. Esto sugiere que el desarrollador ha optado por ignorar las convenciones de nomenclatura específicas para los nombres de archivos.

## Estructura de la Clase CommentDTO

### Atributos:

- `userId`: Identificador del usuario asociado al comentario.
- `publicationId`: Identificador de la publicación a la que pertenece el comentario.
- `creationDate`: Fecha y hora de creación del comentario.
- `text`: Contenido textual del comentario.

### Constructor:

- El constructor `CommentDTO` permite la creación de instancias de la clase con valores opcionales para los atributos.

### Métodos:

#### `fromJson` (Factoría para Crear desde Mapa):

- El método `fromJson` crea un objeto `CommentDTO` a partir de un mapa de datos (`json`). 
- Convierte los datos del mapa en los atributos correspondientes de la clase.

#### `parseDate` (Parseo de Fecha):

- Este método estático parsea una fecha en formato JSON a un objeto `DateTime`.
- Se utiliza para manejar fechas provenientes de la base de datos.
- Convierte una lista de datos en formato [año, mes, día, hora, minuto, segundo, milisegundo] en un objeto `DateTime`.
- Formatea la fecha y la imprime en la consola en modo de depuración.

#### `toJson` (Conversión a Mapa):

- El método `toJson` convierte un objeto `CommentDTO` a un mapa de datos.
- Prepara los datos para ser enviados o almacenados en formato JSON.

## Nota sobre el Formato de Fecha

- La fecha se maneja con un método específico `parseDate` para garantizar un manejo adecuado de las fechas provenientes de la base de datos.
- Se ajusta la fecha a la zona horaria local (`hour + 1`) y se formatea para facilitar la lectura y la depuración.

## Manejo de Errores

- Se incluyen bloques `try-catch` en los métodos que manejan fechas para atrapar posibles errores y registrarlos en modo de depuración.

## Uso de `kDebugMode`

- Se utiliza `kDebugMode` para imprimir información de depuración en la consola solo en modo de depuración, lo que evita imprimir datos sensibles en un entorno de producción.

# EditProfilePage Class

Este archivo contiene la implementación de la clase `EditProfilePage` en Flutter, diseñada para permitir la edición del perfil de un usuario. A continuación, se proporciona una explicación detallada de la estructura y funciones de la clase.

## Avisos de Ignorar Nombres de Archivos

Se incluye la declaración `// ignore_for_file: file_names` para desactivar las advertencias relacionadas con la convención de nombres de archivos. Esto sugiere que el desarrollador ha optado por ignorar las convenciones de nomenclatura específicas para los nombres de archivos.

## Estructura de la Clase EditProfilePage

### Atributos:

- `user`: Un objeto de tipo `UserDTO` que representa al usuario cuyo perfil se está editando.

### Constructor:

- El constructor `EditProfilePage` acepta un parámetro obligatorio `user` de tipo `UserDTO`.

### Estado de la Página:

- La clase `_EditProfilePageState` maneja el estado de la página de edición de perfil.

### Atributos de Estado:

- `emailController`: Controlador para el campo de entrada de correo electrónico.
- `descriptionController`: Controlador para el campo de entrada de descripción.

### Métodos:

#### `initState` (Inicialización del Estado):

- El método `initState` se utiliza para inicializar el estado de la página.
- Inicializa los controladores de correo electrónico y descripción con los valores actuales del usuario.

#### `build` (Construcción de la Página):

- El método `build` construye la interfaz de usuario de la página de edición de perfil.
- Incluye un formulario con campos para el correo electrónico y la descripción, y un botón para guardar cambios.

#### `_saveChanges` (Guardar Cambios):

- El método `_saveChanges` se invoca al hacer clic en el botón "Save Changes".
- Recopila los datos modificados (nuevo correo electrónico y descripción) y llama al servicio `ApiService` para actualizar los detalles del usuario.
- Muestra un mensaje en la interfaz de usuario indicando el éxito o el fallo de la operación.

## Consideraciones Adicionales:

- Se utiliza `utf8.decode` para manejar la decodificación de runas en las cadenas de correo electrónico y descripción.
- Se muestra un mensaje de éxito o error mediante `ScaffoldMessenger` según el resultado de la actualización.

# HomePage Class

Este archivo contiene la implementación de la clase `HomePage` en Flutter, que representa la página principal de la aplicación. A continuación, se proporciona una explicación detallada de la estructura y funciones de la clase.

## Avisos de Ignorar Nombres de Archivos

Se incluye la declaración `// ignore_for_file: file_names` para desactivar las advertencias relacionadas con la convención de nombres de archivos. Esto sugiere que el desarrollador ha optado por ignorar las convenciones de nomenclatura específicas para los nombres de archivos.

## Estructura de la Clase HomePage

### Atributos:

- `publicationController`: Controlador de texto para el campo de entrada de nuevas publicaciones.
- `allPublications`: Lista de todas las publicaciones disponibles.
- `followingPublications`: Lista de publicaciones de los usuarios seguidos.

### Métodos:

#### `initState` (Inicialización del Estado):

- El método `initState` se utiliza para inicializar el estado de la página principal.
- Llama al método `loadPublications` para cargar las publicaciones al inicio.

#### `build` (Construcción de la Página):

- El método `build` construye la interfaz de usuario de la página principal.
- Incluye una barra de aplicación con pestañas para "All Publications" y "Following Publications".
- Permite la creación de nuevas publicaciones y muestra la lista de publicaciones.

#### `buildPublicationsList` (Construcción de la Lista de Publicaciones):

- El método `buildPublicationsList` construye la lista de publicaciones basada en la pestaña seleccionada.
- Muestra un formulario para crear nuevas publicaciones y un contador de caracteres.
- Visualiza la lista de publicaciones existentes con detalles como autor, fecha de creación y más.

#### `_saveChanges` (Guardar Cambios):

- El método `_saveChanges` se invoca al hacer clic en el botón "Save Changes".
- Recopila los datos modificados (nuevo correo electrónico y descripción) y llama al servicio `ApiService` para actualizar los detalles del usuario.
- Muestra un mensaje en la interfaz de usuario indicando el éxito o el fallo de la operación.

#### `loadPublications` (Cargar Publicaciones):

- El método `loadPublications` carga todas las publicaciones y las publicaciones de los usuarios seguidos.
- Utiliza el servicio `ApiService` para obtener la información de la API.
- Actualiza el estado de la clase con las listas cargadas.

### Consideraciones Adicionales:

- Se utiliza un controlador de texto (`publicationController`) para capturar la entrada de texto del usuario al crear nuevas publicaciones.
- Se implementa un contador de caracteres (`CharacterCounter`) para mostrar la cantidad de caracteres restantes en la nueva publicación.
- Se utiliza el paquete `intl` para dar formato a las fechas en el formato deseado.
- La aplicación proporciona opciones para buscar, ver el perfil, actualizar y cerrar sesión a través de la barra de aplicación.

# EditProfilePage Class

En este archivo se encuentra la implementación de la clase `EditProfilePage` en Flutter, que proporciona la funcionalidad de editar el perfil del usuario. A continuación, se presenta una explicación detallada de la estructura y funciones de la clase.

## Avisos de Ignorar Nombres de Archivos

Se incluye la declaración `// ignore_for_file: file_names` para desactivar las advertencias relacionadas con la convención de nombres de archivos. Esto indica que el desarrollador ha optado por ignorar las convenciones de nomenclatura específicas para los nombres de archivos.

## Estructura de la Clase EditProfilePage

### Atributos:

- `user`: Un objeto de tipo `UserDTO` que representa al usuario cuyo perfil se está editando.
- `emailController`: Controlador de texto para el campo de entrada del nuevo correo electrónico.
- `descriptionController`: Controlador de texto para el campo de entrada de la nueva descripción.

### Métodos:

#### `initState` (Inicialización del Estado):

- El método `initState` se utiliza para inicializar el estado de la página de edición de perfil.
- Inicializa los controladores de texto (`emailController` y `descriptionController`) con los valores actuales del usuario.

#### `build` (Construcción de la Página):

- El método `build` construye la interfaz de usuario de la página de edición de perfil.
- Muestra el nombre de usuario, campos de entrada para el correo electrónico y la descripción, y un botón para guardar los cambios.

#### `_saveChanges` (Guardar Cambios):

- El método `_saveChanges` se invoca al hacer clic en el botón "Save Changes".
- Recopila los datos modificados (nuevo correo electrónico y descripción) y llama al servicio `ApiService` para actualizar los detalles del usuario.
- Muestra un mensaje en la interfaz de usuario indicando el éxito o el fallo de la operación.

### Consideraciones Adicionales:

- Se utiliza el paquete `dart:convert` para decodificar el correo electrónico y la descripción del usuario desde UTF-8.
- Se utilizan controladores de texto para capturar la entrada de texto del usuario al editar el perfil.
- La interfaz de usuario incluye información del usuario, campos de entrada para correo electrónico y descripción, y un botón para guardar cambios.
- Se muestra un mensaje de éxito o error mediante un `SnackBar` después de intentar guardar los cambios.

# LoginPage Class

En este archivo se encuentra la implementación de la clase `LoginPage` en Flutter, que representa la página de inicio de sesión. A continuación, se presenta una explicación detallada de la estructura y funciones de la clase.

## Avisos de Ignorar Nombres de Archivos

Se incluye la declaración `// ignore_for_file: file_names` para desactivar las advertencias relacionadas con la convención de nombres de archivos. Esto indica que el desarrollador ha optado por ignorar las convenciones de nomenclatura específicas para los nombres de archivos.

## Estructura de la Clase LoginPage

### Atributos:

- `usernameController`: Controlador de texto para el campo de entrada del nombre de usuario.
- `passwordController`: Controlador de texto para el campo de entrada de la contraseña.

### Métodos:

#### `build` (Construcción de la Página):

- El método `build` construye la interfaz de usuario de la página de inicio de sesión.
- Muestra el nombre de la aplicación, campos de entrada para nombre de usuario y contraseña, un botón de inicio de sesión y un enlace para registrarse.

#### `_login` (Inicio de Sesión):

- El método `_login` se invoca al hacer clic en el botón "Login".
- Llama al servicio `ApiService` para realizar el inicio de sesión con el nombre de usuario y la contraseña proporcionados.
- Almacena el usuario autenticado en `MyApp.loggedInUser`.
- Redirige a la página principal (`'/home'`) en caso de éxito y muestra un mensaje de error en caso contrario.

### Consideraciones Adicionales:

- Se utilizan controladores de texto para capturar la entrada de nombre de usuario y contraseña.
- Se utiliza un botón elevado para iniciar sesión y un botón de texto para redirigir a la página de registro.
- La interfaz de usuario incluye el nombre de la aplicación, campos de entrada para nombre de usuario y contraseña, y botones para realizar acciones relacionadas con el inicio de sesión y el registro.

# MyApp Class

En este archivo se encuentra la implementación de la clase `MyApp` en Flutter, que representa la aplicación principal. A continuación, se presenta una explicación detallada de la estructura y funciones de la clase.

## Estructura de la Clase MyApp

### Atributos Estáticos:

- `loggedInUser`: Un objeto de tipo `UserDTO` que almacena la información del usuario autenticado. Este atributo es estático y puede ser accesible desde cualquier instancia de la clase.

### Métodos:

#### `main` (Punto de Entrada de la Aplicación):

- La función `main` es el punto de entrada de la aplicación.
- Inicializa el decodificador UTF-8 y lanza la aplicación Flutter (`runApp`) con una instancia de `MyApp`.

#### `build` (Construcción de la Aplicación):

- El método `build` construye la estructura de la aplicación Flutter.
- Utiliza un widget `MaterialApp` como el componente raíz de la aplicación.
- Configura el tema de la aplicación (`theme`) con colores y densidades visuales.
- Define rutas iniciales y asociaciones entre rutas y componentes de la aplicación.

#### Rutas y Componentes Asociados:

1. `/login`: Asocia la ruta `/login` con la página de inicio de sesión (`LoginPage`).
2. `/register`: Asocia la ruta `/register` con la página de registro (`RegisterPage`).
3. `/home`: Asocia la ruta `/home` con la página principal de la aplicación (`HomePage`).
4. `/profile`: Asocia la ruta `/profile` con la página de perfil (`ProfilePage`).
5. `/publicationDetails`: Asocia la ruta `/publicationDetails` con la página de detalles de publicación (`PublicationDetailsPage`), extrayendo el ID de la publicación de los argumentos de la ruta.
6. `/edit-profile`: Asocia la ruta `/edit-profile` con la página de edición de perfil (`EditProfilePage`), utilizando el usuario autenticado almacenado en `loggedInUser`.
7. `/search`: Asocia la ruta `/search` con la página de búsqueda (`SearchPage`).

### Consideraciones Adicionales:

- El objeto `MyApp` es un widget de aplicación Flutter que actúa como el componente principal de la aplicación.
- Utiliza el widget `MaterialApp` para proporcionar un diseño material básico y gestionar la navegación entre páginas.
- Las rutas definidas permiten navegar entre las diferentes páginas de la aplicación.

## ProfilePage Class

1. **Atributos y Variables de Estado:**
   - `userId`: Identificador del usuario cuyo perfil se está viendo.
   - `loggedInUserId`: Identificador del usuario que ha iniciado sesión.
   - `userFuture`: Un objeto `Future` que representa la obtención futura de detalles del usuario.
   - `publicationsFuture`: Un objeto `Future` que representa la obtención futura de las publicaciones del usuario.
   - `isFollowing`: Un indicador booleano que representa si el usuario actual sigue al usuario cuyo perfil se está visualizando.
   - `followersCount`: Número de seguidores del usuario.
   - `followingCount`: Número de usuarios a los que sigue el usuario.

2. **Método `didChangeDependencies`:**
   - Se ejecuta cuando el estado de la página cambia.
   - Obtiene el `userId` y `loggedInUserId` de los argumentos de la ruta.
   - Inicializa las variables `userFuture`, `publicationsFuture`, y actualiza la información de seguidores, seguidos y estado de seguimiento.

3. **Método `_updatePublications`:**
   - Actualiza la lista de publicaciones del usuario.

4. **Método `_updateIsFollowing`:**
   - Actualiza el estado de `isFollowing` verificando si el usuario actual sigue al usuario cuyo perfil se está visualizando.

5. **Método `_toggleFollowStatus`:**
   - Alterna el estado de seguimiento al usuario.

6. **Método `_updateFollowersCount`:**
   - Actualiza el número de seguidores del usuario.

7. **Método `_updateFollowingCount`:**
   - Actualiza el número de usuarios a los que sigue el usuario.

8. **Método `_buildPublicationTile`:**
   - Construye un widget que representa una publicación.

9. **Método `build`:**
   - Construye y devuelve la estructura de la página de perfil, incluyendo la información del usuario, sus publicaciones y botones de interacción.

## PublicationDetailsPage Class

La clase `PublicationDetailsPage` en Flutter representa la página de detalles de una publicación. Permite visualizar la publicación, sus detalles, y agregar/editar comentarios. Aquí hay una descripción detallada del código:

1. **Atributos y Variables de Estado:**
   - `_publicationFuture`: Un objeto `Future` que representa la obtención futura de detalles de la publicación.
   - `_commentController`: Un controlador para el campo de texto del comentario.

2. **Clase `CharacterCounter`:**
   - Un widget que muestra el contador de caracteres restantes para un campo de texto.

3. **Métodos de la Clase `CharacterCounter`:**
   - `initState`: Inicializa el estado y agrega un listener al controlador del texto.
   - `dispose`: Elimina el listener del controlador al finalizar.
   - `updateCounter`: Actualiza el estado del contador.
   - `calculateRemainingCharacters`: Calcula los caracteres restantes.
   - `build`: Construye y devuelve el widget del contador.

4. **Método `initState`:**
   - Inicializa el estado de la clase `PublicationDetailsPage`.
   - Obtiene los detalles de la publicación y crea un controlador para el campo de texto del comentario.

5. **Métodos Privados: `_editPublication`, `_deletePublication`, `_addComment`:**
   - Funciones asincrónicas para editar, eliminar y agregar comentarios a una publicación, respectivamente.

6. **Método `build`:**
   - Construye y devuelve la estructura de la página de detalles de la publicación, incluyendo detalles de la publicación, comentarios y botones de interacción para el autor de la publicación.

## PublicationDTO Class

La clase `PublicationDTO` en Dart representa un objeto de transferencia de datos (DTO) para las publicaciones en una aplicación Flutter. Aquí hay una descripción detallada del código:

1. **Atributos:**
   - `publicationId`: Identificador único de la publicación.
   - `authorId`: Identificador único del autor de la publicación.
   - `text`: Texto de la publicación.
   - `creationDate`: Fecha y hora de creación de la publicación.
   - `editionDate`: Fecha y hora de la última edición de la publicación.

2. **Constructor:**
   - `PublicationDTO`: Constructor de la clase que permite la creación de instancias de `PublicationDTO` con valores opcionales para cada atributo.

3. **Método `fromJson`:**
   - Un método de fábrica que crea un objeto `PublicationDTO` a partir de un mapa de datos (`json`). Convierte las fechas almacenadas en formato personalizado a objetos `DateTime`.

4. **Método `parseDate`:**
   - Método auxiliar utilizado en `fromJson` para analizar las fechas almacenadas en un formato específico y convertirlas a objetos `DateTime`. También imprime y devuelve la fecha formateada.

5. **Método `toJson`:**
   - Convierte un objeto `PublicationDTO` a un mapa de datos (`json`). Las fechas se convierten a cadenas en formato ISO 8601.

La clase `PublicationDTO` es esencial para el intercambio de datos relacionados con las publicaciones en la aplicación, facilitando la conversión de datos entre el formato de objeto Dart y el formato JSON.

## RegisterPage Class

La clase `RegisterPage` en Dart representa la página de registro de una aplicación Flutter. Aquí está una descripción detallada del código:

1. **Atributos:**
   - `usernameController`: Controlador para el campo de entrada del nombre de usuario.
   - `passwordController`: Controlador para el campo de entrada de la contraseña.
   - `emailController`: Controlador para el campo de entrada del correo electrónico.
   - `descriptionController`: Controlador para el campo de entrada de la descripción del usuario.

2. **Constructor:**
   - El constructor de la clase no recibe ningún parámetro adicional.

3. **Método `build`:**
   - Construye la interfaz de la página de registro.
   - Utiliza un diseño centrado con un contenedor que tiene un ancho máximo de 400.
   - Contiene campos de entrada para el nombre de usuario, contraseña, correo electrónico y descripción del usuario.
   - El botón "Register" permite registrar un nuevo usuario utilizando los datos ingresados.
   - Incluye un enlace para redirigir a los usuarios a la página de inicio de sesión si ya tienen una cuenta.

4. **Funcionalidad:**
   - Al hacer clic en el botón "Register", se intenta registrar un nuevo usuario utilizando los datos ingresados.
   - Se manejan posibles excepciones, como una contraseña que debe tener al menos 8 caracteres.
   - Si el registro es exitoso, se realiza automáticamente el inicio de sesión y se redirige al usuario a la página de inicio de sesión.

La clase `RegisterPage` proporciona la interfaz y la lógica necesaria para que los usuarios nuevos se registren en la aplicación.

## SearchPage Class

La clase `SearchPage` en Dart representa la página de búsqueda de usuarios en una aplicación Flutter. A continuación, se presenta una descripción detallada del código:

1. **Atributos:**
   - `allUsers`: Lista que almacena todos los usuarios disponibles.
   - `searchedUsers`: Lista que almacena los resultados de la búsqueda actual.

2. **Constructor:**
   - El constructor de la clase no recibe ningún parámetro adicional.

3. **Método `initState`:**
   - Inicializa el estado de la página cargando todos los usuarios disponibles.

4. **Método `loadAllUsers`:**
   - Función asincrónica que utiliza `ApiService` para cargar todos los usuarios y actualiza las listas `allUsers` y `searchedUsers`.

5. **Método `searchByName`:**
   - Realiza la búsqueda de usuarios por nombre y actualiza la lista `searchedUsers`.

6. **Método `build`:**
   - Construye la interfaz de la página de búsqueda de usuarios.
   - Incluye un campo de texto para ingresar consultas de búsqueda por nombre.
   - Muestra la lista de usuarios coincidentes con la búsqueda.
   - Permite hacer clic en un usuario para ver su perfil.

7. **Funcionalidad:**
   - Al ingresar texto en el campo de búsqueda, se realiza una búsqueda en tiempo real y se actualiza la lista de usuarios mostrados.
   - La lista de usuarios muestra el nombre y la descripción de cada usuario.
   - Al hacer clic en un usuario, se redirige a la página de perfil del usuario seleccionado.

La clase `SearchPage` facilita la búsqueda de usuarios por nombre y proporciona una interfaz interactiva para explorar y seleccionar perfiles de usuarios.

## UserDTO Class

La clase `UserDTO` en Dart representa un objeto de transferencia de datos (DTO) para los usuarios en una aplicación Flutter. Aquí se proporciona una descripción detallada del código:

1. **Atributos:**
   - `userId`: Identificador único del usuario.
   - `userName`: Nombre de usuario del usuario.
   - `email`: Dirección de correo electrónico del usuario.
   - `description`: Descripción del usuario.
   - `creationDate`: Fecha y hora de creación del usuario.
   - `password`: Contraseña del usuario (puede ser nulo en algunos contextos).

2. **Constructor:**
   - El constructor de la clase recibe varios parámetros para inicializar los atributos.
   - El `userId` es un parámetro opcional y puede ser nulo.

3. **Método `fromJson`:**
   - Constructor de fábrica que crea un objeto `UserDTO` a partir de un mapa de datos (`json`).
   - Convierte los datos del mapa en los atributos correspondientes de la clase.

4. **Funcionalidad:**
   - La clase `UserDTO` se utiliza para representar información relacionada con los usuarios en la aplicación.
   - Puede utilizarse para la serialización y deserialización de datos al comunicarse con un servicio web o al almacenar datos en algún medio persistente.

Esta clase se utiliza comúnmente para transportar datos de usuario entre la aplicación y un servicio backend, permitiendo una separación limpia entre la representación de datos y la lógica de la aplicación.

Para realizar el build de una aplicación Flutter para diferentes plataformas, se utilizan comandos específicos en la terminal. Aquí tienes una breve explicación de cómo realizar el build para Android, web, iOS y Windows:

1. **Build para Android:**
   - Ejecuta el siguiente comando en la terminal en el directorio de tu proyecto Flutter:

     ```bash
     flutter build apk
     ```

   - Este comando generará un archivo APK que puedes instalar en dispositivos Android.

2. **Build para iOS:**
   - Para construir la aplicación para iOS, ejecuta el siguiente comando:

     ```bash
     flutter build ios
     ```

   - Este comando generará un archivo `.app` que se puede ejecutar en un simulador de iOS o en un dispositivo iOS físico.

3. **Build para Web:**
   - Para construir la versión web de la aplicación, utiliza:

     ```bash
     flutter build web
     ```

   - Esto generará una carpeta `build/web` con los archivos necesarios para desplegar en un servidor web.

4. **Build para Windows:**
   - Para construir la aplicación para Windows, utiliza:

     ```bash
     flutter build windows
     ```

   - Esto generará los archivos necesarios para ejecutar la aplicación en plataformas Windows.

Recuerda que, para construir la aplicación para iOS, necesitarás un entorno de desarrollo en un sistema operativo macOS y Xcode instalado.
