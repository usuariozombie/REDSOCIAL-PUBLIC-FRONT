import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:vedruna_redsocial_front/EditProfilePage.dart';
import 'package:vedruna_redsocial_front/HomePage.dart';
import 'package:vedruna_redsocial_front/LoginPage.dart';
import 'package:vedruna_redsocial_front/RegisterPage.dart';
import 'package:vedruna_redsocial_front/SearchPage.dart';
import 'UserDTO.dart';
import 'ProfilePage.dart';
import 'PublicationDetailsPage.dart';

/// Clase principal de la aplicación
void main() {
  utf8.decoder;
  runApp(const MyApp());
}

/// Clase que representa la aplicación
class MyApp extends StatelessWidget {
  static UserDTO? loggedInUser;

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Post-It!',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/home': (context) => const HomePage(),
        '/profile': (context) => const ProfilePage(),
        '/publicationDetails': (context) {
          final Map<String, dynamic> args = ModalRoute.of(context)!
              .settings
              .arguments as Map<String, dynamic>;
          final int publicationId = args['publicationId'];
          return PublicationDetailsPage(publicationId: publicationId);
        },
        '/edit-profile' :(context) => EditProfilePage(user: MyApp.loggedInUser!),
        '/search': (context) => const SearchPage(),
      },
    );
  }
}