// ignore_for_file: avoid_print
// El taller pide usar print() para seguir el flujo en la consola de debug.

import 'package:flutter/foundation.dart'; // Detecta el modo debug.
import 'package:flutter/material.dart'; // Proporciona los widgets de Material.

// Punto de entrada de la aplicación.
void main() {
  if (kDebugMode) {
    // Registra el inicio durante la depuración.
    print('Iniciando FormularioCorreoUAE.'); // Identifica el arranque.
  } // Termina el registro de inicio.
  runApp(const FormularioCorreoUAE()); // Monta la aplicación.
} // Cierra el punto de entrada.

// Configura la aplicación y su tema.
class FormularioCorreoUAE extends StatelessWidget {
  const FormularioCorreoUAE({super.key}); // Crea el widget raíz.

  @override // Implementa la construcción del widget raíz.
  Widget build(BuildContext context) {
    // MaterialApp proporciona el tema y el contexto de Material.
    return MaterialApp(
      title: 'FormularioCorreoUAE', // Establece el nombre de la app.
      debugShowCheckedModeBanner: false, // Oculta el rótulo de debug.
      theme: ThemeData(colorSchemeSeed: const Color(0xFF1565C0)), // Tema azul.
      home: const PantallaCorreo(), // Abre el formulario al iniciar.
    ); // Cierra la configuración de MaterialApp.
  } // Termina la construcción del widget raíz.
} // Cierra la clase de la aplicación.

// El formulario mantiene su estado entre reconstrucciones.
class PantallaCorreo extends StatefulWidget {
  const PantallaCorreo({super.key}); // Crea la pantalla.

  @override // Vincula la pantalla con su estado.
  State<PantallaCorreo> createState() => _PantallaCorreoState(); // Crea el estado.
} // Cierra la clase de la pantalla.

// Conserva el controlador y el mensaje del último envío.
class _PantallaCorreoState extends State<PantallaCorreo> {
  final _ctrl = TextEditingController(); // Da acceso al texto del campo.
  String _resultado = ''; // Empieza sin mensaje.

  // Procesa el botón Enviar o la acción del teclado.
  void _enviarCorreo() {
    if (kDebugMode) {
      // Registra el paso en modo debug.
      print('Envío solicitado.'); // Identifica la acción del usuario.
    } // Termina el registro de la acción.
    final correo = _ctrl.text.trim(); // Lee el campo y quita espacios externos.
    final estaVacio = correo.isEmpty; // Comprueba si falta el correo.
    if (kDebugMode) {
      // Registra si el campo está vacío.
      print(
        estaVacio ? 'Campo vacío.' : 'Campo con texto.',
      ); // Omite el correo.
    } // Termina el registro de la validación.

    // setState solicita reconstruir la pantalla con el resultado actualizado.
    setState(() {
      // Avisa si el campo está vacío y muestra el correo cuando hay texto.
      _resultado = estaVacio
          ? 'Ingresa un correo electrónico.' // Mensaje de validación.
          : 'Correo ingresado: $correo'; // Resultado del envío.
    }); // Finaliza la actualización del estado.
    FocusScope.of(context).unfocus(); // Cierra el teclado.
    if (kDebugMode) {
      // Registra que se actualizó el estado.
      print('Resultado actualizado.'); // Confirma el último paso.
    } // Termina el registro del resultado.
  } // Termina el envío del formulario.

  @override // Libera recursos cuando se retira la pantalla.
  void dispose() {
    _ctrl.dispose(); // Libera el controlador del campo.
    super.dispose(); // Completa la limpieza de la clase base.
  } // Termina la liberación de recursos.

  @override // Dibuja la interfaz con el estado actual.
  Widget build(BuildContext context) {
    // Scaffold organiza la barra superior y el contenido.
    return Scaffold(
      // La barra superior presenta el título del formulario.
      appBar: AppBar(
        title: const Text('Formulario de correo'), // Título visible.
        backgroundColor: const Color(0xFF1565C0), // Fondo azul.
        foregroundColor: Colors.white, // Texto blanco.
      ), // Cierra la barra superior.
      // Padding separa el formulario de los bordes.
      body: Padding(
        padding: const EdgeInsets.all(24), // Aplica un margen uniforme.
        // Permite desplazarse si el teclado reduce la altura disponible.
        child: SingleChildScrollView(
          // Centra el formulario horizontalmente.
          child: Center(
            // Mantiene un ancho cómodo en pantallas grandes.
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480), // Ancho máximo.
              // Ordena los elementos de arriba hacia abajo.
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.stretch, // Alinea bordes.
                // Agrupa la etiqueta, el campo, el botón y el resultado.
                children: [
                  const Text('Ingresa tu correo'), // Etiqueta del campo.
                  const SizedBox(height: 8), // Espacio antes del campo.
                  // Recibe el correo que escribe el usuario.
                  TextField(
                    controller: _ctrl, // Vincula el campo y el controlador.
                    keyboardType:
                        TextInputType.emailAddress, // Teclado de correo.
                    textInputAction:
                        TextInputAction.done, // Acción de finalizar.
                    autocorrect: false, // Preserva lo que escribe el usuario.
                    onSubmitted: (_) =>
                        _enviarCorreo(), // Permite enviar con Enter.
                    // Presenta un ejemplo y delimita el área de entrada.
                    decoration: const InputDecoration(
                      hintText: 'nombre@uae.edu.ec', // Ejemplo de correo.
                      border: OutlineInputBorder(), // Borde del campo.
                    ), // Cierra la decoración.
                  ), // Cierra el campo.
                  const SizedBox(height: 16), // Espacio antes del botón.
                  // Envía el valor escrito para validarlo.
                  ElevatedButton(
                    onPressed: _enviarCorreo, // Ejecuta el envío.
                    // Aplica los colores del botón.
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2E7D32), // Fondo verde.
                      foregroundColor: Colors.white, // Texto blanco.
                    ), // Cierra el estilo del botón.
                    child: const Text('Enviar'), // Texto visible del botón.
                  ), // Cierra el botón.
                  const SizedBox(height: 16), // Espacio antes del resultado.
                  // Permite al lector de pantalla anunciar el cambio.
                  Semantics(
                    liveRegion: true, // Marca el resultado como dinámico.
                    // Muestra el aviso o el correo guardado en el estado.
                    child: Text(
                      _resultado, // Lee el mensaje del último envío.
                      // Destaca el mensaje debajo del botón.
                      style: const TextStyle(
                        color: Color(0xFF17365D), // Texto azul oscuro.
                        fontWeight: FontWeight.bold, // Texto en negrita.
                      ), // Cierra el estilo del mensaje.
                    ), // Cierra el texto del resultado.
                  ), // Cierra la región accesible.
                ], // Termina la lista de elementos.
              ), // Cierra la columna.
            ), // Cierra la restricción de ancho.
          ), // Cierra el centrado.
        ), // Cierra el contenedor desplazable.
      ), // Cierra el margen interior.
    ); // Cierra la estructura de la pantalla.
  } // Termina la construcción de la pantalla.
} // Cierra el estado del formulario.
