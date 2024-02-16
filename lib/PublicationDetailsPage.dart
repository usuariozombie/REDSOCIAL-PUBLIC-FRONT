// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vedruna_redsocial_front/main.dart';
import 'ApiService.dart';
import 'PublicationDTO.dart';
import 'UserDTO.dart';
import 'CommentDTO.dart';

/// Página de detalles de publicación
class PublicationDetailsPage extends StatefulWidget {
  // ignore: use_super_parameters

  /// Constructor de la clase
  const PublicationDetailsPage({Key? key, required this.publicationId})
      : super(key: key);

  final int publicationId;

  /// Crea el estado de la página
  @override
  // ignore: library_private_types_in_public_api
  _PublicationDetailsPageState createState() => _PublicationDetailsPageState();
}

/// Clase que crea el contador de caracteres
class CharacterCounter extends StatefulWidget {
  final TextEditingController textController;

  const CharacterCounter({required this.textController});

  @override
  _CharacterCounterState createState() => _CharacterCounterState();
}

/// Clase que crea el estado del contador de caracteres
class _CharacterCounterState extends State<CharacterCounter> {
  late int remainingCharacters;

  /// Inicializa el estado
  @override
  void initState() {
    super.initState();
    remainingCharacters = calculateRemainingCharacters();
    widget.textController.addListener(updateCounter);
  }

  /// Actualiza el estado
  @override
  void dispose() {
    widget.textController.removeListener(updateCounter);
    super.dispose();
  }

  /// Actualiza el contador
  void updateCounter() {
    setState(() {
      remainingCharacters = calculateRemainingCharacters();
    });
  }

  /// Calcula los caracteres restantes
  int calculateRemainingCharacters() {
    return 250 - widget.textController.text.length;
  }

  /// Construye el widget
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight, // Alinea el widget a la derecha
      child: Text(
        '$remainingCharacters/250',
        style: TextStyle(
          color: remainingCharacters >= 0 ? Colors.black : Colors.red,
        ),
      ),
    );
  }
}

/// Clase que crea el estado de la página de detalles de publicación
class _PublicationDetailsPageState extends State<PublicationDetailsPage> {
  late Future<PublicationDTO> _publicationFuture;
  late TextEditingController _commentController;

  /// Inicializa el estado
  @override
  void initState() {
    super.initState();
    _publicationFuture = ApiService().getPublicationById(widget.publicationId);
    _commentController = TextEditingController();
  }

