import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'definitions.dart';
import 'set_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var textController = TextEditingController();

    createSetDialog() {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Create New Set"),
            content: SizedBox(
              width: 100,
              height: 40,
              child: TextField(
                controller: textController,
                decoration: InputDecoration(
                  hintText: "Enter your set name here",
                  //hintStyle: hintStyle,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
              ),
            ),
            actions: [
              TextButton(
                child: Text("Submit"),
                onPressed: () {
                  appState.addSet(textController.text);
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Flashcard Sets",
          style: style,
        ),
        backgroundColor: theme.colorScheme.primary,
      ),
      body: ListView(
        children: [
          for (var set in appState.sets)
            MainListCard(
              set: set,
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Create a new Set of flashcards",
        child: Icon(Icons.add),
        onPressed: () {
          createSetDialog();
        },
      ),
    );
  }
}

class MainListCard extends StatelessWidget {
  const MainListCard({
    super.key,
    required this.set,
  });

  final FlashcardSet set;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    final theme = Theme.of(context);

    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onSecondary,
      fontStyle: FontStyle.italic,
    );

    final subStyle = theme.textTheme.headlineSmall!.copyWith(
      color: theme.colorScheme.onSecondary,
    );

    return GestureDetector(
      child: Card(
        color: theme.colorScheme.secondary,
        elevation: 10.0,
        margin: EdgeInsets.all(20.0),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  set.name,
                  style: style,
                ),
              ),
              Text(
                '${set.flashcards.length} cards',
                style: subStyle,
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        appState.curSet = set;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SetPage(),
          ),
        );
      },
    );
  }
}
