import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'definitions.dart';

class EditFlashcardForm extends StatefulWidget {
  EditFlashcardForm({
    this.addCard = false,
    final initialCard,
  }) : _initialCard = initialCard ?? Flashcard();
  final bool addCard;
  final Flashcard _initialCard;

  @override
  State<EditFlashcardForm> createState() => _EditFlashcardFormState();
}

class _EditFlashcardFormState extends State<EditFlashcardForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return "This field is required.";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    Flashcard flashcard = widget._initialCard;

    void assignCardToValue(String val, String newValue) {
      if (val == "frontTitle") flashcard.front.title = newValue.toString();
      if (val == "frontDescription") flashcard.front.description = newValue.toString();
      if (val == "backTitle") flashcard.back.title = newValue.toString();
      if (val == "backDescription") flashcard.back.description = newValue.toString();
    }

    String initialTextField(String val) {
      Flashcard card = widget._initialCard;
      if (val == "frontTitle") return card.front.title;
      if (val == "frontDescription") return card.front.description;
      if (val == "backTitle") return card.back.title;
      if (val == "backDescription") return card.back.description;
      return "";
    }

    Widget textFormFieldMaker(String val, String hintText, bool bigField) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          onChanged: (value) {
            assignCardToValue(val, value);
          },
          controller: TextEditingController(
            text: initialTextField(val),
          ),
          decoration: InputDecoration(
            hintText: hintText,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: theme.colorScheme.primary,
              ),
            ),
          ),
          maxLines: bigField ? 4 : 1,
          validator: bigField ? null : validator,
        ),
      );
    }

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
                    if (widget.addCard) {
                      appState.addCardToSet(appState.curSet!.name, flashcard);
                    } else {
                      appState.updateSet(appState.curSet!.name, flashcard);
                    }
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