  /// Edita la publicación
  Future<void> _editPublication(
      BuildContext context, PublicationDTO publication) async {
    TextEditingController textEditingController =
        TextEditingController(text: (() {
      try {
        return utf8.decode(publication.text!.runes.toList());
      } catch (e) {
        return publication.text ?? '';
      }
    })());

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Publication'),
          content: TextField(
            controller: textEditingController,
            decoration: const InputDecoration(labelText: 'New Text'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                String newText = textEditingController.text;

                try {
                  await ApiService().editPublication(
                      MyApp.loggedInUser!.userId!,
                      publication.publicationId!,
                      PublicationDTO(text: newText));

                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pop({'edited': true});
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Publication edited successfully'),
                    ),
                  );

                  setState(() {
                    _publicationFuture =
                        ApiService().getPublicationById(widget.publicationId);
                  });
                } catch (e) {
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Failed to edit publication'),
                    ),
                  );
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  /// Elimina la publicación
  Future<void> _deletePublication(
      BuildContext context, PublicationDTO publication) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Publication'),
          content:
              const Text('Are you sure you want to delete this publication?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await ApiService().deletePublication(
                      MyApp.loggedInUser!.userId!, publication.publicationId!);

                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pop({'deleted': true});
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pop();

                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Publication deleted successfully'),
                    ),
                  );
                } catch (e) {
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Failed to delete publication'),
                    ),
                  );
                }
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  /// Añade un comentario
  Future<void> _addComment(
      BuildContext context, PublicationDTO publication) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Comment'),
          content: Container(
            constraints: const BoxConstraints(maxHeight: 150.0),
            child: Column(
              children: [
                TextField(
                  controller: _commentController,
                  decoration:
                      const InputDecoration(labelText: 'Enter your comment'),
                ),
                CharacterCounter(textController: _commentController),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                String commentText = _commentController.text.trim();

                if (commentText.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Comment cannot be empty'),
                    ),
                  );
                  return;
                }

                if (commentText.length > 250) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Comment text exceeds 250 characters'),
                    ),
                  );
                  return;
                }

                try {
                  await ApiService().addComment(
                    publication.publicationId!,
                    MyApp.loggedInUser!.userId!,
                    CommentDTO(text: commentText),
                  );

                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pop({'commented': true});
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Comment added successfully'),
                    ),
                  );

                  _commentController.clear();

                  setState(() {
                    _publicationFuture =
                        ApiService().getPublicationById(widget.publicationId);
                  });
                } catch (e) {
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Failed to add comment'),
                    ),
                  );
                }
              },
              child: const Text('Add Comment'),
            ),
          ],
        );
      },
    );
  }

  /// Construye el widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Publication Details'),
      ),
      body: FutureBuilder<PublicationDTO>(
        future: _publicationFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || !snapshot.hasData) {
            return const Center(
              child: Text('Error loading publication details'),
            );
          } else {
            PublicationDTO publication = snapshot.data!;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FutureBuilder<UserDTO>(
                      future: ApiService().getUserById(publication.authorId!),
                      builder: (context, userSnapshot) {
                        if (userSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Text('Author: Loading...');
                        } else if (userSnapshot.hasError) {
                          return const Text('Author: Error loading author');
                        } else {
                          return Text(
                            'Author: ${(() {
                              try {
                                return utf8.decode(
                                    userSnapshot.data!.userName.runes.toList());
                              } catch (e) {
                                return userSnapshot.data!.userName;
                              }
                            })()}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    Text(
                      (() {
                        try {
                          return utf8.decode(publication.text!.runes.toList());
                        } catch (e) {
                          return publication.text ?? '';
                        }
                      })(),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 16),
                    Text(
                        'Creation Date: ${DateFormat('dd-MM-yyyy HH:mm').format(publication.creationDate!)}'),
                    if (DateFormat('dd-MM-yyyy HH:mm')
                            .format(publication.creationDate!) !=
                        DateFormat('dd-MM-yyyy HH:mm')
                            .format(publication.editionDate!))
                      Text(
                          'Edition Date: ${DateFormat('dd-MM-yyyy HH:mm').format(publication.editionDate!)}'),
                    const SizedBox(height: 8),
                    if (MyApp.loggedInUser?.userId == publication.authorId)
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              await _editPublication(context, publication);
                            },
                            child: const Text('Edit'),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () async {
                              _deletePublication(context, publication);
                            },
                            child: const Text('Delete'),
                          ),
                        ],
                      ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _commentController,
                      decoration: InputDecoration(
                        labelText: 'Add a comment...',
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: () async {
                            await _addComment(context, publication);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Comments:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    FutureBuilder<List<CommentDTO>>(
                      future: ApiService()
                          .getCommentsByPublicationId(widget.publicationId),
                      builder: (context, commentsSnapshot) {
                        if (commentsSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (commentsSnapshot.hasError) {
                          return const Center(
                            child: Text('Error loading comments'),
                          );
                        } else {
                          List<CommentDTO> comments =
                              commentsSnapshot.data ?? [];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: comments.map((comment) {
                              return Card(
                                elevation: 3,
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        (() {
                                          try {
                                            return utf8.decode(
                                                comment.text!.runes.toList());
                                          } catch (e) {
                                            return comment.text ?? '';
                                          }
                                        })(),
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      const SizedBox(height: 8),
                                      FutureBuilder<UserDTO>(
                                        future: ApiService()
                                            .getUserById(comment.userId!),
                                        builder: (context, userSnapshot) {
                                          if (userSnapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const Text(
                                                'Author: Loading...');
                                          } else if (userSnapshot.hasError) {
                                            return const Text(
                                                'Author: Error loading author');
                                          } else {
                                            UserDTO author = userSnapshot.data!;
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(height: 16),
                                                Text(
                                                    'Creation Date: ${DateFormat('dd-MM-yyyy HH:mm').format(comment.creationDate!)}'),
                                                Row(
                                                  children: [
                                                    Text(() {
                                                      try {
                                                        return 'Author: ${utf8.decode(author.userName.runes.toList())}';
                                                      } catch (e) {
                                                        return 'Author: ${author.userName}';
                                                      }
                                                    }()),
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pushNamed(
                                                          context,
                                                          '/profile',
                                                          arguments: {
                                                            'userId':
                                                                author.userId
                                                          },
                                                        );
                                                      },
                                                      child: const Text(
                                                          'VIEW PROFILE'),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            );
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
