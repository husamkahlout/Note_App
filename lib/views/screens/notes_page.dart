
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/views/screens/edit_page.dart';
import '../../data/db_notes.dart';
import '../../models/note.dart';
import '../widgets/note_card_widget.dart';
import 'note_details_page.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class NotesPage extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  late List<Note> notes;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshNotes();
  }

  @override
  void dispose() {
    NotesDatabase.instance.close();

    super.dispose();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);

    this.notes = await NotesDatabase.instance.readAllNotes();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            'appName'.tr(),
            style: const TextStyle(fontSize: 24),
          ),
        actions: [
          IconButton(
              onPressed: () {
                if (context.locale.toString() == "ar") {
                  context.setLocale(const Locale("en"));
                } else {
                  context.setLocale(const Locale("ar"));
                }
              },
              icon: const Icon(Icons.language,))
        ],  
        ),
        body: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : notes.isEmpty
                   ? 
                    Image.asset("assets/images/no-results.png",
                    width: 70,
                    height: 70,
                    color: Colors.white.withOpacity(0.6),
                    )
                  : buildNotes(),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 66, 65, 65),
          child: const Icon(Icons.add),
          onPressed: () async {
              await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AddEditNotePage()));
            refreshNotes();
          },
        ),
      );

  Widget buildNotes() => StaggeredGridView.countBuilder(
        padding: const EdgeInsets.all(8),
        itemCount: notes.length,
        staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemBuilder: (context, index) {
          final note = notes[index];
          return GestureDetector(
            onTap: () async {
               await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => NoteDetailPage(noteId: note.id!),
              ));
              refreshNotes();
            },
            child: NoteCardWidget(note: note, index: index),
          );
        },
      );
}