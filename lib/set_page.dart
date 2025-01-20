import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'definitions.dart';
import 'edit_flashcard_form.dart';

class SetPage extends StatefulWidget {
  @override
  State<SetPage> createState() => _SetPageState();
}

class _SetPageState extends State<SetPage> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    FlashcardSet curSet = appState.curSet!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          curSet.name,
          style: style,
        ),
        backgroundColor: theme.colorScheme.primary,
      ),
      body: ListView(
        children: [
          for (var flashcard in curSet.flashcards)
            SetListCard(
              flashcard: flashcard,
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditFlashcardForm(),
            ),
          );
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}

class SetListCard extends StatelessWidget {
  const SetListCard({
    super.key,
    required this.flashcard,
  });

  final Flashcard flashcard;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onSecondary,
      fontStyle: FontStyle.italic,
    );

    return Card(
      color: theme.colorScheme.secondary,
      elevation: 10.0,
      margin: EdgeInsets.all(20.0),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          flashcard.front.title,
          style: style,
        ),
      ),
    );
  }
}
