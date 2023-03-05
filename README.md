# PoC_IngSoftware_GPbuS
Prueba de Concepto de la aplicacion de GPbuS

GPbuS es una aplicación móvil diseñada para mostrar información de rutas de transporte público en tiempo real. Esta aplicación también permite a los usuarios recibir notificaciones sobre los cambios de ruta.

## Descripción
La aplicación de Rutas de Transporte Público se ha diseñado utilizando el patrón de arquitectura Modelo-Vista-Controlador (MVC). Esta aplicación contiene dos tipos de usuarios: los clientes y los administradores. Los clientes pueden acceder a la información de las rutas de transporte público, visualizar el mapa de la ciudad con la ubicación de los transportes y recibir notificaciones sobre los cambios de ruta. Por otro lado, los administradores pueden gestionar la información de los usuarios, realizar cambios en la información de las rutas y actualizar los datos de los transportes.

## Diseño y Arquitectura
La aplicación de Rutas de Transporte Público se ha diseñado para ofrecer una experiencia de usuario intuitiva y sencilla. Esta aplicación está construida usando Flutter como Frontend y NodeJS para el servidor. Esta aplicación también se conecta a una API de Google Maps para obtener la ubicación y crear la interfaz de usuario.

Para almacenar los datos necesarios para el funcionamiento de esta aplicación, se utiliza una base de datos MySQL. Esta base de datos se conecta al servidor NodeJS para proporcionar los datos a la aplicación. La aplicación también se conecta al servidor para realizar tareas como el registro de usuarios, la gestión de usuarios y la actualización de la información de las rutas.

Esta aplicación está diseñada para ser escalable, segura y fácil de mantener. Para garantizar la seguridad de los datos, la aplicación utiliza una capa de seguridad basada en protocolos HTTPS. Esta capa de seguridad también se encarga de proteger la información de los usuarios almacenada en la base de datos.

En resumen, el diseño y la arquitectura de esta aplicación están diseñados para ofrecer una experiencia de usuario intuitiva, segura y escalable. La aplicación está construida utilizando Flutter para el Frontend, NodeJS para el servidor y MySQL para la base de datos. Esta aplicación también se conecta a una API de Google Maps para obtener la ubicación y crear la interfaz de usuario.

![Diagrama_Implementacion](https://github.com/JellyPork/PoC_IngSoftware_Simgru/blob/main/resources/Diagrama_Implementacion.png)

## Tecnologías
Rutas de Transporte Público fue creado utilizando Flutter/Dart.

## Requerimientos
Para ejecutar esta aplicación, necesitarás tener instalado Flutter/Dart en tu computadora.

## Ejecutar
Para ejecutar la aplicación, descarga el código fuente del repositorio de GitHub. Una vez descargado, abre el proyecto en un editor de código y ejecuta el comando `flutter run` en la línea de comandos. La aplicación se abrirá en tu dispositivo móvil o emulador.

## Funcionamiento del PoC
![Screenshot 1](https://github.com/JellyPork/PoC_IngSoftware_Simgru/blob/main/resources/Pic2PoC.jpg)
![Screenshot 2](https://github.com/JellyPork/PoC_IngSoftware_Simgru/blob/main/resources/Pic1PoC.jpg)
![Aplicacion Ejecutada](https://github.com/JellyPork/PoC_IngSoftware_Simgru/blob/main/resources/GPbuS_funcionamiento.gif)
