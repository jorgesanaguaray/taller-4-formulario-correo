import 'package:flutter/material.dart'; // Proporciona TextField para la búsqueda.
import 'package:flutter_test/flutter_test.dart'; // Proporciona el entorno de prueba.
import 'package:formulario_correo_uae/main.dart'; // Importa la aplicación del taller.

void main() {
  // Registra los casos del formulario.
  testWidgets('Valida el campo y muestra el correo', (tester) async {
    // Prueba el envío.
    await tester.pumpWidget(
      const FormularioCorreoUAE(),
    ); // Monta la aplicación.
    final campo = find.byType(TextField); // Localiza el campo de correo.
    final boton = find.text('Enviar'); // Localiza el botón del formulario.

    await tester.tap(boton); // Intenta enviar el campo inicialmente vacío.
    await tester.pump(); // Reconstruye la pantalla después de setState.
    expect(
      find.text('Ingresa un correo electrónico.'),
      findsOneWidget,
    ); // Comprueba el aviso.

    await tester.enterText(
      campo,
      '  estudiante@uae.edu.ec  ',
    ); // Escribe el ejemplo con espacios.
    await tester.tap(boton); // Envía el correo escrito.
    await tester.pump(); // Reconstruye la pantalla con el nuevo resultado.
    expect(
      find.text('Correo ingresado: estudiante@uae.edu.ec'),
      findsOneWidget,
    ); // Verifica el texto.
    expect(
      find.text('Ingresa un correo electrónico.'),
      findsNothing,
    ); // Comprueba que se quitó el aviso.

    await tester.enterText(
      campo,
      '   ',
    ); // Borra el correo y deja solo espacios.
    await tester.tap(boton); // Vuelve a enviar el formulario.
    await tester.pump(); // Reconstruye la pantalla con el aviso.
    expect(
      find.text('Ingresa un correo electrónico.'),
      findsOneWidget,
    ); // Rechaza espacios solos.
    expect(
      find.text('Correo ingresado: estudiante@uae.edu.ec'),
      findsNothing,
    ); // Quita el correo anterior.
  }); // Cierra el caso de prueba del formulario.
} // Termina el registro de pruebas.
