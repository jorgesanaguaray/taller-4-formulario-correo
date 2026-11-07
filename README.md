# FormularioCorreoUAE

Taller 4, semana 4 · Lenguaje de Programación 5 · Universidad Agraria del Ecuador.

Aplicación Flutter que lee un correo desde un `TextField` y lo muestra al pulsar **Enviar**. Si el campo está vacío o solo contiene espacios, la pantalla solicita un correo. La interfaz y la lógica del formulario están en [`lib/main.dart`](lib/main.dart).

## Ejecutar en Android

Usa Flutter 3.47.7 con Dart 3.13.5 o una versión estable compatible. Abre esta carpeta en Android Studio con los plugins de Flutter y Dart, e inicia un emulador desde **Device Manager**. Desde la raíz del proyecto ejecuta los siguientes comandos.

```sh
flutter doctor -v
flutter pub get
flutter devices
flutter run
```

Si Flutter detecta varios dispositivos, usa `flutter run -d ID_DEL_EMULADOR` con el identificador que muestra `flutter devices`.

## Probar el formulario

1. Pulsa **Enviar** con el campo vacío. Aparece el aviso `Ingresa un correo electrónico.`
2. Escribe `estudiante@uae.edu.ec` y pulsa **Enviar**. Se muestra «Correo ingresado: estudiante@uae.edu.ec».
3. Revisa la consola de `flutter run`. En modo debug, `print()` registra el inicio, la solicitud de envío, el resultado de la validación y la actualización de la pantalla.

La prueba de widgets verifica el envío vacío, el correo con espacios alrededor y un campo que contiene únicamente espacios.

```sh
flutter analyze
flutter test
```

## Comprobar Hot Reload

1. Con la app ejecutándose en modo debug, envía `estudiante@uae.edu.ec` y deja el resultado visible.
2. Cambia temporalmente el título `Formulario de correo` en [`lib/main.dart`](lib/main.dart), guarda y pulsa `r` en la terminal de `flutter run`.
3. Comprueba que aparece el nuevo título y que el campo y el resultado conservan el correo. Restaura el título y vuelve a pulsar `r`.

La prueba se ejecutó en un Pixel 9 con Android 17 (API 37). El título cambió mientras el campo y el resultado conservaron `estudiante@uae.edu.ec`. Flutter informó 2079 ms al cambiar el título y 870 ms al restaurarlo.

## Android nativo y Flutter

En un formulario de Android nativo basado en vistas, el XML define el diseño y `findViewById` localiza el `EditText` para leer el correo. Después de validar, `setText` cambia el contenido del `TextView`. En Flutter, Dart describe toda la interfaz como un árbol de widgets. Un `TextEditingController` permite leer el campo con `_ctrl.text` y la llamada a `setState` guarda el nuevo mensaje y programa una reconstrucción de la pantalla con ese valor.
