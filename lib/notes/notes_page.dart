import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:project/notes/notes_notifier.dart';

import 'note_model.dart';

final notesProvider =
    StateNotifierProvider<NotesNotifier, List<NoteModel>>((ref) {
  return NotesNotifier();
});

class NotesPage extends HookConsumerWidget {
  NotesPage({Key? key}) : super(key: key);

  final noteController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notes = ref.watch(notesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Notes',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              controller: noteController,
              decoration: const InputDecoration(
                hintText: 'Escreva seu insight',
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(notes[index].title),
                    trailing: IconButton(
                      onPressed: () {
                        ref.read(notesProvider.notifier).removeNote(
                              notes[index],
                            );
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(notesProvider.notifier).addNote(
                NoteModel(title: noteController.text),
              );
          noteController.clear();
        },
        child: const Icon(Icons.save, size: 30, color: Colors.white),
      ),
    );
  }
}
