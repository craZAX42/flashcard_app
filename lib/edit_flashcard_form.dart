import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'definitions.dart';

class EditFlashcardForm extends StatefulWidget {
  @override
  State<EditFlashcardForm> createState() => _EditFlashcardFormState();
}

class _EditFlashcardFormState extends State<EditFlashcardForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Flashcard flashcard = Flashcard();

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return "This field is required.";
    }
    return null;
  }

  void assignCardToValue(String val, String? newValue) {
    if (val == "frontTitle") flashcard.front.title = newValue.toString();
    if (val == "frontDescription") flashcard.front.description = newValue.toString();
    if (val == "backTitle") flashcard.back.title = newValue.toString();
    if (val == "backDescription") flashcard.back.description = newValue.toString();
  }

  Widget textFormFieldMaker(String val, String hintText, bool bigField) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        onChanged: (value) {
          assignCardToValue(val, value);
        },
        decoration: InputDecoration(
          hintText: hintText,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: theme.colorScheme.primary,
            ),
          ),
        ),
        maxLines: bigField ? 4 : 1,
        validator: validator,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    Form newFlashcardForm() {
      return Form(
        key: _formKey,
        child: Column(
          children: [
            textFormFieldMaker(
              "frontTitle",
              "The front of the card.",
              false,
            ),
            textFormFieldMaker(
              "frontDescription",
              "The front description of the card.",
              true,
            ),
            textFormFieldMaker(
              "backTitle",
              "The back of the card.",
              false,
            ),
            textFormFieldMaker(
              "backDescription",
              "The back description of the card.",
              true,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    appState.addCardToSet(appState.curSet!.name, flashcard);
                    Navigator.pop(context, flashcard);
                  }
                },
                child: const Text(
                  "Done",
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Flashcard Details",
          style: style,
        ),
        backgroundColor: theme.colorScheme.primary,
      ),
      body: newFlashcardForm(),
    );
  }
}
